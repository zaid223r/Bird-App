import 'package:bonus/IntroductionScreen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: double.infinity,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const App()));
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Image(
                    image:
                        AssetImage("assets/splashscreen.png"),
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    "Bird World",
                    style: TextStyle(
                        fontSize: 36, color: Color.fromARGB(255, 78, 12, 103)),
                  ),
              const SizedBox(height: 180,),
              const Text(
                "Click anywhere to start",
                style: TextStyle(color: Color.fromARGB(109, 122, 35, 156)),
              ),],
          ),
        ),
      )
    ));
  }
}
