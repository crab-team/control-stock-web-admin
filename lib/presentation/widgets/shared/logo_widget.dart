import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final bool isHorizontal;
  final bool withText;
  final double? size;

  const LogoWidget.horizontal({super.key, this.isHorizontal = true, this.withText = true, this.size = 42});
  const LogoWidget.vertical({super.key, this.isHorizontal = false, this.withText = true, this.size = 42});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: ((context) {
      switch (isHorizontal) {
        case true:
          return Row(
            mainAxisAlignment: withText ? MainAxisAlignment.start : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AssetsImages.logo,
                width: size,
              ),
              Visibility(
                visible: withText,
                child: Row(
                  children: [
                    const Gap.small(isHorizontal: true),
                    Text(
                      'Control Stock',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: (size ?? 32) * 0.5),
                    ),
                  ],
                ),
              ),
            ],
          );
        default:
          return Column(
            children: [
              Image.asset(
                AssetsImages.logo,
                width: size,
              ),
              Visibility(
                visible: withText,
                child: Column(
                  children: [
                    const Gap.small(),
                    Text(
                      'Control Stock',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ],
          );
      }
    }));
  }
}
