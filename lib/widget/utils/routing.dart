import 'package:flutter/material.dart';

class NoAnimatedPageRoute extends MaterialPageRoute {
  NoAnimatedPageRoute({builder, settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
