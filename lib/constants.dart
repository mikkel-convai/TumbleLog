enum LayoutType { grid, list }

enum TextType { symbol, name, dd }

enum EquipmentType { rodFloor, airFloor, airRodFloor, dmt, trampoline }

const Map<EquipmentType, int> defaultEquipmentReps = {
  EquipmentType.rodFloor: 0,
  EquipmentType.airRodFloor: 0,
  EquipmentType.airFloor: 0,
  EquipmentType.dmt: 0,
  EquipmentType.trampoline: 0,
};

const Map<EquipmentType, double> defaultEquipmentDd = {
  EquipmentType.rodFloor: 0.0,
  EquipmentType.airRodFloor: 0.0,
  EquipmentType.airFloor: 0.0,
  EquipmentType.dmt: 0.0,
  EquipmentType.trampoline: 0.0,
};

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

String defaultReturnedSkillsJson = """
[
  {
    "id": "fbc26dd9-9e95-4e5d-b222-d8ecdd350159",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "name": "Whipback",
    "symbol": "^",
    "difficulty": 0.2,
    "equipment_reps": {
      "dmt": 18,
      "airFloor": 25,
      "rodFloor": 5,
      "trampoline": 14,
      "airRodFloor": 30
    }
  },
  {
    "id": "a0fcab01-7987-41e7-8776-3e9ed38736bf",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "Double back somersault tuck",
    "symbol": "--o",
    "difficulty": 2,
    "equipment_reps": {
      "dmt": 23,
      "airFloor": 45,
      "rodFloor": 12,
      "trampoline": 7,
      "airRodFloor": 29
    }
  },
  {
    "id": "86cbdd2f-3bc5-4f18-b8a6-a58dda37d21b",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "name": "Double back somersault pike",
    "symbol": "--<",
    "difficulty": 2.2,
    "equipment_reps": {
      "dmt": 34,
      "airFloor": 22,
      "rodFloor": 15,
      "trampoline": 10,
      "airRodFloor": 27
    }
  },
  {
    "id": "27241dff-7fc1-4b3d-8e32-df5adf789ace",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "name": "Double back somersault open",
    "symbol": "--O",
    "difficulty": 2.2,
    "equipment_reps": {
      "dmt": 14,
      "airFloor": 30,
      "rodFloor": 28,
      "trampoline": 6,
      "airRodFloor": 12
    }
  },
  {
    "id": "fc3afafa-61ed-4559-b395-1302051d4209",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "Double back somersault straight",
    "symbol": "--/",
    "difficulty": 2.4,
    "equipment_reps": {
      "dmt": 17,
      "airFloor": 42,
      "rodFloor": 8,
      "trampoline": 20,
      "airRodFloor": 13
    }
  },
  {
    "id": "a85bbb4c-bf55-490d-9cfb-097338295e08",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "name": "Full tuck",
    "symbol": "2.",
    "difficulty": 0.9,
    "equipment_reps": {
      "dmt": 9,
      "airFloor": 38,
      "rodFloor": 21,
      "trampoline": 19,
      "airRodFloor": 4
    }
  },
  {
    "id": "d8c14044-55b0-4ce3-845a-12fed33fa64c",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "name": "Full-in tuck",
    "symbol": "2-o",
    "difficulty": 2.4,
    "equipment_reps": {
      "dmt": 29,
      "airFloor": 31,
      "rodFloor": 11,
      "trampoline": 27,
      "airRodFloor": 5
    }
  },
  {
    "id": "f554542d-1066-4655-902c-8b83e6c731d1",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "Full-in pike",
    "symbol": "2-<",
    "difficulty": 2.6,
    "equipment_reps": {
      "dmt": 46,
      "airFloor": 28,
      "rodFloor": 13,
      "trampoline": 8,
      "airRodFloor": 35
    }
  },
  {
    "id": "03f26d27-0405-45d8-95f8-628d9901b172",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "name": "Full-in straight",
    "symbol": "2-/",
    "difficulty": 2.8,
    "equipment_reps": {
      "dmt": 15,
      "airFloor": 26,
      "rodFloor": 18,
      "trampoline": 29,
      "airRodFloor": 9
    }
  },
  {
    "id": "e37a6c9d-b55a-4a18-a0ef-6c4a6f18f543",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "Full Full tuck",
    "symbol": "2 2 o",
    "difficulty": 3.2,
    "equipment_reps": {
      "dmt": 40,
      "airFloor": 10,
      "rodFloor": 22,
      "trampoline": 32,
      "airRodFloor": 17
    }
  },
  {
    "id": "80552678-8421-4c1e-a4fb-384abddd7c07",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "name": "Full Full straight",
    "symbol": "2 2 /",
    "difficulty": 3.6,
    "equipment_reps": {
      "dmt": 38,
      "airFloor": 14,
      "rodFloor": 44,
      "trampoline": 26,
      "airRodFloor": 16
    }
  },
  {
    "id": "fe6f94f5-f2d9-41c3-904c-221de168f409",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "DB tuck whip",
    "symbol": "--o ^",
    "difficulty": 2.2,
    "equipment_reps": {
      "dmt": 32,
      "airFloor": 12,
      "rodFloor": 26,
      "trampoline": 19,
      "airRodFloor": 23
    }
  },
  {
    "id": "8fb839ba-2421-4744-a93c-33303bbe9dd6",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "name": "DB pike whip",
    "symbol": "--< ^",
    "difficulty": 2.4,
    "equipment_reps": {
      "dmt": 27,
      "airFloor": 18,
      "rodFloor": 14,
      "trampoline": 31,
      "airRodFloor": 6
    }
  },
  {
    "id": "dbcd657e-b6fc-49ba-8fc3-1744b0b26523",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0245",
    "name": "DB straight whip",
    "symbol": "--/ ^",
    "difficulty": 2.6,
    "equipment_reps": {
      "dmt": 11,
      "airFloor": 30,
      "rodFloor": 19,
      "trampoline": 22,
      "airRodFloor": 24
    }
  },
  {
    "id": "4d47b6ea-98b0-4942-84f0-190a69fd4a79",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "Full in straight whip",
    "symbol": "2-/ ^",
    "difficulty": 3,
    "equipment_reps": {
      "dmt": 5,
      "airFloor": 47,
      "rodFloor": 41,
      "trampoline": 16,
      "airRodFloor": 18
    }
  },
  {
    "id": "7622b489-f9eb-42dc-ab0e-1872939f3e16",
    "session_id": "c34451aa-0c1a-40a5-9ccf-9844b9cf0243",
    "name": "5 skills",
    "symbol": "5 skills",
    "difficulty": 5,
    "equipment_reps": {
      "dmt": 13,
      "airFloor": 43,
      "rodFloor": 25,
      "trampoline": 6,
      "airRodFloor": 31
    }
  },
  {
    "id": "8bb4c87b-48d1-41a7-b6ad-a9f074323579",
    "session_id": "fa4d19c6-8512-4cf2-a6ec-0899bbce187e",
    "name": "8 skills",
    "symbol": "8 skills",
    "difficulty": 8,
    "equipment_reps": {
      "dmt": 21,
      "airFloor": 34,
      "rodFloor": 9,
      "trampoline": 43,
      "airRodFloor": 15
    }
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
