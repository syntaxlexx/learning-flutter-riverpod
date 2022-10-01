import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiCard extends StatefulWidget {
  const ConfettiCard({super.key});

  @override
  State createState() => _ConfettiCardState();
}

class _ConfettiCardState extends State<ConfettiCard> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();

    return Column(
      children: [
        // TextButton(
        //   onPressed: () {
        //     _confettiController.play();
        //   },
        //   child: Text('confetti'),
        // ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
      ],
    );
  }
}
