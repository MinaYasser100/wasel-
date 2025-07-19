import 'package:flutter/material.dart';
import 'package:wasel/core/utils/colors.dart';

/// Returns a [Container] with a background gradient that transitions from
/// [ColorsTheme().primaryColor] at the top to [ColorsTheme().accentColor] at the
/// bottom. This is used to color the background of the search view.
Container searchViewBackground() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [ColorsTheme().primaryColor, ColorsTheme().accentColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}
