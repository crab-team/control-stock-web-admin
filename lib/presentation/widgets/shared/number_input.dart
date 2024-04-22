import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final double? maxValue;
  final TextEditingController controller;

  const NumberInput({super.key, this.maxValue, required this.controller});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: Texts.give),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*[,]?\d*')),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return Texts.requiredField;
        }

        double valueDouble = double.parse(value.replaceAll(',', '.'));

        if (widget.maxValue != null) {
          if (valueDouble > widget.maxValue!) {
            return Texts.valueSuperiorToTotal;
          }
        }

        widget.controller.text = valueDouble.toStringAsFixed(2);

        return null;
      },
    );
  }
}
