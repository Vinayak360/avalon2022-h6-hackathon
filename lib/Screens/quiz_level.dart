import 'package:flutter/material.dart';
import 'package:galaxy_game/Provider/quiz_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController controller;

  int pageNumber = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    context.read<QuizLevel>().startGame();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 46),
      body: PageView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(255, 15, 15, 46),
                child: QuizzWidget(
                  screen: screen,
                  controller: controller,
                  pageNumber: pageNumber,
                  opt1: "Earth",
                  opt2: "Sun",
                  opt3: "Jupiter",
                  opt4: "Venus",
                  question: "Which is the largest Planet in Our Solar System?",
                  answer: "Jupiter",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Color(0xff180A0A),
                child: QuizzWidget(
                  screen: screen,
                  controller: controller,
                  pageNumber: pageNumber,
                  opt1: "Pluto",
                  opt2: "Sun",
                  opt3: "Moon",
                  opt4: "Venus",
                  question: "Which planet is considered as the Dwarf Planet.?",
                  answer: "Pluto",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Color(0xff1F1D36),
                child: QuizzWidget(
                  screen: screen,
                  controller: controller,
                  pageNumber: pageNumber,
                  opt1: "Andromeda Galaxy.",
                  opt2: "Milky Way Galaxy.",
                  opt3: "Cygnus A.",
                  opt4: "Virgo A.",
                  question: "What is the name of our Galaxy?",
                  answer: "Milky Way Galaxy.",
                ),
              ),
            ),
          ]),
    ));
  }
}

class QuizzWidget extends StatefulWidget {
  const QuizzWidget({
    Key? key,
    required this.screen,
    required this.controller,
    required this.pageNumber,
    required this.question,
    required this.answer,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
  }) : super(key: key);

  final Size screen;
  final PageController controller;
  final int pageNumber;
  final String question;
  final String answer;
  final String opt1;
  final String opt2;
  final String opt3;
  final String opt4;

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  bool checkOpt1() {
    if (widget.opt1 == widget.answer) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOpt2() {
    if (widget.opt2 == widget.answer) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOpt3() {
    if (widget.opt3 == widget.answer) {
      return true;
    } else {
      return false;
    }
  }

  bool checkOpt4() {
    if (widget.opt4 == widget.answer) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'Tries Left: ${context.watch<QuizLevel>().TriesLeft()}',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Text(
          widget.question,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        height: 100,
      ),
      QuizOptions(
        screen: widget.screen,
        option: widget.opt1,
        correct: checkOpt1(),
        controller: widget.controller,
        page: widget.pageNumber,
      ),
      QuizOptions(
        screen: widget.screen,
        option: widget.opt2,
        controller: widget.controller,
        page: widget.pageNumber,
        correct: checkOpt2(),
      ),
      QuizOptions(
        screen: widget.screen,
        option: widget.opt3,
        correct: checkOpt3(),
        controller: widget.controller,
        page: widget.pageNumber,
      ),
      QuizOptions(
        screen: widget.screen,
        option: widget.opt4,
        correct: checkOpt4(),
        controller: widget.controller,
        page: widget.pageNumber,
      ),
    ]);
  }
}

class QuizOptions extends StatefulWidget {
  const QuizOptions({
    Key? key,
    required this.screen,
    required this.option,
    required this.correct,
    required this.controller,
    required this.page,
  }) : super(key: key);

  final Size screen;
  final String option;
  final bool correct;
  final PageController controller;
  final int page;

  @override
  State<QuizOptions> createState() => _QuizOptionsState();
}

class _QuizOptionsState extends State<QuizOptions> {
  bool change = false;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 60,
        width: widget.screen.width - 30,
        decoration: BoxDecoration(
          color: change == false ? Colors.deepPurpleAccent : Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              if (context.read<QuizLevel>().triesLeft > 1) {
                if (widget.correct == true) {
                  context.read<QuizLevel>().RightAns();
                  setState(() {
                    change = true;
                  });

                  if (context.read<QuizLevel>().MovePage > 2) {
                    await WonOrLost(
                        context, "Congrats..!", "You Cleard the Level..!");
                    Navigator.pop(context);
                  }

                  widget.controller.animateToPage(
                    context.read<QuizLevel>().MovePage,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                  );
                } else {
                  context.read<QuizLevel>().WrongAns();
                }
              } else {
                await WonOrLost(
                    context, "Oh No You Lost..!", "Try again one more time..!");
                Navigator.pop(context);
              }
            },
            child: Center(
              child: Text(
                widget.option,
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
