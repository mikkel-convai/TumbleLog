import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumblelog/controllers/skill_controller.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';

class SessionAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SharedPreferences pref;
  final List<Skill> skills;

  const SessionAppBar({
    super.key,
    required this.pref,
    required this.skills,
  });

  @override
  State<SessionAppBar> createState() => _SessionAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SessionAppBarState extends State<SessionAppBar> {
  Future<void> _saveSkillsForToday() async {
    String date = getCurrentDate();
    await saveSkills(date, widget.pref, widget.skills);
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('MMMM d, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return AppBar(
          title: Text(getCurrentDate()),
          actions: [
            // Toggle button for layout
            IconButton(
              icon: Icon(
                state.layout == LayoutType.grid ? Icons.grid_on : Icons.list,
              ),
              onPressed: () => context.read<LayoutCubit>().toggleLayout(),
              tooltip: "Toggle Layout",
            ),

            // Toggle button for text size
            IconButton(
              icon: Icon(
                state.textDisplay == TextType.symbol
                    ? Icons.text_fields
                    : state.textDisplay == TextType.name
                        ? Icons.person
                        : Icons.list_alt, // DD display
              ),
              onPressed: () => context.read<LayoutCubit>().toggleTextDisplay(),
              tooltip: "Toggle Text Size",
            ),

            // Save button
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSkillsForToday,
            ),
          ],
        );
      },
    );
  }
}
