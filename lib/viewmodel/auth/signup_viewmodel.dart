import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:email_otp_nodejs/api/APIs.dart';
import 'package:email_otp_nodejs/views/auth/email_verification_screen.dart';
import 'package:flutter/material.dart';

class SignupViewmodel extends ChangeNotifier {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;
  String? message;

  Future<void> sendVerificationEmail(String email, BuildContext context) async {
    _setLoading(true);
    _setMessage(null);

    final response = await http.post(
      Uri.parse(APIs.mailApi), // replace with your API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      _setMessage('Verification email sent!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(email: email),
        ),
      );
    } else {
      _setMessage('Failed to send email: ${response.body}');
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setMessage(String? value) {
    message = value;
    notifyListeners();
  }
}