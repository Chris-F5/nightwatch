import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HourlyBreakdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String location = "temp_location";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Hourly Breakdown'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(16.0), child: Column(
              children: <Widget>[
                Text(location),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      FixedColumnWidget(),
                      ScrollableColumnWidget(),
                    ],
                  ),
                )]
          ),),]
      )
    );
  }
}

class FixedColumnWidget extends StatelessWidget {
  const FixedColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for(int i = 0; i < 10; i++) {
      rows.add(DataRow(cells: [DataCell(Text(
        i.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ))]));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.indigoAccent),
          columnSpacing: 40,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey,
                width: 2
              )
            )
          ),
          columns: const [DataColumn(label: Text("Hour"))],
          rows: rows
        )
    );
  }
}

class ScrollableColumnWidget extends StatelessWidget {
  const ScrollableColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> cols = [];
    for(int i = 0; i < 10; i++) {
      cols.add(DataColumn(label: Text(i.toString())));
    }
    List<DataRow> rows = [];
    for(int i = 0; i < 10; i++) {
      List<DataCell> cells = [];
      for(int j = 0; j < 10; j++) {
        cells.add(DataCell(
            Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  (((i + 1) * (j + 1)).toString())
                ))));
      }
      rows.add(DataRow(cells: cells));
    }
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.indigoAccent),
            columnSpacing: 40,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            columns: cols,
            rows: rows
        )
      ),
    );
  }
}
