import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherDetailScreen extends StatefulWidget {
  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
  static const String routeName = '/weather_detail_screen';
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  dynamic result;
  bool done = false;

  @override
  void initState() {
    super.initState();
    () async {
      final _prefs = await SharedPreferences.getInstance();
      String city = _prefs.getString('city') as String;

      Uri url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&apikey=df41971b9b7e1b4550c40dcea61667fb');

      var response = await http.get(url);
      result = jsonDecode(response.body);
      setState(() {
        done = true;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('आपका मौसम'),
      ),
      backgroundColor: Colors.purple.shade100,
      body: done
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: _deviceSize.width * 0.25,
                    vertical: _deviceSize.height * 0.05,
                  ),
                  child: Card(
                    color: Colors.pink.shade500,
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: _deviceSize.width * 0.1,
                        vertical: _deviceSize.height * 0.03,
                      ),
                      child: Text(
                        result['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: _deviceSize.width * 0.25,
                    vertical: _deviceSize.height * 0.03,
                  ),
                  child: Card(
                    color: Colors.pink.shade500,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: _deviceSize.width * 0.1,
                          vertical: _deviceSize.height * 0.01),
                      child: Image.network(
                        "http://openweathermap.org/img/wn/${result['weather'][0]['icon']}@2x.png",
                        scale: 2.0,
                      ),
                    ),
                  ),
                ),
                WeatherBox(
                  title: 'Temperature',
                  value: '${result['main']['temp']}',
                ),
                WeatherBox(
                  title: 'Wind Speed',
                  value: '${result['wind']['speed']}',
                ),
                WeatherBox(
                  title: 'Humidity',
                  value: '${result['main']['humidity']}',
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class WeatherBox extends StatelessWidget {
  final title;
  final value;

  const WeatherBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _deviceSize.width * 0.02,
        vertical: _deviceSize.height * 0.02,
      ),
      child: Card(
        color: Colors.pink.shade500,
        elevation: 1,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceSize.width * 0.02,
                  vertical: _deviceSize.height * 0.02,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceSize.width * 0.02,
                  vertical: _deviceSize.height * 0.01,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceSize.width * 0.02,
                  vertical: _deviceSize.height * 0.02,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceSize.width * 0.02,
                  vertical: _deviceSize.height * 0.01,
                ),
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
