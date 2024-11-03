import 'package:email_otp_nodejs/viewmodel/auth/email_verify_viewmodel.dart';
import 'package:email_otp_nodejs/viewmodel/auth/login_viewmodel.dart';
import 'package:email_otp_nodejs/viewmodel/auth/signup_viewmodel.dart';
import 'package:email_otp_nodejs/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'private/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewmodel()),
        ChangeNotifierProvider(create: (_) => SignupViewmodel()),
        ChangeNotifierProvider(create: (_) => OTPViewModel()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    ),
    );
    
  }
}
