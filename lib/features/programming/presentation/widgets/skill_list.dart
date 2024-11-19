import 'package:flutter/material.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';

class SkillList extends StatelessWidget {
  final List<SkillLibraryEntity> skills;
  final String title;
  final IconData actionIcon;
  final void Function(SkillLibraryEntity skill) onSkillAction;

  const SkillList({
    super.key,
    required this.skills,
    required this.title,
    required this.actionIcon,
    required this.onSkillAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: skills.isEmpty
              ? const Center(child: Text('No skills available'))
              : ListView.builder(
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return ListTile(
                      title: Text(skill.name),
                      subtitle: Text('Difficulty: ${skill.difficulty}'),
                      trailing: IconButton(
                        icon: Icon(actionIcon),
                        onPressed: () => onSkillAction(skill),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
