import 'dart:convert';
import 'dart:async';

class WeatherApi {

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
