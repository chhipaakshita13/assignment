import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Repository/repo.dart';
import 'bloc/bloc_events.dart';
import 'bloc/bloc_states.dart';

class PatientProfileBloc extends Bloc<PatientProfileEvent, PatientProfileState> {
  // Define the API URL (replace this with your actual API URL)
  final String apiUrl = 'https://your-api-url.com/updatePatientProfile';

  PatientProfileBloc(PatientProfileRepository patientProfileRepository) : super(PatientProfileInitial()) {
    // Register the handler for UpdatePatientProfileEvent
    on<UpdatePatientProfileEvent>((event, emit) async {
      try {
        // Prepare the request body
        final requestBody = jsonEncode({
          'gender': event.gender,
          'height': event.height,
          'heightType': event.heightType,
          'weight': event.weight,
          'weightType': event.weightType,
        });

        // Send the request to the API
        final response = await http.put(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: requestBody,
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final message = responseData['data'] ?? 'Unknown Error';

          // Emit the updated state
          emit(PatientProfileUpdated(message));
        } else {
          // Handle failure
          emit(PatientProfileError('Failed to update profile. Please try again.'));
        }
      } catch (e) {
        // Handle error
        emit(PatientProfileError('An error occurred: $e'));
      }
    });
  }
}
