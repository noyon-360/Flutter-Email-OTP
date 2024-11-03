import 'package:email_otp_nodejs/viewmodel/auth/login_viewmodel.dart';
import 'package:email_otp_nodejs/views/auth/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // final FocusNode _focusNodeUser = FocusNode();
    // final FocusNode _focusNodePass = FocusNode();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _header(context),
                        const SizedBox(
                          height: 40,
                        ),
                        _inputField(context),
                        _forgotPassword(context),
                        _signup(context),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Enter your credentials to login",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _inputField(
    context,
  ) {
    final viewModel = Provider.of<LoginViewmodel>(context, listen: false);
    double screenWeight = MediaQuery.of(context).size.width;

    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: screenWeight * 0.8,
            child: TextField(
              controller: viewModel.emailTextField,
              // focusNode: _focusNodeUser,
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.blue.shade200,
                filled: true,
                prefixIcon: const Icon(Icons.person, color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWeight * 0.8,
            child: TextField(
              // focusNode: _focusNodePass,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.blue.shade200,
                filled: true,
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: screenWeight * 0.8,
            child: ElevatedButton(
              onPressed: () {
                String email = viewModel.emailTextField.text.trim();
                if (email.isNotEmpty) {
                  viewModel.sendVerificationEmail(email, context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EmailVerificationScreen(
                  //               email: email,
                  //             )));
                }
                // _focusNodeUser.unfocus();
                // _focusNodePass.unfocus();
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",
            style: TextStyle(color: Colors.black54)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
