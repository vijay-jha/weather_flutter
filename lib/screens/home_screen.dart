import 'package:flutter/material.dart';

import '../widgets/homepage_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 29, 128, 64),
            Color.fromARGB(255, 19, 113, 60)
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Farmicon',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 30,
          ),
          // backgroundColor: const Color.fromARGB(255, 26, 121, 63),
          backgroundColor: Colors.transparent,
          body: Column(
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
                  vertical: _deviceSize.height * 0.01,
                  horizontal: _deviceSize.width * 0.03,
                ),
                child: const TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
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
                  HomePageCard(),
                  HomePageCard(),
                  HomePageCard(),
                ],
              ))
            ],
          )),
    );
  }
}
