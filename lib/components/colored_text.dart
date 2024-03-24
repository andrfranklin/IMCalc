import 'package:flutter/material.dart';

class ColoredText extends StatelessWidget {
  const ColoredText({super.key, this.imc = 0.0});

  final double imc;

  _textColor(double value) {
    if (value == 0.0) {
      return Colors.black;
    }

    if (value < 18.5) {
      return Colors.blue;
    }

    if (value < 25) {
      return Colors.green;
    }

    if (value < 30) {
      return Colors.amber;
    }

    if (value < 35) {
      return const Color.fromARGB(255, 160, 120, 2);
    }

    if (value < 40) {
      return Colors.orange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'IMC: ${imc.toStringAsFixed(2)}',
            style: TextStyle(color: _textColor(imc), shadows: const [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.grey,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
