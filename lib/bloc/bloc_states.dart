
import 'package:equatable/equatable.dart';

abstract class PatientProfileState extends Equatable{
  @override
  List<Object> get props => [];
}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class PatientProfileLoaded extends PatientProfileState {
  final String message;
  PatientProfileLoaded(this.message);
}
class PatientProfileUpdated extends PatientProfileState {
  final String message;

  PatientProfileUpdated(this.message);

  List<Object> get props => [message];
}
class PatientProfileError extends PatientProfileState {
  final String error;
  PatientProfileError(this.error);
}