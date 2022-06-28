import 'package:flutter/material.dart';

class RoundedSubmitButton extends StatelessWidget {
  final String text;
  final Function function;

  const RoundedSubmitButton({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: Colors.blue,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        function();
      },
    );
  }
}
