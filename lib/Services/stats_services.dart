import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStatsModel.dart';

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatsRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception('Failed to fetch data from the server');
    }
  }
  Future<List<dynamic>> countriesListApi () async{
    var data ;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Failed to fetch data from the server');
    }
  }
}