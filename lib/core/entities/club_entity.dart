import 'package:equatable/equatable.dart';

class Club extends Equatable {
  final String id;
  final String name;

  const Club({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
