import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';

class MonitorSessionPage extends StatelessWidget {
  final SessionEntity session;
  const MonitorSessionPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Session'),
      ),
      body: BlocBuilder<MonitorBloc, MonitorState>(
        builder: (context, state) {
          if (state is MonitorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MonitorStateLoaded &&
              state.selectedSession?.id == session.id) {
            if (state.skills.isEmpty) {
              return const Center(
                  child: Text('No skills found for this session.'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '${session.athleteName} - ${DateFormat('MMMM d, yyyy').format(session.date)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.skills.length,
                    itemBuilder: (context, index) {
                      final skill = state.skills[index];
                      final equipmentEntries =
                          skill.equipmentReps.entries.toList();

                      return Column(
                        children: equipmentEntries.map((entry) {
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Left Column
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Name: ${skill.name}'),
                                        Text('Symbol: ${skill.symbol}'),
                                        Text('Difficulty: ${skill.difficulty}'),
                                      ],
                                    ),
                                  ),
                                  // Middle Column
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Equipment: ${equipmentTypeToString(entry.key)}'),
                                      ],
                                    ),
                                  ),
                                  // Right Column
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('Reps: ${entry.value}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  // Helper method to convert EquipmentType enum to string
  String equipmentTypeToString(EquipmentType equipment) {
    switch (equipment) {
      case EquipmentType.rodFloor:
        return 'Rod Floor';
      case EquipmentType.airRodFloor:
        return 'Air Rod Floor';
      case EquipmentType.airFloor:
        return 'Air Floor';
      case EquipmentType.dmt:
        return 'DMT';
      case EquipmentType.trampoline:
        return 'Trampoline';
      default:
        return 'Unknown';
    }
  }
}