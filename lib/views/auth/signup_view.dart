import 'package:email_otp_nodejs/viewmodel/auth/signup_viewmodel.dart';
import 'package:email_otp_nodejs/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final viewmodel =
                  Provider.of<SignupViewmodel>(context, listen: false);
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _header(context),
                            const SizedBox(height: 40),
                            _inputFields(context, viewmodel),
                            const SizedBox(height: 16),
                            _signupButton(context, viewmodel),
                            const SizedBox(height: 16),
                            _socialLoginButton(),
                            const SizedBox(height: 16),
                            _loginText(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (viewmodel.isLoading)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            },
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: Container(
    //         margin: const EdgeInsets.all(20),
    //         // padding: const EdgeInsets.symmetric(horizontal: 24),

    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _header(context) {
    return const Column(
      children: [
        Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Create your account",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _inputFields(context, SignupViewmodel viewmodel) {
    return Column(
      children: [
        TextField(
          controller: viewmodel.username,
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
        const SizedBox(height: 20),
        TextField(
          controller: viewmodel.email,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.shade200,
            filled: true,
            prefixIcon: const Icon(Icons.email, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: viewmodel.password,
          decoration: InputDecoration(
            hintText: 'Password',
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
        const SizedBox(height: 20),
        TextField(
          controller: viewmodel.confirmPassword,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.shade200,
            filled: true,
            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
          ),
          obscureText: true,
        )
      ],
    );

    // return Column(
    //   children: [
    //     _textField("Username", Icons.person, viewmodel, context),
    //     const SizedBox(height: 20),
    //     _textField("Email", Icons.email, viewmodel, context),
    //     const SizedBox(height: 20),
    //     _textField("Password", Icons.lock, context, viewmodel, obscureText: true),
    //     const SizedBox(height: 20),
    //     _textField("Confirm Password", Icons.lock, context, viewmodel, obscureText: true),
    //   ],
    // );
  }

  Widget _signupButton(context, SignupViewmodel viewmodel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          viewmodel.sendVerificationEmail(viewmodel.email.text, context);
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _socialLoginButton() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, color: Colors.blue),
            SizedBox(width: 10),
            Text(
              "Sign Up with Google",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.black54)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
