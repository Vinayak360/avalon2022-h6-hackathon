import 'package:flutter/material.dart';
import 'package:galaxy_game/Screens/fueling_level.dart';
import 'package:galaxy_game/Screens/kill_monster.dart';
import 'package:galaxy_game/Screens/maze_runner.dart';
import 'package:galaxy_game/Screens/quiz_level.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LevelsWidget(
                level: '1',
                NextScreen: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MazeRunner(),
                    )),
                levelDesc:
                    'Oh No.! V is confused in a maze help him to reach his spaceship and escape Earth..',
              ),
              LevelsWidget(
                level: '2',
                NextScreen: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(),
                    )),
                levelDesc:
                    'Space Control..! V doesn\'t have a License, Answer few Questions and Get the License',
              ),
              LevelsWidget(
                level: '3',
                NextScreen: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FuelingLevel(),
                    )),
                levelDesc:
                    'Low Fuel.! Low Fuel.! Low Fuel.! Double Tap to get the Required Fuel.!',
              ),
              LevelsWidget(
                level: '4',
                NextScreen: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MonsterScreen(),
                    )),
                levelDesc:
                    'Let\'s Kill the Monster. Just Tap on the screen and destroy him..!',
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class LevelsWidget extends StatelessWidget {
  final String level;
  final String levelDesc;
  final VoidCallback NextScreen;
  const LevelsWidget({
    Key? key,
    required this.level,
    required this.levelDesc,
    required this.NextScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blue,
        child: ExpansionTile(
          backgroundColor: Colors.blue,
          title: Text(
            "Level $level",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          children: <Widget>[
            ListTile(
              trailing: TextButton(
                onPressed: () => NextScreen(),
                child: Text(
                  'Play.!',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
              ),
              title: Text(
                levelDesc,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
