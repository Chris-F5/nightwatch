import 'package:flutter/material.dart';
import 'search_page.dart';
import 'hourly_breakdown_page.dart';
import 'weather_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    int exampleWeatherValue = WeatherApi.exampleRequest();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Nightwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Demo Text $exampleWeatherValue'),
            ElevatedButton(
              child: const Text('Open Search Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Open Hourly Breakdown Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HourlyBreakdownPage()),
                );
              },
            ),
          ],
        )
      )
    );
  }
}
