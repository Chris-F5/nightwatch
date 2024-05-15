import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class WeatherApi {

  DateTime now = DateTime.now()

  Future<http.Response> getWeather() {
  return http.get(Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/London,UK?key=6N2KTB9AP7VU5JTN5WRKUNXPC '));
  }

  static Future<Map<String, dynamic>> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonString = """
{
  "morning": {"clouds": "HAPPY", "frogs": "SAD"},
  "afternoon": {"clouds": "HAPPY", "frogs": "SAD"}
}
    """;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  static String exampleRequest() {

    final jsonString = """
{
  "morning": {"clouds": "HAPPY", "frogs": "SAD"},
  "afternoon": {"clouds": "HAPPY", "frogs": "SAD"}
}
    """;
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    return data['morning']['clouds'];
  }


}
