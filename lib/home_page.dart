import 'package:flutter/material.dart';
import 'hourly_breakdown_page.dart';
import 'weather_api.dart';

class HomePage extends StatelessWidget {
  late Map<String, dynamic> apiData;
  HomePage(Map<String, dynamic> apiData) {
    this.apiData = apiData;
  }
  @override
  Widget build(BuildContext context) {
    final demoText = apiData['morning']['frogs'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Text('Nightwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Demo Text $demoText'),
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
                  MaterialPageRoute(builder: (context) => HourlyBreakdownPage(apiData)),
                );
              },
            ),
          ],
        )
      )
    );
  }
}
