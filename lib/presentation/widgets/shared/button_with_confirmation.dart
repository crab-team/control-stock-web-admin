import 'package:control_stock_web_admin/core/theme.dart';
import 'package:flutter/material.dart';

class ButtonWithConfirmation extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final void Function() onConfirm;
  const ButtonWithConfirmation({super.key, this.label, this.icon, required this.onConfirm});

  @override
  State<ButtonWithConfirmation> createState() => _ButtonWithConfirmationState();
}

class _ButtonWithConfirmationState extends State<ButtonWithConfirmation> {
  bool _showConfirmationState = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_showConfirmationState,
      replacement: Container(
        width: 80,
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: colorScheme.primary,
              ),
              onPressed: () {
                widget.onConfirm();
                setState(() {
                  _showConfirmationState = false;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: colorScheme.tertiary,
              ),
              onPressed: () => setState(() {
                _showConfirmationState = false;
              }),
            ),
          ],
        ),
      ),
      child: widget.label != null
          ? ElevatedButton.icon(
              icon: Icon(
                widget.icon ?? Icons.delete,
              ),
              label: Text(widget.label ?? ''),
              onPressed: () => setState(() {
                _showConfirmationState = true;
              }),
            )
          : IconButton(
              icon: Icon(
                widget.icon ?? Icons.delete,
                color: colorScheme.primary,
              ),
              onPressed: () => setState(() {
                _showConfirmationState = true;
              }),
            ),
    );
  }
}
