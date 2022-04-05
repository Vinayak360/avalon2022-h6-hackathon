import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maze/maze.dart';
import 'package:provider/provider.dart';

class MazeRunner extends StatefulWidget {
  const MazeRunner({Key? key}) : super(key: key);

  @override
  State<MazeRunner> createState() => _MazeRunnerState();
}

class _MazeRunnerState extends State<MazeRunner> {
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  int timeleft = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StartTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();

    super.dispose();
  }

  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeleft > 0) {
        setState(() {
          timeleft--;
        });
      } else {
        timer.cancel();

        await WonOrLost(
            context, "Oh No You Lost..!", "Try again one more time..!");

        Navigator.pop(context);
      }
    });
  }

  Future<dynamic> WonOrLost(BuildContext context, String status, String desc) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$status",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 40),
              ),
              Text(
                "$desc",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"),
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff150485),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Time left: $timeleft",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
              ),
              Maze(
                  player: MazeItem('assets/astronaut.png', ImageType.asset),
                  columns: 10,
                  rows: 14,
                  finish: MazeItem('assets/spaceship.png', ImageType.asset),
                  onFinish: () async {
                    timer.cancel;
                    await WonOrLost(
                        context, "Congrats..!", "You Cleard the Level..!");
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // Future<dynamic> WonOrLost(BuildContext context, String status) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               "$status",
  //               style: GoogleFonts.poppins(fontSize: 40),
  //             ),
  //             Text(
  //               "You Cleared the Level..!",
  //               style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
  //             ),
  //             SizedBox(
  //               height: 30,
  //             ),
  //             ElevatedButton(
  //               onPressed: () => print("Level Cleared"),
  //               child: Text("Okay"),
  //             ),
  //           ],
  //         ));
  //       });
  // }
}
