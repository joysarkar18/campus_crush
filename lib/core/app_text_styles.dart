import 'package:flutter/material.dart';

class AppTextStyles {
  // Base method to return Montserrat TextStyle with specific weight and default white color
  static TextStyle _montserrat({
    required FontWeight fontWeight,
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  // Methods for different font weights with default white color
  static TextStyle monserrat400({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w400,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle monserrat500({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle monserrat600({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle monserrat700({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w700,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle monserrat800({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle monserrat900({
    Color color = Colors.black,
    double? fontSize,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return _montserrat(
      fontWeight: FontWeight.w900,
      color: color,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      overflow: overflow,
    );
  }
}
