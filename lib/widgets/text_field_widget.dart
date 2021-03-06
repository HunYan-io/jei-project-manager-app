import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {

  late String text;
  late double size;
  TextFieldWidget(this.text,this.size);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF171a33),
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}


