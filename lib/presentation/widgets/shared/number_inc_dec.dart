import 'package:control_stock_web_admin/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class NumberIncDec extends StatefulWidget {
  final int? value;
  final int? maxValue;
  final String? label;
  final bool withoutBorder;
  final void Function(int) onChanged;

  const NumberIncDec({
    super.key,
    this.value,
    this.maxValue,
    this.label,
    required this.onChanged,
    this.withoutBorder = false,
  });

  const NumberIncDec.withoutBorder({
    super.key,
    this.value,
    this.maxValue,
    this.label,
    required this.onChanged,
  }) : withoutBorder = true;

  @override
  State<NumberIncDec> createState() => _NumberIncDecState();
}

class _NumberIncDecState extends State<NumberIncDec> {
  int value = 0;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    value = widget.value ?? 0;
    controller.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextFormField(
        readOnly: true,
        controller: controller,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 20),
          border: widget.withoutBorder ? InputBorder.none : const OutlineInputBorder(),
          enabledBorder: widget.withoutBorder ? InputBorder.none : const OutlineInputBorder(),
          errorBorder: widget.withoutBorder ? InputBorder.none : const OutlineInputBorder(),
          focusedErrorBorder: widget.withoutBorder ? InputBorder.none : const OutlineInputBorder(),
          focusColor: colorScheme.primaryContainer,
          label: Text(widget.label ?? ''),
          prefixIcon: IconButton(
            focusNode: FocusNode(canRequestFocus: false),
            padding: EdgeInsets.zero,
            icon: const Icon(PhosphorIcons.minus, size: 16),
            onPressed: () {
              if (value > 0) {
                value--;
                controller.text = value.toString();
                widget.onChanged(value);
                setState(() {});
              }
            },
          ),
          suffixIcon: IconButton(
            focusNode: FocusNode(canRequestFocus: false),
            padding: EdgeInsets.zero,
            icon: const Icon(PhosphorIcons.plus, size: 16),
            onPressed: () {
              if (widget.maxValue != null && value >= widget.maxValue!) {
                return;
              }

              value++;
              controller.text = value.toString();
              widget.onChanged(value);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
