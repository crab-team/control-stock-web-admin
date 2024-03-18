import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/version_widget.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: kPaddingApp,
      child: Column(
        children: [LogoWidget.horizontal(), Gap.large(), VersionWidget()],
      ),
    );
  }
}
