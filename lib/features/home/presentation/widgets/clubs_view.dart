import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';

class ClubsView extends StatelessWidget {
  final TextEditingController clubNameController;

  const ClubsView({super.key, required this.clubNameController});

  void _addClub(BuildContext context, String clubName) {
    if (clubName.isNotEmpty) {
      context.read<AdminBloc>().add(AddClubEvent(clubName));
      clubNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club name cannot be empty')),
      );
    }
  }

  void _deleteClub(BuildContext context, String clubId) {
    context.read<AdminBloc>().add(DeleteClubEvent(clubId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminStateLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a New Club',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: clubNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Club Name',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () =>
                      _addClub(context, clubNameController.text.trim()),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Club'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Existing Clubs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: state.clubs.isEmpty
                      ? const Center(child: Text('No clubs available.'))
                      : ListView.builder(
                          itemCount: state.clubs.length,
                          itemBuilder: (context, index) {
                            final club = state.clubs[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(club.name),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _deleteClub(context, club.id),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        if (state is AdminError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
