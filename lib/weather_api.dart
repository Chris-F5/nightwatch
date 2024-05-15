import 'package:http/http.dart' as http;

class WeatherApi {

  DateTime now = DateTime.now()

  Future<http.Response> getWeather() {
    return http.get(Uri.parse('https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/London,UK?key=6N2KTB9AP7VU5JTN5WRKUNXPC '));
  }


}
