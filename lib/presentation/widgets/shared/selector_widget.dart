import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectorWidget<T> extends ConsumerStatefulWidget {
  final String? initialValue;
  final String label;
  final List<T> items;
  final void Function(T?) onSelected;
  final bool asFilter;

  const SelectorWidget({
    super.key,
    this.initialValue,
    required this.label,
    required this.items,
    required this.onSelected,
    this.asFilter = false,
  });
  const SelectorWidget.asFilter({
    super.key,
    this.initialValue,
    required this.label,
    required this.items,
    required this.onSelected,
    this.asFilter = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerSelectorState<T?>();
}

class _CustomerSelectorState<T> extends ConsumerState<SelectorWidget<T?>> {
  T? _selected;
  List items = [];
  bool isCustomer = false;
  bool isProduct = false;
  bool isCategory = false;
  bool isPaymentMethod = false;

  @override
  initState() {
    super.initState();
    items = widget.items;
    if (widget.initialValue != null) {
      _selected = items.firstWhere((element) => element.id == widget.initialValue);
    }

    if (items.isNotEmpty && items.first.runtimeType == Customer) {
      isCustomer = true;
      setState(() {});
    }

    if (items.isNotEmpty && items.first.runtimeType == Product) {
      isProduct = true;
      setState(() {});
    }

    if (items.isNotEmpty && items.first.runtimeType == Category) {
      isCategory = true;
      setState(() {});
    }

    if (items.isNotEmpty && items.first.runtimeType == PaymentMethod) {
      isPaymentMethod = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
      decoration: widget.asFilter ? dropdownAsFilterDecoration : null,
      borderRadius: BorderRadius.circular(widget.asFilter ? 0 : kRadiusCornerInside),
      hint: Text(
        widget.label,
        style: widget.asFilter
            ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: colorScheme.inversePrimary)
            : null,
      ),
      value: _selected,
      validator: (value) {
        if (value == null) {
          return Texts.requiredField;
        }
        return null;
      },
      icon: _selected == null
          ? null
          : Center(
              child: IconButton(
                icon: const Center(child: Icon(PhosphorIcons.x, size: 14)),
                onPressed: () => _onClear(),
              ),
            ),
      onChanged: (value) => _onChange(value),
      items: items.map<DropdownMenuItem<T>>(
        (value) {
          var text = widget.label;
          if (isCustomer) {
            text = '${value.name.toUpperCase()} ${value.lastName.toUpperCase()}';
          } else if (isProduct) {
            text = value.code;
          } else if (isCategory) {
            text = value.name.toUpperCase();
          } else if (isPaymentMethod) {
            text = value.name.toString();
          } else if (!widget.asFilter) {
            text = 'Seleccionar';
          }

          return DropdownMenuItem<T>(
            value: value,
            child: Text(text),
          );
        },
      ).toList(),
    );
  }

  _onChange(T? value) {
    _selected = items.firstWhere((element) => element == value);
    widget.onSelected(_selected);
    setState(() {});
  }

  _onClear() {
    _selected = null;
    widget.onSelected(null);
    setState(() {});
  }
}
