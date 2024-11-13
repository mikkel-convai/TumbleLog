import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final TextEditingController _clubNameController = TextEditingController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Home')),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          return _selectedIndex == 0
              ? _buildClubsView(state)
              : _buildUsersView(state);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
        ],
      ),
    );
  }

  void _addClub(BuildContext context, String clubName) {
    if (clubName.isNotEmpty) {
      context.read<AdminBloc>().add(AddClubEvent(clubName));
      _clubNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club name cannot be empty')),
      );
    }
  }

  void _deleteClub(BuildContext context, String clubId) {
    context.read<AdminBloc>().add(DeleteClubEvent(clubId));
  }

  void _updateUserRole(BuildContext context, String userId, String newRole) {
    context.read<AdminBloc>().add(UpdateUserRoleEvent(userId, newRole));
  }

  void _updateUserClub(BuildContext context, String userId, String newClubId) {
    context.read<AdminBloc>().add(UpdateUserClubEvent(userId, newClubId));
  }

  Widget _buildClubsView(AdminState state) {
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
              controller: _clubNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Club Name',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () =>
                  _addClub(context, _clubNameController.text.trim()),
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
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteClub(context, club.id),
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
  }

  Widget _buildUsersView(AdminState state) {
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
                                                fontWeight: FontWeight.w500),
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
                                                _updateUserRole(
                                                    context, user.id, newRole);
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
                                                fontWeight: FontWeight.w500),
                                          ),
                                          DropdownButton<String>(
                                            value: user.clubId,
                                            hint: const Text('Select Club'),
                                            items: state.clubs
                                                .map<DropdownMenuItem<String>>(
                                                    (club) {
                                              return DropdownMenuItem<String>(
                                                value: club.id,
                                                child: Text(club.name),
                                              );
                                            }).toList(),
                                            onChanged: (newClubId) {
                                              if (newClubId != null) {
                                                _updateUserClub(context,
                                                    user.id, newClubId);
                                              }
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
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    super.dispose();
  }
}
