import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikBatangPage extends StatelessWidget {
  final List<double> data = [1, 1.5, 2, 1.2, 2.3, 1.8, 2.5];

  final List<String> hari = [
    "Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"
  ];

  final double limitKuota = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grafik Penggunaan"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Grafik Penggunaan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Pantau kuota mingguan kamu",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // GRAFIK
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),

                      // LABEL HARI
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              return Text(hari[index]);
                            },
                          ),
                        ),
                      ),

                      // GARIS LIMIT 🔥
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: limitKuota,
                            color: Colors.orange,
                            strokeWidth: 2,
                            dashArray: [5, 5],
                            label: HorizontalLineLabel(
                              show: true,
                              alignment: Alignment.topRight,
                              style: TextStyle(color: Colors.orange),
                              labelResolver: (line) => "Limit 2 GB",
                            ),
                          ),
                        ],
                      ),

                      // DATA BATANG
                      barGroups: data.asMap().entries.map((e) {
                        return BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value,
                              color: e.value >= limitKuota
                                  ? Colors.red
                                  : (e.key % 2 == 0
                                      ? Colors.blue
                                      : Colors.orange),
                              borderRadius: BorderRadius.circular(6),
                              width: 16,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}