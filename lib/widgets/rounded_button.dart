import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final EdgeInsets? padding;
  final Color? color;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            Theme.of(context).textTheme.subtitle1,
          ),
          padding: MaterialStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
              color ?? Theme.of(context).colorScheme.primary)),
    );
  }
}
