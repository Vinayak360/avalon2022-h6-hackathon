import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/fuel_provider.dart';

class FuelingLevel extends StatefulWidget {
  const FuelingLevel({Key? key}) : super(key: key);

  @override
  State<FuelingLevel> createState() => _FuelingLevelState();
}

class _FuelingLevelState extends State<FuelingLevel> {
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});

  int timeleft = 5;
  int score = 0;
  bool pop = false;

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FuelLevel>().deleteCount();
    StartTimer();
  }

  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeleft > 0) {
        setState(() {
          timeleft--;
        });
      } else {
        timer.cancel();
        if (context.read<FuelLevel>().fuelCount > 10) {
          await WonOrLost(context, "Congrats..!", "You Cleard the Level..!");

          Navigator.pop(context);
        } else {
          await WonOrLost(
              context, "Oh No You Lost..!", "Try again one more time..!");

          Navigator.pop(context);
        }
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
                  pop = true;
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
    var screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 15, 15, 46),
          body: Column(
            children: [
              Container(
                height: screen.height * 0.4,
                child: Column(
                  children: [
                    Text(
                      "Your Score: ${context.watch<FuelLevel>().FuelCount()}",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Target: 10",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Time left.!",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Text(
                      '${timeleft.toString()}',
                      style: GoogleFonts.poppins(
                        fontSize: 80,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screen.height * 0.5,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: <Widget>[
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                    Fuels(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class Fuels extends StatefulWidget {
  const Fuels({
    Key? key,
  }) : super(key: key);

  @override
  State<Fuels> createState() => _FuelsState();
}

class _FuelsState extends State<Fuels> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        child: InkWell(onDoubleTap: () {
          context.read<FuelLevel>().IncreaseFuel();
          setState(() {
            visible = false;
          });
        }),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/jerrycan.png"),
          ),
        ),
      ),
    );
  }
}
