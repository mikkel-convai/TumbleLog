import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/constants.dart';

class MonitorWeekPage extends StatelessWidget {
  MonitorWeekPage({super.key});

  // Dummy data for a week's worth of sessions
  final List<SessionEntity> weeklySessions = [
    SessionEntity(
      id: '1',
      athleteId: 'athlete1',
      athleteName: 'Grisha',
      date: DateTime.now().subtract(const Duration(days: 6)),
      totalDd: 215.8,
      equipmentDd: const {
        EquipmentType.dmt: 25.1,
        EquipmentType.airFloor: 40.2,
        EquipmentType.rodFloor: 45.3,
        EquipmentType.trampoline: 57.0,
        EquipmentType.airRodFloor: 48.2,
      },
    ),
    SessionEntity(
      id: '2',
      athleteId: 'athlete1',
      athleteName: 'Grisha',
      date: DateTime.now().subtract(const Duration(days: 5)),
      totalDd: 195.6,
      equipmentDd: const {
        EquipmentType.dmt: 23.8,
        EquipmentType.airFloor: 38.9,
        EquipmentType.rodFloor: 42.0,
        EquipmentType.trampoline: 55.7,
        EquipmentType.airRodFloor: 35.2,
      },
    ),
    SessionEntity(
      id: '3',
      athleteId: 'athlete1',
      athleteName: 'Grisha',
      date: DateTime.now().subtract(const Duration(days: 4)),
      totalDd: 210.5,
      equipmentDd: const {
        EquipmentType.dmt: 24.5,
        EquipmentType.airFloor: 39.8,
        EquipmentType.rodFloor: 44.6,
        EquipmentType.trampoline: 56.7,
        EquipmentType.airRodFloor: 45.9,
      },
    ),
    SessionEntity(
      id: '4',
      athleteId: 'athlete1',
      athleteName: 'Grisha',
      date: DateTime.now().subtract(const Duration(days: 3)),
      totalDd: 225.7,
      equipmentDd: const {
        EquipmentType.dmt: 26.4,
        EquipmentType.airFloor: 41.5,
        EquipmentType.rodFloor: 47.3,
        EquipmentType.trampoline: 58.2,
        EquipmentType.airRodFloor: 52.3,
      },
    ),
    SessionEntity(
      id: '5',
      athleteId: 'athlete1',
      athleteName: 'Grisha',
      date: DateTime.now().subtract(const Duration(days: 2)),
      totalDd: 200.3,
      equipmentDd: const {
        EquipmentType.dmt: 25.2,
        EquipmentType.airFloor: 40.6,
        EquipmentType.rodFloor: 45.6,
        EquipmentType.trampoline: 57.2,
        EquipmentType.airRodFloor: 31.7,
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate max dd value to set maxY dynamically
    // final maxDd = weeklySessions
    //     .map((session) => session.totalDd)
    //     .reduce((a, b) => a > b ? a : b);
    // final maxY = maxDd * 1.1; // Add 10% margin to the maximum dd value
    const maxY = 250.0; // Add 10% margin to the maximum dd value

    // Accumulate equipment dd across all sessions for the week
    final Map<EquipmentType, double> accumulatedEquipmentDd = {};

    for (var session in weeklySessions) {
      for (var entry in session.equipmentDd.entries) {
        accumulatedEquipmentDd.update(
          entry.key,
          (currentValue) => currentValue + entry.value,
          ifAbsent: () => entry.value,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Training Overview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Total DD pr. day',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxY, // Dynamic maxY based on max dd value
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(days[value.toInt() % 7]),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: maxY / 5,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barGroups: weeklySessions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final session = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: session.totalDd,
                          color: Colors.blueAccent,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Weekly DD by equipment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: accumulatedEquipmentDd.entries.map((entry) {
                    final equipment = entry.key;
                    final ddValue = entry.value;
                    final shortName = _getShortEquipmentName(equipment);

                    return PieChartSectionData(
                      value: ddValue,
                      title: '$shortName\n${ddValue.toStringAsFixed(1)}',
                      color: _getEquipmentColor(equipment),
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to assign colors to each equipment type
  Color _getEquipmentColor(EquipmentType equipment) {
    switch (equipment) {
      case EquipmentType.rodFloor:
        return Colors.redAccent;
      case EquipmentType.airRodFloor:
        return Colors.greenAccent;
      case EquipmentType.airFloor:
        return Colors.blueAccent;
      case EquipmentType.dmt:
        return Colors.orangeAccent;
      case EquipmentType.trampoline:
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }

  String _getShortEquipmentName(EquipmentType equipment) {
    switch (equipment) {
      case EquipmentType.rodFloor:
        return 'Rod';
      case EquipmentType.airRodFloor:
        return 'Air Rod';
      case EquipmentType.airFloor:
        return 'Air Flr';
      case EquipmentType.dmt:
        return 'DMT';
      case EquipmentType.trampoline:
        return 'Tramp';
      default:
        return 'Other';
    }
  }
}
