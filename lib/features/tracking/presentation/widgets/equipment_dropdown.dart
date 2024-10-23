import 'package:flutter/material.dart';
import 'package:tumblelog/constants.dart';

// EquipmentDropdown widget
class EquipmentDropdown extends StatefulWidget {
  final EquipmentType initialEquipment;
  final Function(EquipmentType) onEquipmentChanged;

  const EquipmentDropdown({
    super.key,
    required this.initialEquipment,
    required this.onEquipmentChanged,
  });

  @override
  State<EquipmentDropdown> createState() => _EquipmentDropdownState();
}

class _EquipmentDropdownState extends State<EquipmentDropdown> {
  late EquipmentType _selectedEquipment;

  @override
  void initState() {
    super.initState();
    _selectedEquipment = widget.initialEquipment;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<EquipmentType>(
      value: _selectedEquipment,
      items: EquipmentType.values.map((EquipmentType equipment) {
        return DropdownMenuItem<EquipmentType>(
          value: equipment,
          child: Text(equipment.displayName),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() {
            _selectedEquipment = newValue;
          });
          widget.onEquipmentChanged(newValue);
        }
      },
    );
  }
}
