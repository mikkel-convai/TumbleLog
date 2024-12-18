part of 'view_program_bloc.dart';

sealed class ViewProgramEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPrograms extends ViewProgramEvent {
  final String userId;

  LoadPrograms({required this.userId});

  @override
  List<Object> get props => [userId];
}
