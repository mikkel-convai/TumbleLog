import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  void _updateUserRole(BuildContext context, String userId, String newRole) {
    context.read<AdminBloc>().add(UpdateUserRoleEvent(userId, newRole));
  }

  void _updateUserClub(BuildContext context, String userId, String? newClubId) {
    context.read<AdminBloc>().add(UpdateUserClubEvent(userId, newClubId));
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
                  'User List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: state.users.isEmpty
                      ? const Center(child: Text('No users available.'))
                      : ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person, size: 32),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            user.email,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Role: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              DropdownButton<String>(
                                                value: user.role,
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'coach',
                                                    child: Text('Coach'),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'athlete',
                                                    child: Text('Athlete'),
                                                  ),
                                                ],
                                                onChanged: (newRole) {
                                                  if (newRole != null) {
                                                    _updateUserRole(context,
                                                        user.id, newRole);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Club: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              DropdownButton<String?>(
                                                value: user.clubId,
                                                hint: const Text('Select Club'),
                                                items: [
                                                  const DropdownMenuItem<
                                                      String?>(
                                                    value: null,
                                                    child: Text('No Club'),
                                                  ),
                                                  ...state.clubs.map<
                                                      DropdownMenuItem<
                                                          String?>>(
                                                    (club) {
                                                      return DropdownMenuItem<
                                                          String?>(
                                                        value: club.id,
                                                        child: Text(club.name),
                                                      );
                                                    },
                                                  ),
                                                ],
                                                onChanged: (newClubId) {
                                                  _updateUserClub(context,
                                                      user.id, newClubId);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
