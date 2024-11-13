import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/club_entity.dart';
import 'package:tumblelog/core/models/app_user_model.dart';
import 'package:tumblelog/core/models/club_model.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/injection_container.dart';

class ClubManagementPage extends StatefulWidget {
  const ClubManagementPage({super.key});

  @override
  State<ClubManagementPage> createState() => _ClubManagementPageState();
}

class _ClubManagementPageState extends State<ClubManagementPage> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _athleteEmailController = TextEditingController();
  String? clubId;
  String? clubName;
  List<AppUser> clubMembers = [];

  @override
  void initState() {
    super.initState();
    _initializeClubData();
  }

  Future<void> _initializeClubData() async {
    await _fetchClubDetails();
    _fetchClubMembers();
  }

  Future<void> _fetchClubDetails() async {
    final state = context.read<AuthBloc>().state;

    if (state is AuthAuthenticated) {
      final clubJson = await supabaseClient
          .from('clubs')
          .select()
          .eq('creator_id', state.user.id);

      if (clubJson.isNotEmpty) {
        final club = ClubModel.fromJson(clubJson.first);

        setState(() {
          clubId = club.id;
          clubName = club.name;
        });
      }
    }
  }

  Future<void> _fetchClubMembers() async {
    final state = context.read<AuthBloc>().state;

    if (state is AuthAuthenticated && clubId != null) {
      final userJson = await supabaseClient
          .from('users')
          .select()
          .eq('club_id', clubId!)
          .neq('id', state.user.id);

      if (userJson.isNotEmpty) {
        final userModels =
            userJson.map((json) => AppUserModel.fromJson(json)).toList();
        final users = userModels.map((model) {
          return AppUser(
              id: model.id,
              email: model.email,
              role: model.role,
              name: model.name);
        }).toList();

        setState(() {
          clubMembers = users;
        });
      }
    }
  }

  Future<void> _removeAthlete(String userId) async {
    await supabaseClient
        .from('users')
        .update({'club_id': null}).eq('id', userId);

    // Refresh the list of club members
    _fetchClubMembers();

    if (mounted) {
      context.read<MonitorBloc>().add(MonitorLoadAthletes(clubId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Athlete removed successfully')),
      );
    }
  }

  Future<void> _addAthlete(String email) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email cannot be empty')),
      );
      return;
    }

    final updatedAthlete = await supabaseClient
        .from('users')
        .update({'club_id': clubId})
        .eq('email', email.toLowerCase())
        .select();

    // Refresh the list of club members
    _fetchClubMembers();

    _athleteEmailController.clear();

    if (mounted) {
      context.read<MonitorBloc>().add(MonitorLoadAthletes(clubId));

      if (updatedAthlete.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Athlete added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Athlete with that email does not exist')),
        );
      }
    }
  }

  Future<void> _createClub(String clubName) async {
    if (clubName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club name cannot be empty')),
      );
      return;
    }

    final state = context.read<AuthBloc>().state;

    if (state is AuthAuthenticated) {
      final newClubJson = await supabaseClient
          .from('clubs')
          .insert({'name': clubName, 'creator_id': state.user.id}).select();

      if (newClubJson.isNotEmpty) {
        final newClubModel = ClubModel.fromJson(newClubJson.first);
        final newClub = Club(
          id: newClubModel.id,
          name: newClubModel.name,
        );

        setState(() {
          clubId = newClub.id;
          this.clubName = clubName;
        });

        final updatedUser = await supabaseClient
            .from('users')
            .update({'club_id': newClub.id})
            .eq('id', state.user.id)
            .select();

        if (mounted && updatedUser.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Coaches club not updated')),
          );
        }
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club created successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Management')),
      body: clubId == null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Your Club',
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
                  ElevatedButton(
                    onPressed: () =>
                        _createClub(_clubNameController.text.trim()),
                    child: const Text('Create Club'),
                  ),
                ],
              ),
            )
          :
          // If the coach has a club, show the club details and members
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Club: $clubName',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Add an Athlete',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _athleteEmailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Athlete Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () =>
                        _addAthlete(_athleteEmailController.text.trim()),
                    child: const Text('Add Athlete'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Club Members',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: clubMembers.isEmpty
                        ? const Center(child: Text('No members in your club.'))
                        : ListView.builder(
                            itemCount: clubMembers.length,
                            itemBuilder: (context, index) {
                              final member = clubMembers[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(member.name),
                                  subtitle: Text(member.email),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => _removeAthlete(member.id),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _athleteEmailController.dispose();
    super.dispose();
  }
}
