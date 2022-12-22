import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  TextStyle? textStyle;
  Color? textColor;
  double? height;
  double? width;
  Color? backgroundColor;
  VoidCallback onTabHandler;
  CustomButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.textColor,
    required this.onTabHandler,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabHandler,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
