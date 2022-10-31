import 'package:covid_tracker/Models/world_stats_modal.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/services.dart';

import 'countries_list.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WordStatsState();
}

class _WordStatsState extends State<WorldStats> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color>[

    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },

      child: Scaffold(

        body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStatsModal>snapshot){
                      if(!snapshot.hasData){
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      }
                      else{
                        return Column(
                          children: [
                            PieChart(dataMap:  {
                              "Total":double.parse(snapshot.data!.cases.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths.toString()),
                            },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: MediaQuery.of(context).size.width/3.2,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: const Duration(milliseconds: 1000,),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReUsableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                    ReUsableRow(title: 'Deaths', value:snapshot.data!.deaths.toString() ),
                                    ReUsableRow(title: 'Recovered', value:snapshot.data!.recovered.toString() ),
                                    ReUsableRow(title: 'Active', value:snapshot.data!.active.toString() ),
                                    ReUsableRow(title: 'Critical', value:snapshot.data!.critical.toString() ),
                                    ReUsableRow(title: 'Today Deaths', value:snapshot.data!.todayDeaths.toString()),
                                    ReUsableRow(title: 'Today Recovered', value:snapshot.data!.todayRecovered.toString() ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                      },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            )
                          ],
                        );

                        }

                  }),

                ],
              ),
            ),
          ),

      ),
    );
  }
}
class ReUsableRow extends StatelessWidget {
  String title;
  String value;
   ReUsableRow({Key? key , required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],

          ),
          SizedBox(height: .5,),
          Divider(),

        ],
      ),
    );
  }
}

