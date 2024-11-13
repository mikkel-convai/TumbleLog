import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/widgets/auth_appbar.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:tumblelog/features/home/presentation/widgets/clubs_view.dart';
import 'package:tumblelog/features/home/presentation/widgets/users_view.dart';

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
      appBar: const AuthAppBar(
        title: 'Admin home',
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          return _selectedIndex == 0
              ? ClubsView(clubNameController: _clubNameController)
              : const UsersView();
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
}
