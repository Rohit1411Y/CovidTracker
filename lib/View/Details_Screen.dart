import 'package:covid_tracker/View/worlds_stats.dart';
import 'package:flutter/material.dart';
class CountryDetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   CountryDetailsScreen({required this.image,
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
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.067,),
                    ReUsableRow(title: 'Cases', value: widget.totalCases.toString()),
                    ReUsableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                    ReUsableRow(title: 'Death', value: widget.totalDeaths.toString()),
                    ReUsableRow(title: 'Critical', value: widget.critical.toString()),
                    ReUsableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),

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
