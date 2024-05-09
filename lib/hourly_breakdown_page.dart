import 'package:flutter/material.dart';

class HourlyBreakdownPage extends StatelessWidget {
  const HourlyBreakdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Hourly Breakdown Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Hourly Breakdown Page Demo Text'),
            ElevatedButton(
              child: const Text('Return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      )
    );
  }
}
