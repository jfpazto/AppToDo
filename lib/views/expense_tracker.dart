import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerPage extends StatefulWidget {
  @override
  _ExpenseTrackerPageState createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Gastos'),
      ),
      body: Column(
        children: [
          buildChart(),
          Text(
            'Valor total: \$1000',  // Replace this with your total value
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    return FractionallySizedBox(
      heightFactor: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          buildChartData(),
        ),
      ),
    );
  }

  BarChartData buildChartData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,  // Disable interaction when touching the bars
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Ene';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Abr';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: false,  // Hide the chart border
      ),
      barGroups: buildBarGroups(),
    );
  }

  List<BarChartGroupData> buildBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 5, colors: [Colors.blue])]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 6, colors: [Colors.blue])]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 7, colors: [Colors.blue])]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(y: 8, colors: [Colors.blue])]),
    ];
  }
}