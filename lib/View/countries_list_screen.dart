import 'package:covid_tracker/Controller/country_search_bloc.dart';
import 'package:covid_tracker/View/detailed_screen.dart';
import 'package:covid_tracker/services/stats_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatelessWidget {
  CountriesListScreen({super.key});

  CountrySearchBloc _bloc = CountrySearchBloc();
  TextEditingController searchTextController = TextEditingController();
  StatsService service = StatsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: ((value) {
                print('changing value');
                _bloc.strValue.add(value);
              }),
              controller: searchTextController,
              decoration: InputDecoration(
                  hintText: 'Enter Your Country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: _bloc.value,
                  builder: ((context, AsyncSnapshot<String> searchSnapshot) {
                    return FutureBuilder(
                      future: service.getCountriesList(),
                      builder:
                          ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (!snapshot.hasData) {
                          return ListView.builder(
                              itemCount: 4,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                        title: Container(
                                          height: 10,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }));
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                String name = snapshot.data![index]['country'];
                                if (searchSnapshot.data == null ||
                                    searchSnapshot.data!.isEmpty) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailedScreen(
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            name : snapshot.data![index]['country'],
                                            totalcases : snapshot.data![index]['cases'],
                                            totalDeaths: snapshot.data![index]['todayDeaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],

                                          ))));
                                        }),
                                        child: ListTile(
                                          leading: Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              image: NetworkImage(
                                                  snapshot.data![index]
                                                      ['countryInfo']['flag'])),
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]
                                                  ['cases']
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (name
                                    .toLowerCase()
                                    .contains(searchSnapshot.data!)) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailedScreen(
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            name : snapshot.data![index]['country'],
                                            totalcases : snapshot.data![index]['cases'],
                                            totalDeaths: snapshot.data![index]['todayDeaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],

                                          ))));
                                        }),
                                        child: ListTile(
                                          leading: Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              image: NetworkImage(
                                                  snapshot.data![index]
                                                      ['countryInfo']['flag'])),
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]
                                                  ['cases']
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }));
                        }
                      }),
                    );
                  })))
        ],
      )),
    );
  }
}
