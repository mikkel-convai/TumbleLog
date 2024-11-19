import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/program_bloc/program_bloc.dart';

class ProgramNameInput extends StatefulWidget {
  const ProgramNameInput({super.key});

  @override
  State<ProgramNameInput> createState() => _ProgramNameInputState();
}

class _ProgramNameInputState extends State<ProgramNameInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProgramBloc>().state;
    if (state is ProgramCreateStateLoaded) {
      _controller = TextEditingController(text: state.program.name);
    } else {
      _controller = TextEditingController();
    }
  }

  @override
  void didUpdateWidget(covariant ProgramNameInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final state = context.read<ProgramBloc>().state;
    if (state is ProgramCreateStateLoaded) {
      if (_controller.text != state.program.name) {
        _controller.value = _controller.value.copyWith(
          text: state.program.name,
          selection: TextSelection.collapsed(offset: state.program.name.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        if (state is ProgramCreateStateLoaded) {
          return TextField(
            onChanged: (value) {
              context.read<ProgramBloc>().add(
                    ProgramNameChanged(programName: value),
                  );
            },
            decoration: const InputDecoration(
              labelText: 'Program Name',
              border: OutlineInputBorder(),
            ),
            controller: _controller,
          );
        }
        return const SizedBox.shrink(); // Fallback if state isn't loaded
      },
    );
  }
}
