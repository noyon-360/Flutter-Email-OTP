import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp_nodejs/viewmodel/auth/email_verify_viewmodel.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late OTPViewModel otpViewModel;
  String? _message;

  @override
  void initState() {
    super.initState();
    otpViewModel = OTPViewModel();
  }

  @override
  void dispose() {
    otpViewModel.disposeControllers();
    super.dispose();
  }

  Future<void> verifyCode(String email, String code) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('verifications')
          .doc(email)
          .get();

      print(snapshot);

      if (snapshot.exists && snapshot.data()?['code'] == code) {
        setState(() {
          _message = 'Email verified successfully!';
        });
      } else {
        setState(() {
          _message = 'Invalid code!';
        });
      }
    } catch (error) {
      setState(() {
        _message = 'Error verifying code: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.email,
                    color: Colors.blue[500],
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Verify Your Email',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A 6-digit code has been sent to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(otpViewModel.otpLength, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextField(
                        controller: otpViewModel.controllers[index],
                        focusNode: otpViewModel.focusNodes[index],
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) => otpViewModel.onTextFieldChanged(
                            index, value, widget.email, context),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Verify'),
                  ),
                ),
                const SizedBox(height: 16),
                if (_message != null) ...[
                  Text(
                    _message!,
                    style: TextStyle(
                        color: _message!.contains('successful')
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
