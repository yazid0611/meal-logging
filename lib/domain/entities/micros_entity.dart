import 'package:equatable/equatable.dart';

class MicrosEntity extends Equatable {
  final Map<String, double> nutrients;

  const MicrosEntity({required this.nutrients});

  List<Object?> get props => [nutrients];
}
