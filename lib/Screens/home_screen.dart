import 'package:flutter/material.dart';
import 'package:galaxy_game/Screens/levels.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 15, 15, 46),
        body: Container(
          height: screen.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/stars.png',
                ),
                fit: BoxFit.cover,
                opacity: 0.1),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: screen.height * 0.4,
                  child: Lottie.asset('assets/astronaut.json'),
                ),
              ),
              Align(
                child: TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LevelScreen(),
                      )),
                  child: Text(
                    "Let's PLAY.!",
                    style: GoogleFonts.poppins(
                        fontSize: 30, letterSpacing: 4, color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                  child: Text(
                    "Help V to escape Earth and go on Destroy some Monsters!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        letterSpacing: 4,
                        color: Colors.cyanAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
