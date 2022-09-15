// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/user_location_screen.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";
  String _otpFromUser = "";
  bool otpVisible = false;

  @override
  Widget build(BuildContext context) {
    Size _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('आपका मौसम'),
      ),
      backgroundColor: Colors.purple.shade100,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: _deviceSize.width * 0.25,
              vertical: _deviceSize.height * 0.03,
            ),
            child: Card(
              color: Colors.pink.shade500,
              elevation: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceSize.width * 0.05,
                  vertical: _deviceSize.height * 0.03,
                ),
                child: const Text(
                  'Registration',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          const Text(
            'Please enter your Mobile number',
            style: TextStyle(fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: _deviceSize.width * 0.05,
              vertical: _deviceSize.height * 0.02,
            ),
            child: TextField(
              keyboardType: TextInputType.phone,
              autofocus: true,
              controller: _phoneController,
              decoration: const InputDecoration(hintText: '+91 1111111111'),
            ),
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
              FocusScope.of(context).unfocus();
              if (!otpVisible) {
                verifyNumber();
              } else {
                verifyOtp();
              }
            },
            child: Text(!otpVisible ? "Let's Verify" : "Login"),
          ),
        ],
      ),
    );
  }

  void verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: _otpFromUser);
    try {
      await auth.signInWithCredential(credential);
      Navigator.of(context).pushReplacementNamed(UserLocationScreen.routeName);
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "account-exists-with-different-credential":
          errorMessage = "Already have an account. Try Login";
          break;
        case "invalid-credential":
          errorMessage = "Invalid Credentials.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "invalid-verification-code":
          errorMessage = "Incorrect Otp.";
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        otpVisible = false;
      });
    }
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException error) {
        String errorMessage = "";
        switch (error.code) {
          case "invalid-phone-number":
            errorMessage = "Phone Number is entered in Invalid Format.";
            break;
          case "invalid-credential":
            errorMessage = "Invalid Credentials.";
            break;
          case "missing-phone-number":
            errorMessage =
                "To send verification codes, provide a phone number for the recipient.";
            break;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );

        setState(() {
          _phoneController.text = "";
        });
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationID = verificationId;
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
    Size _deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _deviceSize.width * 0.02,
        vertical: _deviceSize.height * 0.03,
      ),
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            _otpFromUser += value;
            FocusScope.of(context).nextFocus();
          } else {
            _otpFromUser += value;
          }
          if (value.isEmpty && !first) {
            _otpFromUser = _otpFromUser.substring(0, _otpFromUser.length - 1);
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
