import 'dart:convert';

import 'package:covid_tracker/models/world_stats_model.dart';
import 'package:covid_tracker/services/utilities/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsService {
  Future<WorldStatsModel> fetchWorldStatsRecords() async {
    final resposne = await http.get(Uri.parse(ApiUrl.worlstatsUrl));

    if (resposne.statusCode == 200) {
      var data = jsonDecode(resposne.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getCountriesList() async {
    var data;
    final resposne = await http.get(Uri.parse(ApiUrl.countrieStatsUrl));

    if (resposne.statusCode == 200) {
      data = await jsonDecode(resposne.body);
      return data;
    } else {
      print("throwing error");
      throw Exception('Error');
    }
  }
}
