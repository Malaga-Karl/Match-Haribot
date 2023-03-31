import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/image.dart';
import 'dart:async';

import '../components/custom_box.dart';
import '../models/custom_card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final Stopwatch _stopwatch;
  late final Duration _timerInterval;
  late final Timer _timer;
  bool isStarted = false;
  bool isPlaying = false;

  final AudioPlayer success = AudioPlayer();

  Future<void> ring() async {
    // await audioPlayer.setSource(AssetSource('assets/music/bg.mp3'));

    // await audioPlayer.resume();
    await success.setPlaybackRate(1.5);
    await success.play(AssetSource('music/success.mp3'), volume: 0.5);
  }

  List<HaribotCard> allCards = [
    HaribotCard('Baby Buster', Image.asset('assets/babybuster.png'), 1, false,
        Color.fromRGBO(214, 255, 223, 1)),
    HaribotCard('Baby Buster', Image.asset('assets/babybuster.png'), 1, false,
        Color.fromRGBO(214, 255, 223, 1)),
    HaribotCard('Haribot', Image.asset('assets/haribot.png'), 2, false,
        Color.fromRGBO(215, 215, 215, 1)),
    HaribotCard('Haribot', Image.asset('assets/haribot.png'), 2, false,
        Color.fromRGBO(215, 215, 215, 1)),
    HaribotCard('Honeydroid', Image.asset('assets/honeydroid.png'), 3, false,
        Color.fromRGBO(254, 255, 221, 1)),
    HaribotCard('Honeydroid', Image.asset('assets/honeydroid.png'), 3, false,
        Color.fromRGBO(254, 255, 221, 1)),
    HaribotCard('Popstron', Image.asset('assets/popstron.png'), 4, false,
        Color.fromRGBO(211, 237, 255, 1)),
    HaribotCard('Popstron', Image.asset('assets/popstron.png'), 4, false,
        Color.fromRGBO(211, 237, 255, 1)),
    HaribotCard('Siborg', Image.asset('assets/siborg.png'), 5, false,
        Color.fromRGBO(253, 220, 220, 1)),
    HaribotCard('Siborg', Image.asset('assets/siborg.png'), 5, false,
        Color.fromRGBO(253, 220, 220, 1)),
    HaribotCard('GDSC', Image.asset('assets/gdsc.png'), 6, false,
        Color.fromRGBO(255, 255, 255, 1)),
    HaribotCard('GDSC', Image.asset('assets/gdsc.png'), 6, false,
        Color.fromRGBO(255, 255, 255, 1)),
  ];

  void toggleActive(int index) {
    setState(() {
      if (!allCards[index].done && !allCards[index].active) {
        allCards[index].active = !allCards[index].active;
      }
      if (!isStarted) {
        _stopwatch.start();
        setState(() {
          isStarted = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    allCards.shuffle();
    _stopwatch = Stopwatch();
    _timerInterval = const Duration(milliseconds: 100);
    _timer = Timer.periodic(_timerInterval, (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timerText {
    final duration = _stopwatch.elapsed;
    final seconds = duration.inSeconds % 60;
    final minutes = duration.inMinutes % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int moves = 0;
  @override
  Widget build(BuildContext context) {
    List<HaribotCard> activeCards =
        allCards.where((activity) => activity.active).toList();

    void clearArray() {
      activeCards[0].active = false;
      activeCards[1].active = false;
      activeCards.clear();
    }

    void checkMatch() async {
      if (activeCards[0].value == activeCards[1].value) {
        var matchedCards =
            allCards.where((card) => card.name == activeCards[0].name);
        for (var card in matchedCards) {
          card.done = true;
          card.background = card.background.withOpacity(0.5);
        }
        if (isPlaying) {
          await success.stop();
          ring();
        } else {
          ring();
        }

        setState(() {
          isPlaying = true;
        });

        print('match');
      } else {
        print('not match');
      }

      Timer(Duration(milliseconds: 200), () {
        setState(() {
          clearArray();
          isPlaying = false;
        });
      });
      return;
    }

    if (activeCards.length == 2) {
      checkMatch();
      moves++;
    }

    if (allCards.every((card) => card.done)) {
      _stopwatch.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            timerText,
            style: TextStyle(fontFamily: 'Helvetica', fontSize: 60),
          ),
        ),
        toolbarHeight: 150,
        backgroundColor: Color.fromARGB(255, 19, 62, 156),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: GridView.builder(
              itemCount:
                  allCards.length, // Replace imageList with your list of images
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Change the number of columns here
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Custom_Box(
                  photo: allCards[index].image,
                  visible: allCards[index].active || allCards[index].done,
                  setActive: (p0) => toggleActive(index),
                  background: allCards[index].background,
                );
              },
            ),
          )),
          Visibility(
            visible: (allCards.every((card) => card.done)),
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'CONGRATULATIONS!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                  Center(
                    child: Text(
                      'Score: ${(moves).toString()}',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        for (var card in allCards) {
                          card.done = false;
                          card.background = card.background.withOpacity(1);
                        }
                        moves = 0;
                        initState();
                      },
                      child: Text('Play Again!'))
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
