// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationScreen extends StatefulWidget {
  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
  static const String routeName = '/user_location_screen';
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  final _cityController = TextEditingController();

  Future<void> setLocation(String city) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('city', city);
  }

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'आपका मौसम',
        ),
      ),
      backgroundColor: Colors.purple.shade100,
      body: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: _deviceSize.width * 0.05,
            vertical: _deviceSize.height * 0.1,
          ),
          child: TextField(
            autofocus: true,
            controller: _cityController,
            decoration: const InputDecoration(
              hintText: 'Your city',
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (_cityController.text.trim().isNotEmpty) {
                await setLocation(_cityController.text.trim());

                Navigator.of(context)
                    .pushReplacementNamed('/weather_detail_screen');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Enter the city Name'),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
              }
            },
            child: const Text('Submit')),
      ]),
    );
  }
}
