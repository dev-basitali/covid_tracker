import 'package:covid_tracker/Model/WorldStatsModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/stats_services.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  final colorsList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              FutureBuilder(
                  future: statsServices.fetchWorldStatsRecords(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(
                                    snapshot.data!.cases!.toString()),
                                'Recovered': double.parse(
                                    snapshot.data!.recovered!.toString()),
                                'Deaths': double.parse(
                                    snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              chartRadius: width / 3.2,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                              chartType: ChartType.ring,
                              colorList: colorsList,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReUseableRow(
                                        title: 'Total',
                                        value: snapshot.data!.cases.toString()),
                                    ReUseableRow(
                                        title: 'Deaths',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ReUseableRow(
                                        title: 'Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ReUseableRow(
                                        title: 'Active',
                                        value:
                                            snapshot.data!.active.toString()),
                                    ReUseableRow(
                                        title: 'Critical',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReUseableRow(
                                        title: 'Today Deaths',
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReUseableRow(
                                        title: 'Today Recovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const CountryStatsScreen(),
                                ));
                              },
                              child: Container(
                                height: height * 0.075,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseableRow extends StatelessWidget {
  String title, value;
  ReUseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
