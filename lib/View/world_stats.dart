import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Widgets/reuseable_row.dart';
import '../models/world_stats_model.dart';
import '../services/stats_service.dart';

class WorldStats extends StatelessWidget {
  WorldStats({super.key});

  StatsService service = StatsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
                future: service.fetchWorldStatsRecords(),
                builder: ((context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return const Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartRadius: MediaQuery.of(context).size.height * 0.2,
                          chartType: ChartType.ring,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Card(
                          child: Column(
                            children: [
                              ReuseableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!.toString()),
                              ReuseableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString()),
                              ReuseableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString()),
                              ReuseableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString()),
                              ReuseableRow(
                                  title: 'Criticals',
                                  value: snapshot.data!.critical!.toString()),
                              ReuseableRow(
                                  title: 'Today\'s Death ',
                                  value:
                                      snapshot.data!.todayDeaths!.toString()),
                              ReuseableRow(
                                  title: 'Today\'s  Recovered',
                                  value: snapshot.data!.todayRecovered!
                                      .toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed('/CountryListScreen'),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })),
          ],
        ),
      )),
    );
  }
}
