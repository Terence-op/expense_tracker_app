import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function() click;
  const CustomButton({
    super.key,
    required this.text,
    required this.click,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: const Color(0xff665DED)),
        onPressed: click,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
