import 'package:flutter/material.dart';

class ImcImageShow extends StatelessWidget {
  const ImcImageShow({super.key, this.imc = 0.0});

  final double imc;

  _imcImage(double value) {
    String imagePath = 'assets/images/';
    if (value < 18.5) {
      return '${imagePath}imc_1.webp';
    }

    if (value < 25) {
      return '${imagePath}imc_2.webp';
    }

    if (value < 30) {
      return '${imagePath}imc_3.webp';
    }

    if (value < 35) {
      return '${imagePath}imc_4.webp';
    }

    if (value < 40) {
      return '${imagePath}imc_5.webp';
    }

    if (value > 40) {
      return '${imagePath}imc_6.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imc != 0 ? [Image.asset(_imcImage(imc))] : [],
    );
  }
}
