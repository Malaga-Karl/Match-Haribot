import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game/screens/gameScreen.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  final AudioPlayer bird = AudioPlayer();

  Future<void> chirp() async {
    // await audioPlayer.setSource(AssetSource('assets/music/bg.mp3'));

    await bird.setPlaybackRate(1.5);
    await bird.play(AssetSource('music/chirp.mp3'), volume: 0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sky.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset('assets/gifs/honeydroid.gif'),
        ),
        Positioned(
          left: 0,
          child: Image.asset('assets/gifs/siborg.gif'),
        ),
        Positioned(
          bottom: 0,
          child: Image.asset('assets/gifs/popstron.gif'),
        ),
        Positioned(
          right: 0,
          child: Image.asset('assets/gifs/babybuster.gif'),
        ),
        Positioned(
          top: 0,
          child: Image.asset('assets/gifs/haribot.gif'),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'MATCH\nHARIBOT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'customTitle',
                    fontSize: 70,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(150, 70))),
                onPressed: () {
                  chirp();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()));
                },
                child: Text('Play'),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
