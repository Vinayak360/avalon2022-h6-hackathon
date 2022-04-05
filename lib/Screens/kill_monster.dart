import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MonsterScreen extends StatefulWidget {
  const MonsterScreen({Key? key}) : super(key: key);

  @override
  State<MonsterScreen> createState() => _MonsterScreenState();
}

class _MonsterScreenState extends State<MonsterScreen> {
  double kill = 1;
  Color? color = Colors.blue;
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  int timeleft = 30;
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
    timer = Timer.periodic(Duration(seconds: 1), (v) async {
      if (timeleft > 0) {
        setState(() {
          timeleft--;
          kill = kill + 0.07;
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
        backgroundColor: Color.fromARGB(255, 15, 15, 46),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
              child: Text(
                "Tap to killl",
                style: GoogleFonts.poppins(fontSize: 60, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/monster.png'),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: () async {
                  SystemSound.play(SystemSoundType.click);
                  setState(() {
                    kill -= 0.02;
                  });
                  if (kill < 0.2) {
                    setState(() {
                      color = Colors.red;
                    });
                  }
                  if (kill < 0.01) {
                    timer.cancel();
                    await WonOrLost(
                        context, "Congrats..!", "You cleared the Level.!");
                    Navigator.pop(context);
                  }
                }),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Container(
                  height: 50,
                  width: (MediaQuery.of(context).size.width) * kill < 0
                      ? 10
                      : (MediaQuery.of(context).size.width) * kill,
                  color: color,
                )
              ],
            ),
            Center(
              child: Text(
                timeleft.toString(),
                style: GoogleFonts.poppins(fontSize: 60, color: Colors.white),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
