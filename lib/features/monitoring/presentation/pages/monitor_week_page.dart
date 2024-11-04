import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';

class MonitorWeekPage extends StatelessWidget {
  final String athleteId;

  const MonitorWeekPage({super.key, required this.athleteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Training Overview')),
      body: BlocBuilder<MonitorBloc, MonitorState>(
        builder: (context, state) {
          // Show a loading indicator while sessions are loading
          if (state is MonitorLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle the loaded state and filter sessions for the athlete
          if (state is MonitorStateLoaded) {
            final weeklySessions = context
                .read<MonitorBloc>()
                .getWeeklySessionsForAthlete(athleteId);

            if (weeklySessions.isEmpty) {
              return const Center(
                  child: Text('No sessions available for this week.'));
            }

            // Might need to be maxDD * 1.1 for dynamic scale
            const maxY = 250.0;

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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Total DD pr. day',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              reservedSize: 50,
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                // Get the session date at the current index
                                if (value.toInt() < weeklySessions.length) {
                                  final sessionDate =
                                      weeklySessions[value.toInt()].date;
                                  final formattedDate = DateFormat('dd/MM')
                                      .format(sessionDate); // Format as dd/MM
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(formattedDate),
                                  );
                                }
                                return const SizedBox.shrink();
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            );
          }

          return const Center(
              child: Text('Please select an athlete and load sessions.'));
        },
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
