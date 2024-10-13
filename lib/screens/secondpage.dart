import 'package:flutter/material.dart';
import 'package:travel_app/screens/thirdpage.dart';

class SecPage extends StatelessWidget {
  const SecPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 70, 120, 30),
              child: Text(
                'Plan the trip in most\naffordable way',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Colors.black),
              ),
            ),
            // const SizedBox(
            //   height: 40,
            // ),
            const Image(
              image: AssetImage(
                'assets/plan-travel.jpg',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).width * .1,
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ThiPage(),
                  ),
                ),
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll<Size>(
                      Size(120, 50),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black),
                    foregroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white)),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
