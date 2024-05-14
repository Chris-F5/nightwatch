import 'package:flutter/material.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool loading = false;

  @override
  void initState() {
    loadRegion("Cambridge");
  }
  void loadRegion(String location) async {
    setState(() { this.loading = true; });
    /* This is where the api call will take place. */
    await Future.delayed(Duration(seconds: 3));
    /* Results from api call will be passed to home page. */
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    /*
     * Wait a bit before removing loading text so we dont change before home
     * page has covered up search page.
     */
    await Future.delayed(Duration(milliseconds: 500));
    setState(() { this.loading = false; });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Search Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: this.loading
          ? <Widget>[
            Text('Loading'),
          ]
          : <Widget>[
            Text('Search Page Demo Text'),
            ElevatedButton(
              child: Text('Cambridge'),
              onPressed: () {
                loadRegion("Cambridge");
              },
            ),
          ],
        )
      )
    );
  }
}
