import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Search Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Search Page Demo Text'),
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
