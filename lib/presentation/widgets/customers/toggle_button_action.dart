import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';

enum ActionOverBalance { customerGiveMoney, commerceReturnMoney }

const List<(ActionOverBalance, String)> actionsOptions = <(ActionOverBalance, String)>[
  (ActionOverBalance.commerceReturnMoney, Texts.commerceReturnMoney),
  (ActionOverBalance.customerGiveMoney, Texts.customerGiveMoney),
];

class ToggleButtonAction extends StatefulWidget {
  final Function(ActionOverBalance) onChange;

  const ToggleButtonAction({super.key, required this.onChange});

  @override
  State<ToggleButtonAction> createState() => _ToggleButtonActionState();
}

class _ToggleButtonActionState extends State<ToggleButtonAction> {
  final List<bool> _selectedAction = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedAction.length; i++) {
            _selectedAction[i] = i == index;
            widget.onChange(actionsOptions[index].$1);
          }
        });
      },
      borderRadius: BorderRadius.circular(kRadiusCornerInside),
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 100.0,
      ),
      isSelected: _selectedAction,
      children: actionsOptions
          .map((e) => Padding(
                padding: kPaddingAppSmall,
                child: Text(e.$2),
              ))
          .toList(),
    );
  }
}
