import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/*
Example of  how to use getWeather method

void main() async {
  final weatherApi = WeatherApi();
  final weatherData = await weatherApi.getWeather('Cambridge');
  print(weatherData['days'].sublist(0,6));
}
*/

class WeatherApi {
  static Future<Map<String, dynamic>> getWeather(String location) async {
    final response = await http.get(Uri.parse(
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${location},UK?unitGroup=uk&key=6N2KTB9AP7VU5JTN5WRKUNXPC'));
    // The response uses asynchronous processing to wait for the request to return
    // This is using the Visual Crossing Weather API (My API key) with a location (in the UK) in town name form

    if (response.statusCode == 200) {
      // If response is valid
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      // Breaks JSON file returned into a dictionary
      return decoded;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
      // In event of request not working, return error code
    }
  }
}
