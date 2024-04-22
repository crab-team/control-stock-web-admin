import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class NumberIncDec extends StatefulWidget {
  final int? initialValue;
  final int? maxValue;
  final String? label;
  final void Function(int) onChanged;

  const NumberIncDec({super.key, this.initialValue, this.maxValue, this.label, required this.onChanged});

  @override
  State<NumberIncDec> createState() => _NumberIncDecState();
}

class _NumberIncDecState extends State<NumberIncDec> {
  int value = 0;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? 0;
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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          label: Text(widget.label ?? ''),
          prefix: IconButton(
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
          suffix: IconButton(
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
