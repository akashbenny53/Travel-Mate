import 'package:flutter/material.dart';
import 'package:travel_app/screens/planning.dart';
import 'package:travel_app/screens/secondpage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 233, 234),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 70, 140, 30),
              child: Text(
                'We create the trips, you love most',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ),
            // const SizedBox(
            //   height: 0,
            // ),
            const Image(
              image: AssetImage(
                'assets/forest.jpg',
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
                    builder: (context) => const SecPage(),
                  ),
                ),
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll<Size>(
                    Size(120, 50),
                  ),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.black),
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).width * .1,
        ),
        child: IconButton(
          icon: const Icon(Icons.navigate_next_outlined),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const JourneyPlan(),
              ),
            );
          },
          // backgroundColor: Colors.black,
          // foregroundColor: Colors.black,
          // child: const Icon(Icons.navigate_next_outlined),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
