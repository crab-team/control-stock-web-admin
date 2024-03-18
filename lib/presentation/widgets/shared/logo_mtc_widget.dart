import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';

class LogoMtcWidget extends StatelessWidget {
  const LogoMtcWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImages.logoMtc,
      width: 100,
    );
  }
}
