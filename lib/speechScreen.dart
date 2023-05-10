import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechtotext = SpeechToText();
  var text = "Hold the button and start speaking";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.sort_rounded)),
          backgroundColor: bgColor,
          elevation: 0.0,
          title: const Text(
            "speech to text",
            style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
        body: Container(
          //color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Center(
              child: Text(
            text,
          )),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat, // to set it to center
        floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: Duration(milliseconds: 2000),
          glowColor: bgColor,
          repeat: true,
          repeatPauseDuration: Duration(milliseconds: -500),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (deets) async {
              if (!isListening) {
                var available = await speechtotext.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechtotext.listen(onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    });
                  });
                }
              }
            },
            onTapUp: (deets) {
              setState(() {
                isListening = false;
              });
              speechtotext.stop();
            },
            child: CircleAvatar(
              backgroundColor: bgColor,
              radius: 35,
              child: Icon(
                isListening
                    ? Icons.mic
                    : Icons
                        .mic_none, // to change the icon as per the value of islintening
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ));
  }
}
