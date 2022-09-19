import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../widgets/homepage_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic result;
  bool done = false;
  final _cityNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    () async {
      final _prefs = await SharedPreferences.getInstance();
      // String city = _prefs.getString('city') as String;
      String city = 'Pune';

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
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Color.fromARGB(255, 29, 128, 64),
      //       Color.fromARGB(255, 19, 113, 60)
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.centerRight,
      //   ),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farmicon',
            style: TextStyle(
              fontSize: 25,
              // Added
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 30,
        ),
        backgroundColor: Colors.transparent,
        body: done
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 70, 46),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: _deviceSize.width * 0.05,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: _deviceSize.height * 0.02,
                      horizontal: _deviceSize.width * 0.03,
                    ),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onSubmitted: (value) async {
                        value = value.trim();
                        Uri url = Uri.parse(
                            'https://api.openweathermap.org/data/2.5/weather?q=$value&units=metric&apikey=df41971b9b7e1b4550c40dcea61667fb');

                        var response = await http.get(url);
                        setState(() {
                          result = jsonDecode(response.body);
                          _cityNameController.text = "";
                        });
                      },
                      controller: _cityNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for a city or an airport',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        HomePageCard(
                          imageSrc:
                              'assets/images/weather_images/${result['weather'][0]['icon']}.png',
                          value: '${result['main']['temp'].toInt()}',
                          textBelowIcon: '${result['weather'][0]['main']}',
                          isWeather: true,
                          cityName: '${result['name']}',
                        ),
                        HomePageCard(
                          imageSrc: 'assets/images/money.png',
                          value: '22/Kg',
                          textBelowIcon: '${result['weather'][0]['main']}',
                          cityName: '${result['name']}',
                        ),
                        HomePageCard(
                          imageSrc: 'assets/images/ashoka_symbol.png',
                          value: 'Government Scheme 1',
                          cityName: '${result['name']}',
                        ),
                      ],
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
