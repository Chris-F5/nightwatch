import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starsview/starsview.dart';

class HourlyBreakdownPage extends StatelessWidget {
  late Map<String, dynamic> apiData;
  HourlyBreakdownPage(Map<String, dynamic> apiData) {
    this.apiData = apiData;
  }
  @override
  Widget build(BuildContext context) {
    final String location = apiData['address'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white70, //change your color here
        ),
        backgroundColor: const Color(0xff1c232b),
        title: const Text('Hourly Breakdown', style: TextStyle(color: Colors.white70)),
      ),
      body:
      SafeArea(
        child: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 21, 31, 50)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const StarsView(
            fps: 60,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0), child: Column(
              children: <Widget>[
                Text(location,
                    style: const TextStyle(
                    color: Color.fromARGB(240, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0)),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      const FixedColumnWidget(),
                      ScrollableColumnWidget(this.apiData),
                    ],
                  ),
                )]
            ),),]
          )]
        )
      )
    );
  }
}

class FixedColumnWidget extends StatelessWidget {
  const FixedColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> attributes = ["Cloud coverage", "Rain", "Wind speed", "Wind direction", "Temp", "Humidity", "Visibility"];
    List<DataRow> rows = [];
    for(final str in attributes) {
      rows.add(DataRow(cells: [DataCell(Text(
        str,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ))]));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(
            width: 2,
            color:Colors.black),
          headingRowColor: MaterialStateProperty.all(const Color.fromARGB(230, 181, 191, 200)),
          dataRowColor: MaterialStateProperty.all(const Color.fromARGB(230, 181, 191, 200)),
          columnSpacing: 40,
          columns: const [DataColumn(label: Text("Hour", style: TextStyle(fontWeight: FontWeight.bold)))],
          rows: rows
        )
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  late Map<String, dynamic> apiData;
  ScrollableColumnWidget(apiData) {
    this.apiData = apiData;
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> cols = [];

    List<dynamic> hours = apiData['days'][0]['hours'];
    List<String> attributes = ["cloudcover", "precipprob", "windspeed", "winddir", "temp", "humidity", "visibility"];
    for(int i = 0; i < 24; i++) {
      Map<String, dynamic> hour = hours[i];
      cols.add(DataColumn(label: Text(hour["datetime"].substring(0, 5))));
    }
    List<DataRow> rows = [];
    for(int i = 0; i < 7; i++) {
      List<DataCell> cells = [];
      for(int j = 0; j < 24; j++) {
        cells.add(DataCell(
            Container(
                alignment: AlignmentDirectional.center,
                child: Text(hours[j][attributes[i]].toString()))));
      }
      rows.add(DataRow(cells: cells));
    }
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            border: TableBorder.all(
                width: 2,
                color:Colors.black),
            dataRowColor: MaterialStateProperty.all(const Color.fromARGB(230, 255, 255, 255)),
            headingRowColor: MaterialStateProperty.all(const Color.fromARGB(230, 181, 191, 200)),
            columnSpacing: 40,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black54,
                  width: 0.5,
                )
              ),
            ),
            columns: cols,
            rows: rows
        )
      ),
    );
  }
}
