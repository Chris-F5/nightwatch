//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'weather_api.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool loading = false;

  String textInput = "";
  List<String> knownLocations = ["Cambridge", "Oxford", "Warwick", "Manchester", "Bristol", "London"];
  List<String> recentLocations = ["Cambridge", "Oxford", "Warwick", "Manchester", "Bristol"];

  TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    loadRegion("Cambridge");
  }
  void loadRegion(String location) async {
    setState(() { this.loading = true; });
    /* This is where the api call will take place. */
    Map<String, dynamic> apiData = await WeatherApi.getWeather(location);
    /* Results from api call will be passed to home page. */
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(apiData)));
    /*
     * Wait a bit before removing loading text so we dont change before home
     * page has covered up search page.
     */
    await Future.delayed(Duration(milliseconds: 500));
    setState(() { this.loading = false; });


    //Update Recent Locations
    if(recentLocations.contains(location)){
      recentLocations.remove(location);
    }else if(recentLocations.length == 5) {
      recentLocations.removeAt(0);
    }
    recentLocations.add(location);

    debugPrint(recentLocations.toString());

    //Clear Search Bar
    searchBarController.text = "";
  }
  void searchLocation(String location) {
    if(knownLocations.contains(location)){
      loadRegion(location);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 60,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff1c232b),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child:Text("Not a valid location", style: TextStyle(fontWeight: FontWeight.bold),)
          ),
          backgroundColor: Colors.transparent,
          //behavior: SnackBarBehavior.floating,
          elevation: 0,
        )
      );
    }
  }

  List<Widget> applySpacing(List<Widget> items){
    List<Widget> spacedList = [];
    items.forEach((item){
      spacedList.add(item);
      spacedList.add(SizedBox(height: 20,));
    });
    return spacedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323c48),
        appBar: AppBar(
          backgroundColor: Color(0xff1c232b),
          title: const Text('Night Watch', style: TextStyle(color: Colors.white70)),
          // actions:[
          //   IconButton(
          //       onPressed: () {
          //         showSearch(context: context, delegate: CustomSearchDelegate());
          //       },
          //       icon:Icon(Icons.search, color: Colors.white70)
          //   ),
          //]

        ),


        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: this.loading ? <Widget>[Text('Loading'),]
              : <Widget>[
                SizedBox(height: 10),
                Container(
                  height: 20,
                  width: 300,
                  child: Text("Search Locations", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                ),//Text
                SizedBox(height: 10),

                Container( //SearchBar
                  height: 40,
                  width: 300,

                  //padding: EdgeInsets.only(left:40),

                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color(0xff242b34),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff1c232b),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () {
                              searchLocation(searchBarController.text);
                            },
                            icon: Icon(Icons.search, color: Colors.white70),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 260,

                        child: TextField(
                          controller: searchBarController,
                          cursorColor: Colors.white70,
                          style:TextStyle(color: Colors.white70),
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter a Location ...",
                            hintStyle: TextStyle(color: Colors.white10)

                          ),
                        ),
                      )],
                  )

                ),//SearchBar
                SizedBox(height: 20),//Spacing
                Container(
                  height: 20,
                  width: 300,
                  child: Text("Recent Locations", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                ),//Text
                SizedBox(height: 10),//Spacing
                Expanded(

                  child: Column(
                    //children: [RecentLocationContainer(location: "Cambridge", buttonFunction: loadRegion)],
                    children: applySpacing(recentLocations.map((loc) => RecentLocationContainer(location: loc, buttonFunction: loadRegion,)).toList()),
                  ),
                )
              ]
            )
        )

    );
  }
}

class RecentLocationContainer extends StatelessWidget {
  const RecentLocationContainer({
    super.key,
    required this.location,
    required this.buttonFunction
  });

  final String location;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,

      padding: EdgeInsets.only(left:20,right: 10),
      decoration: BoxDecoration(
        color: Color(0xff242b34),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff1c232b),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],


      ),
      child: Row(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              width: 120,
              height: 60,
              child: Text(location, style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
          Container(
              alignment: Alignment.centerRight,
              width: 120,
              height: 60,
              child: ElevatedButton(
                  onPressed: (){
                    buttonFunction(location);
                    },
                  child: Icon(Icons.arrow_forward, color: Color(0xff242b34),)))
        ],
      ),

    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ["Cambridge", "Oxford", "Durham"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var town in searchTerms) {
      if (town.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(town);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result)
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var town in searchTerms) {
      if (town.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(town);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result)
        );
      },
    );
  }
}
