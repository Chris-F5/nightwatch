import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class WeatherApi {


  Future<http.Response> getWeather(String location) async {
    final response = await http.get(Uri.parse(
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/${location},UK?unitGroup=uk&key=6N2KTB9AP7VU5JTN5WRKUNXPC'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void main() {
    print('Hello, world!');
  }

}

  /*
  static Future<Map<String, dynamic>> fetchData() async {
    await WeatherApi.getWeather();
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

   */

