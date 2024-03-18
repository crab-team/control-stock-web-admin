import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final bool isHorizontal;

  const LogoWidget.horizontal({super.key, this.isHorizontal = true});
  const LogoWidget.vertical({super.key, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      switch (isHorizontal) {
        case true:
          return SizedBox(width: constraints.maxWidth, height: 100, child: const Placeholder());
        default:
          return const Placeholder();
      }
    }));
  }
}
