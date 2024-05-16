import 'package:flutter/material.dart';
import 'hourly_breakdown_page.dart';
import 'package:starsview/starsview.dart';
import 'package:intl/intl.dart';
import 'weather_api.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  late Map<String, dynamic> apiData;
  HomePage(this.apiData, {super.key});

  // Placeholder variables
  final String stargazingCondition = "excellent";

  final String inOneDayCondition = "good";
  final String inTwoDaysCondition = "bad";
  final String inThreeDaysCondition = "good";
  final String inFourDaysCondition = "terrible";
  final String inFiveDaysCondition = "good";
  final String inSixDaysCondition = "okay";

  final List<String> daysOfWeek = [
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN"
  ];

  String capitalise(String s) => s[0].toUpperCase() + s.substring(1);

  Color getStarGazingConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case "excellent":
        return const Color.fromARGB(255, 64, 224, 208);
      case "good":
        return const Color.fromARGB(255, 52, 199, 54);
      case "okay":
        return const Color.fromARGB(255, 255, 229, 0);
      case "bad":
        return const Color.fromARGB(255, 255, 149, 0);
      case "terrible":
        return const Color.fromARGB(255, 255, 59, 48);
      default:
        return Colors.white;
    }
  }

  String getMoonPhaseImage(double moonPhase) {
    if (moonPhase == 0) {
      return "assets/new_moon.png";
    } else if (moonPhase < 0.25) {
      return "assets/waxing_crescent.png";
    } else if (moonPhase == 0.25) {
      return "assets/first_quarter.png";
    } else if (moonPhase < 0.5) {
      return "assets/waxing_gibbous.png";
    } else if (moonPhase == 0.5) {
      return "assets/full_moon.png";
    } else if (moonPhase < 0.75) {
      return "assets/waning_gibbous.png";
    } else if (moonPhase == 0.75) {
      return "assets/third_quarter.png";
    } else if (moonPhase <= 1) {
      return "assets/waning_crescent.png";
    } else {
      return "assets/full_moon.png";
    }
  }

  Color getSeeingColor(double seeing) {
    if (seeing < 1.5) {
      return const Color.fromARGB(255, 52, 199, 54);
    } else if (seeing < 2.5) {
      return const Color.fromARGB(255, 255, 229, 0);
    } else {
      return const Color.fromARGB(255, 255, 59, 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String currentDay = DateFormat('EEEE').format(currentDate);
    currentDay = currentDay.substring(0, 3).toUpperCase();

    int currentIndex = daysOfWeek.indexOf(currentDay);

    List<String> nextSevenDays = [];
    for (int i = 0; i < 7; i++) {
      nextSevenDays.add(daysOfWeek[(currentIndex + i) % 7]);
    }

    final String currentLocation = apiData['address'];
    final double moonPhase = apiData["days"].sublist(0, 6)[0]["moonphase"];

    String sunset = apiData["days"].sublist(0, 6)[0]["sunset"];
    sunset = sunset.substring(0, sunset.length - 3);
    String sunrise = apiData["days"].sublist(0, 6)[0]["sunrise"];
    sunrise = sunrise.substring(0, sunrise.length - 3);

    final int currentTemp = (apiData["days"].sublist(0, 6)[0]["temp"]).round();
    final int highTemp = (apiData["days"].sublist(0, 6)[0]["tempmax"]).round();
    final int lowTemp = (apiData["days"].sublist(0, 6)[0]["tempmin"]).round();

    String date = apiData["days"].sublist(0, 6)[0]["datetime"];
    date = date.substring(date.length - 2, date.length);
    double seeingNum = int.parse(date) % 3;
    double transparencyNum = (int.parse(date) % 3) - 1;

    String seeing;
    if (seeingNum == 0) {
      seeing = "excellent";
    } else if (seeingNum == 1) {
      seeing = "good";
    } else if (seeingNum == 2) {
      seeing = "okay";
    } else if (seeingNum == 3) {
      seeing = "bad";
    } else {
      seeing = "terrible";
    }

    String transparency;
    if (transparencyNum == 0) {
      transparency = "excellent";
    } else if (transparencyNum == 1) {
      transparency = "good";
    } else if (transparencyNum == 2) {
      transparency = "okay";
    } else if (transparencyNum == 3) {
      transparency = "bad";
    } else {
      transparency = "terrible";
    }

    nextSevenDays[nextSevenDays.indexOf(currentDay)] =
        "|${nextSevenDays[nextSevenDays.indexOf(currentDay)]}|";

    return Scaffold(
        body: SafeArea(
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
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 8.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.arrow_back, color: Colors.grey),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      currentLocation,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 8.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (index) {
                      Color dayColor;

                      if (index == 0) {
                        dayColor =
                            getStarGazingConditionColor(stargazingCondition);
                      } else if (index == 1) {
                        dayColor =
                            getStarGazingConditionColor(inOneDayCondition);
                      } else if (index == 2) {
                        dayColor =
                            getStarGazingConditionColor(inTwoDaysCondition);
                      } else if (index == 3) {
                        dayColor =
                            getStarGazingConditionColor(inThreeDaysCondition);
                      } else if (index == 4) {
                        dayColor =
                            getStarGazingConditionColor(inFourDaysCondition);
                      } else if (index == 5) {
                        dayColor =
                            getStarGazingConditionColor(inFiveDaysCondition);
                      } else {
                        dayColor =
                            getStarGazingConditionColor(inSixDaysCondition);
                      }

                      return Text(nextSevenDays[index],
                          style: TextStyle(
                            color: dayColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ));
                    }))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SizedBox(
            height: 48.0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: getStarGazingConditionColor(stargazingCondition),
                      offset: const Offset(0, 0),
                      blurRadius: 100.0,
                    ),
                  ],
                ),
                child: Text(
                  capitalise(stargazingCondition),
                  style: TextStyle(
                    color: getStarGazingConditionColor(stargazingCondition),
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: SizedBox(
              height: 150.0,
              child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 0),
                      blurRadius: 150.0,
                    )
                  ]),
                  child: Image.asset(
                    getMoonPhaseImage(moonPhase),
                    height: 150.0,
                  ))),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4.0),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 120.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "L: $lowTemp°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 100.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "$currentTemp°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48.0,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                        blurRadius: 120.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "H: $highTemp°",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Sunset ↓",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 250, 160),
                          offset: Offset(0, -15),
                          blurRadius: 90.0,
                        ),
                      ],
                    ),
                    child: Text(
                      sunset,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 250, 160),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Seeing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: getStarGazingConditionColor(seeing),
                          offset: const Offset(0, -15),
                          blurRadius: 90.0,
                        ),
                      ],
                    ),
                    child: Text(
                      capitalise(seeing),
                      style: TextStyle(
                        color: getStarGazingConditionColor(seeing),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    "Sunrise ↑",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 250, 160),
                          offset: Offset(0, -15),
                          blurRadius: 90.0,
                        ),
                      ],
                    ),
                    child: Text(
                      sunrise,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 250, 160),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Transparency",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: getStarGazingConditionColor(transparency),
                          offset: const Offset(0, -15),
                          blurRadius: 90.0,
                        ),
                      ],
                    ),
                    child: Text(
                      capitalise(transparency),
                      style: TextStyle(
                        color: getStarGazingConditionColor(transparency),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 0),
                  blurRadius: 8.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(double.infinity, 50.0),
              ),
              child: const Text(
                "Hourly Breakdown",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HourlyBreakdownPage(apiData)),
                );
              },
            ),
          ),
        ),
      ])
    ])));
  }
}
