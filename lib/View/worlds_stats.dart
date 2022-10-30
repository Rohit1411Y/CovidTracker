import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              PieChart(dataMap: const {
                "Total":50,
                "Recovered":44,
                "Deaths":6,
              },
                chartRadius: MediaQuery.of(context).size.width/3.2,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                ),
             animationDuration: const Duration(milliseconds: 1000,),
                chartType: ChartType.disc,
                colorList: colorList,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                child: Card(
                  child: Column(
                    children: [
                      ReUsableRow(title: 'Total', value: "50"),
                      ReUsableRow(title: 'Total', value: "50"),
                      ReUsableRow(title: 'Total', value: "50"),

                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Track Countries"),
                ),
              )
            ],
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
      padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],

          ),
          SizedBox(height: 5,),
          Divider(),

        ],
      ),
    );
  }
}

