import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClayContainer(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width * 0.6,
        borderRadius: 15,
        surfaceColor: Colors.white,
        parentColor: gradient.colors.last,
        spread: 3,
        color: Colors.white,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
