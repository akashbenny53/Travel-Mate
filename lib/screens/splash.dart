import 'package:flutter/material.dart';
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
        child: Image.asset(
          'assets/Animation - 1727856139887.gif',
        ),
      ),
    );
  }

  Future getsharedpreference(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    final value = preference.getString('My Value');

    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (value == 'true') {
      await UserDb().getUser();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HiddenDrawer()),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const StartPage(),
        ),
      );
    }
  }
}
