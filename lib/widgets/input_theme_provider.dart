import 'package:flutter/material.dart';

class InputThemeProvider extends StatelessWidget {
  final Widget child;
  const InputThemeProvider({Key? key, required this.child}) : super(key: key);

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
        data: theme.copyWith(
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,

            ///Borders
            enabledBorder: _buildBorder(theme.colorScheme.primary),
            focusedBorder: _buildBorder(theme.colorScheme.secondary),
          ),
        ),
        child: child);
  }
}
