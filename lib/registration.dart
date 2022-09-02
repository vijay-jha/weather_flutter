import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verification = "";
  String otpFromUser = "";
  bool otpVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your मौसम'),
      ),
      body: Column(
        children: [
          const Text('Registration'),
          const Text('Please enter your Mobile number'),
          TextField(
            autofocus: true,
            controller: _phoneController,
            decoration: const InputDecoration(hintText: 'Mobile Number'),
          ),
          const SizedBox(
            height: 50,
          ),
          Visibility(
            visible: otpVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _otpBox(true, false),
                ),
                Expanded(
                  child: _otpBox(false, false),
                ),
                Expanded(
                  child: _otpBox(false, false),
                ),
                Expanded(
                  child: _otpBox(false, true),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // verifyNumber();

              setState(() {
                FocusScope.of(context).nextFocus();
                otpVisible = true;
              });
            },
            child: const Text("Let's Verify"),
          ),
        ],
      ),
    );
  }

  void verifyNumber() {
    FocusScope.of(context).;
    auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(exception.message.toString()),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verification = verificationId;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('An Otp has been sent'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          otpVisible = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Widget _otpBox(bool first, bool last) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            otpFromUser += value;
            FocusScope.of(context).nextFocus();
          } else {
            otpFromUser += value;
          }
          if (value.isEmpty && !first) {
            otpFromUser = otpFromUser.substring(0, otpFromUser.length - 1);
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.purple),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
