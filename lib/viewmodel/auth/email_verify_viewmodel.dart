import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp_nodejs/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPViewModel extends ChangeNotifier {
  final int otpLength = 6;
  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];
  String? messages;

  OTPViewModel() {
    for (int i = 0; i < otpLength; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
    // _startListeningForOtp(); // Start listening for OTP
  }

  void disposeControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    SmsAutoFill().unregisterListener();
  }

  // Start SMS listening
  // void _startListeningForOtp() async {
  //   await SmsAutoFill().listenForCode();
  //   SmsAutoFill().code.listen((code) {
  //     if (code != null && code.length >= otpLength) {
  //       _fillOtpFields(code);
  //     }
  //   });
  // }

  // // Autofill OTP in text fields
  // void _fillOtpFields(String code) {
  //   for (int i = 0; i < otpLength; i++) {
  //     controllers[i].text = code[i];
  //   }
  //   verifyOtp(); // Automatically verify once filled
  // }

  // Advance to the next field when user types
  void onTextFieldChanged(int index, String value, String email, BuildContext context) {
    if (value.isNotEmpty && index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    }
    if (index == otpLength - 1 && value.isNotEmpty) {
      verifyOtp(email, context);
    }
  }

  Future<void> verifyOtp(String email, BuildContext context) async {
    String otpCode = controllers.map((controller) => controller.text).join();
    print("otpCode: $otpCode");
    if (otpCode.length == otpLength) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('verifications')
            .doc(email)
            .get();

        if (snapshot.exists && snapshot.data()?['code'] == otpCode) {
          _setMessage('Email verified successfully!');
          print(messages);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Dashboard()), (route) => false,);
        } else {
          _setMessage('Invalid code!');
          print(messages);
        }
      } catch (error) {
        _setMessage('Error verifying code: $error');
      }
    }
  }

  void _setMessage(String message) {
    messages = message;
    notifyListeners();
  }
}
