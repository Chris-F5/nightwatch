import 'package:flutter/material.dart';
import 'search_page.dart';
import 'hourly_breakdown_page.dart';
import 'weather_api.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    int example_weather_value = WeatherApi.getWeather();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Nightwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Demo Text $example_weather_value'),
            ElevatedButton(
              child: Text('Open Search Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Open Hourly Breakdown Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HourlyBreakdownPage()),
                );
              },
            ),
          ],
        )
      )
    );
  }
}
