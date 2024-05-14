import 'package:flutter/material.dart';
import 'hourly_breakdown_page.dart';
import 'weather_api.dart';

class HomePage extends StatelessWidget {
  late Map<String, dynamic> apiData;
  HomePage(this.apiData, {super.key});

  // Placeholder variables
  final String currentLocation = "Cambridge, UK";
  final String stargazingCondition = "Bad";
  final String moonPhase = "full moon";
  final int currentTemp = 5;
  final int lowTemp = 7;
  final int highTemp = 19;
  final String dawnTime = "04:22";
  final String duskTime = "21:30";
  final String seeing = "1.4\"";
  final String transparency = "1.2/1";

  Color getStarGazingConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case "excellent":
        return const Color.fromARGB(255, 0, 199, 139);
      case "good":
        return const Color.fromARGB(255, 52, 199, 54);
      case "okay":
        return const Color.fromARGB(255, 255, 229, 0);
      case "bad":
        return const Color.fromARGB(255, 255, 149, 0);
      case "terrible":
        return const Color.fromARGB(255, 255, 59, 48);
      default:
        return Colors.grey;
    }
  }

  String getMoonPhaseImage(String moonPhase) {
    switch (moonPhase.toLowerCase()) {
      case "new moon":
        return "assets/new_moon.png";
      case "waxing crescent":
        return "assets/waxing_crescent.png";
      case "first quarter":
        return "assets/first_quarter.png";
      case "waxing gibbous":
        return "assets/waxing_gibbous.png";
      case "full moon":
        return "assets/full_moon.png";
      case "waning gibbous":
        return "assets/waning_gibbous.png";
      case "third quarter":
        return "assets/third_quarter.png";
      case "waning crescent":
        return "assets/waning_crescent.png";
      default:
        return "assets/new_moon.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 2, 4, 7),
                  Color.fromARGB(255, 21, 31, 50)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                              color: Colors.black,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.search, color: Colors.grey),
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
                            color: Colors.black,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Placeholder Weekly Overview",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: SizedBox(
                      height: 40.0,
                      child: Center(
                        child: Text(
                          stargazingCondition,
                          style: TextStyle(
                            color: getStarGazingConditionColor(
                                stargazingCondition),
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Image.asset(
                      getMoonPhaseImage(moonPhase),
                      height: 150.0,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 8.0),
                      child: Row(children: <Widget>[
                        Text(
                          "L: $lowTemp°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "$currentTemp°",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text("H: $highTemp°",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ))
                      ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75.0, vertical: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Text(
                                'Dusk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                duskTime,
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              const Text(
                                'Dawn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                dawnTime,
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ]),
                  )
                ])));
  }
}
