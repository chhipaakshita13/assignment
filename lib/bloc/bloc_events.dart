import 'package:equatable/equatable.dart';

abstract class PatientProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdatePatientProfileEvent extends PatientProfileEvent {
  final String gender;
  final double height;
  final String heightType;
  final double weight;
  final String weightType;

  UpdatePatientProfileEvent({
    required this.gender,
    required this.height,
    required this.heightType,
    required this.weight,
    required this.weightType,
  });

  @override
  List<Object> get props => [gender, height, heightType, weight, weightType];
}
