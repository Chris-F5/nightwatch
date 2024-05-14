import 'package:flutter/material.dart';
import 'hourly_breakdown_page.dart';
import 'weather_api.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    int example_weather_value = WeatherApi.exampleRequest();
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
              child: Text('Return to Search Page'),
              onPressed: () {
                Navigator.pop(context);
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
