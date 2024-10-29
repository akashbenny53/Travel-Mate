// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/database/user.dart';
import 'package:travel_app/screens/hiddendrawer.dart';
import 'package:travel_app/screens/startpage.dart';

class SplaSh extends StatefulWidget {
  const SplaSh({super.key});

  @override
  State<SplaSh> createState() => _SplaShState();
}

class _SplaShState extends State<SplaSh> {
  @override
  void initState() {
    super.initState();
    getsharedpreference(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          "assets/animation/mini-animation.json",
        ),
      ),
    );
  }

  Future getsharedpreference(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    await precacheImage(
        const AssetImage('assets/new_expense_image.jpg'), context);
    await precacheImage(
        const AssetImage('assets/new_journal_image.jpg'), context);
    await precacheImage(const AssetImage('assets/new_todo_image.jpg'), context);

    final value = preference.getString('My Value');

    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (value == 'true') {
      await UserDb().getUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HiddenDrawer()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const StartPage(),
        ),
      );
    }
  }
}
