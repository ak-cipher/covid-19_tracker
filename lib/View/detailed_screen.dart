import 'package:covid_tracker/Widgets/reuseable_row.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  String image, name;
  int totalcases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailedScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.totalcases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          Card(
            child: Column(
              children: [
                ReuseableRow(title: 'TotalCases', value: totalcases.toString()),
                ReuseableRow(
                    title: 'TotalDeaths', value: totalDeaths.toString()),
                ReuseableRow(
                    title: 'TotalRecovered', value: totalRecovered.toString()),
                ReuseableRow(title: 'active', value: active.toString()),
                ReuseableRow(title: 'critical', value: critical.toString()),
                ReuseableRow(
                    title: 'TodatRecovered', value: todayRecovered.toString()),
                ReuseableRow(title: 'Tests', value: test.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
