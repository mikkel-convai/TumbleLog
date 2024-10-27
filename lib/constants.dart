enum LayoutType { grid, list }

enum TextType { symbol, name, dd }

enum EquipmentType { rodFloor, airFloor, airRodFloor, dmt, trampoline }

// Extension method to convert enum values to readable strings
extension EquipmentTypeExtension on EquipmentType {
  String get displayName {
    switch (this) {
      case EquipmentType.rodFloor:
        return 'Rod Floor';
      case EquipmentType.airFloor:
        return 'Air Floor';
      case EquipmentType.dmt:
        return 'DMT';
      case EquipmentType.trampoline:
        return 'Trampoline';
      case EquipmentType.airRodFloor:
        return 'Air on Rod Floor';
      default:
        return '';
    }
  }
}

String defaultSessionJson = """
[
  {
    "id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "athlete_id": "athlete123",
    "athlete_name": "Grisha",
    "date": "2024-10-27 08:30:22.653"
  },
  {
    "id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "athlete_id": "athlete123",
    "athlete_name": "Grisha",
    "date": "2024-10-27 10:41:19.456"
  },
  {
    "id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "athlete_id": "athlete123",
    "athlete_name": "Grisha",
    "date": "2024-10-28 08:30:22.653"
  }
]
""";

String defaultSkillsJson = """
[
  {
    "name": "Whipback",
    "symbol": "^",
    "difficulty": 0.2
  },
  {
    "name": "Double back somersault tuck",
    "symbol": "--o",
    "difficulty": 2.0
  },
  {
    "name": "Double back somersault pike",
    "symbol": "--<",
    "difficulty": 2.2
  },
  {
    "name": "Double back somersault open",
    "symbol": "--O",
    "difficulty": 2.2
  },
  {
    "name": "Double back somersault straight",
    "symbol": "--/",
    "difficulty": 2.4
  },
  {
    "name": "Full tuck",
    "symbol": "2.",
    "difficulty": 0.9
  },
  {
    "name": "Full-in tuck",
    "symbol": "2-o",
    "difficulty": 2.4
  },
  {
    "name": "Full-in pike",
    "symbol": "2-<",
    "difficulty": 2.6
  },
  {
    "name": "Full-in straight",
    "symbol": "2-/",
    "difficulty": 2.8
  },
  {
    "name": "Full Full tuck",
    "symbol": "2 2 o",
    "difficulty": 3.2
  },
  {
    "name": "Full Full straight",
    "symbol": "2 2 /",
    "difficulty": 3.6
  },
  {
    "name": "DB tuck whip",
    "symbol": "--o ^",
    "difficulty": 2.2
  },
  {
    "name": "DB pike whip",
    "symbol": "--< ^",
    "difficulty": 2.4
  },
  {
    "name": "DB straight whip",
    "symbol": "--/ ^",
    "difficulty": 2.6
  },
  {
    "name": "Full in straight whip",
    "symbol": "2-/ ^",
    "difficulty": 3.0
  },
  {
    "name": "5 skills",
    "symbol": "5 skills",
    "difficulty": 5.0
  },
  {
    "name": "8 skills",
    "symbol": "8 skills",
    "difficulty": 8.0
  }
]
""";

// List<SkillEntity> defaultSkills = [
//   SkillEntity(name: 'Whipback', symbol: '^', difficulty: 0.2),
//   SkillEntity(
//       name: 'Double back somersault tuck', symbol: '--o', difficulty: 2.0),
//   SkillEntity(
//       name: 'Double back somersault pike', symbol: '--<', difficulty: 2.2),
//   SkillEntity(
//       name: 'Double back somersault open', symbol: '--O', difficulty: 2.2),
//   SkillEntity(
//       name: 'Double back somersault straight', symbol: '--/', difficulty: 2.4),
//   SkillEntity(name: 'Full tuck', symbol: '2.', difficulty: 0.9),
//   SkillEntity(name: 'Full-in tuck', symbol: '2-o', difficulty: 2.4),
//   SkillEntity(name: 'Full-in pike', symbol: '2-<', difficulty: 2.6),
//   SkillEntity(name: 'Full-in straight', symbol: '2-/', difficulty: 2.8),
//   SkillEntity(name: 'Full Full tuck', symbol: '2 2 o', difficulty: 3.2),
//   SkillEntity(name: 'Full Full straight', symbol: '2 2 /', difficulty: 3.6),
//   SkillEntity(name: 'DB tuck whip', symbol: '--o ^', difficulty: 2.2),
//   SkillEntity(name: 'DB pike whip', symbol: '--< ^', difficulty: 2.4),
//   SkillEntity(name: 'DB straight whip', symbol: '--/ ^', difficulty: 2.6),
//   SkillEntity(name: 'Full in straight whip', symbol: '2-/ ^', difficulty: 3.0),
//   SkillEntity(name: '5 skills', symbol: '5 skills', difficulty: 5),
//   SkillEntity(name: '8 skills', symbol: '8 skills', difficulty: 8),
// ];
