// patient_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repository/repo.dart';
import '../bloc/bloc_events.dart';
import '../bloc/bloc_states.dart';
import '../profile_bloc.dart';

class PatientProfileScreen extends StatelessWidget {
  String gender = '';
  int height = 0;
  double weight = 0.0;
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  // Create a form key to validate the input fields
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientProfileBloc(PatientProfileRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Patient Profile')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PatientProfileBloc, PatientProfileState>(
            builder: (context, state) {
              if (state is PatientProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PatientProfileError) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is PatientProfileLoaded) {
                return Center(child: Text(state.message));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Gender'),
                      controller: _genderController,
                      onChanged: (value) => gender = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Height (in cm)'),
                      keyboardType: TextInputType.number,
                      controller: _heightController,
                      onChanged: (value) => height = int.tryParse(value) ?? 0,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Weight (in kg)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _weightController,
                      onChanged: (value) => weight = double.tryParse(value) ?? 0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('object');
                        String gender = _genderController.text;
                        double height = double.tryParse(_heightController.text) ?? 0;
                        double weight = double.tryParse(_weightController.text) ?? 0;
                        print(gender);
                        BlocProvider.of<PatientProfileBloc>(context).add(
                          UpdatePatientProfileEvent(
                            gender: gender,
                            height: height,
                            heightType: 'CM',
                            weight: weight,
                            weightType: 'KG',
                          ),
                        );
                      },
                      child: const Text('Update Profile'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
