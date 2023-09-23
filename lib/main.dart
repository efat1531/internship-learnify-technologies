import 'package:flutter/material.dart';
import './login_page.dart';
import './varify_otp.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        VarifyOTP.routeName: (context) => VarifyOTP(),
      },
    );
  }
}
