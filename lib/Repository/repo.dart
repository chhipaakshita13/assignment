
import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientProfileRepository {
  final String url = 'http://157.15.202.189:7002/patient/patient_info?patientId=73';
  final String bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVbWVzaCIsInJvbGVJZCI6MiwiZXhwIjoxNzU0NDU1MDY5LCJpYXQiOjE3MjI5MTkwNjl9.WwBZtiNMQAeerkqkQL2MQjNVyfAEn7gE8CzzU0XpCIE';

  Future<Map<String, dynamic>> updatePatientProfile({
    required String gender,
    required double height,
    required String heightType,
    required double weight,
    required String weightType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "gender": gender,
          "height": height,
          "heightType": heightType,
          "weight": weight,
          "weightType": weightType,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update patient profile');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
