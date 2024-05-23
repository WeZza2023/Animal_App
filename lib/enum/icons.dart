import 'package:flutter/material.dart';

enum ThemeImageIcon {
  facebook,
  google,
  cat,
  dog,
  person,
  filter,
}

class ThemeImageIconWidget extends StatelessWidget {
  final ThemeImageIcon image;
  final double? scale;
  final Color? color;

  ThemeImageIconWidget(
    this.image, {
    Key? key,
    this.scale,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getIcon();
  }

  Widget getIcon() {
    switch (image) {
      case ThemeImageIcon.facebook:
        return Image.asset(
          'assets/icons/facebook.png',
          scale: scale ?? 1.0,
        );
      case ThemeImageIcon.google:
        return Image.asset(
          'assets/icons/google.png',
          scale: scale ?? 1.0,
        );
      case ThemeImageIcon.cat:
        return Image.asset(
          'assets/icons/cat.png',
          scale: scale ?? 1.0,
          color: color ?? Colors.white,
        );
      case ThemeImageIcon.dog:
        return Image.asset(
          'assets/icons/dog.png',
          scale: scale ?? 1.0,
          color: color ?? Colors.white,
        );
      case ThemeImageIcon.person:
        return Image.asset(
          'assets/icons/person.png',
          scale: scale ?? 1.0,
          color: color ,
        );
      case ThemeImageIcon.filter:
        return Image.asset(
          'assets/icons/filter.png',
          scale: scale ?? 1.0,
          color: color ?? Colors.white,
        );
    }
  }
}
