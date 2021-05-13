import 'package:flutter/material.dart';

class NoAnimatedPageRoute extends MaterialPageRoute {
  NoAnimatedPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
