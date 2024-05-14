import 'dart:convert';

class WeatherApi {
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
