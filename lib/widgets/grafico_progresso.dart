import 'package:fl_chart/fl_chart.dart';
import 'package:duckfit/theme/cores_app.dart';
import 'package:flutter/material.dart';

class GraficoProgresso extends StatelessWidget {
  const GraficoProgresso({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 75,
        maxY: 110,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.white24, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}kg',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) {
                const meses = ['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL'];
                if (value.toInt() >= 0 && value.toInt() < meses.length) {
                  return Text(
                    meses[value.toInt()],
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 80),
              FlSpot(1, 85),
              FlSpot(2, 87),
              FlSpot(3, 92),
              FlSpot(4, 95),
              FlSpot(5, 99),
              FlSpot(6, 102),
            ],
            isCurved: true,
            color: Colors.greenAccent,
            barWidth: 5,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.greenAccent.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
