

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String image ;
  String name ;
  int totalCases,  totalDeaths, totalRecovered , active , critical , todayRecovered , test;
   DetailsScreen({super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,

});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      ReUseableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReUseableRow(title: 'Active', value: widget.active.toString()),
                      ReUseableRow(title: 'Recovered', value: widget.todayRecovered.toString()),
                      ReUseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReUseableRow(title: 'Critical', value: widget.critical.toString()),
                      ReUseableRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
