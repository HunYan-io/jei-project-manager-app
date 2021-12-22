import 'package:flutter/material.dart';

class MyInputTheme{


  OutlineInputBorder _buildBorder(Color color){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    )
    ;
  }

    InputDecorationTheme theme() => InputDecorationTheme(

      floatingLabelBehavior: FloatingLabelBehavior.never,
      isDense: true,
      ///Borders
        enabledBorder: _buildBorder(Color(0xFF171a33)),
        focusedBorder: _buildBorder(Color(0xFF8a2831)),





    );

}