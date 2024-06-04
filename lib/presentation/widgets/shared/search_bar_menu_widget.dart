import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarMenuWidget<T> extends ConsumerStatefulWidget {
  final String? initialValue;
  final List<String> alreadySelectedProducts;
  final Function(T) onSelected;
  final List<T> values;
  final String? hintText;
  final bool withoutBorder;

  const SearchBarMenuWidget({
    super.key,
    this.initialValue,
    required this.values,
    required this.alreadySelectedProducts,
    required this.onSelected,
    this.hintText,
    this.withoutBorder = false,
  });

  const SearchBarMenuWidget.withoutBorder({
    super.key,
    this.initialValue,
    required this.values,
    required this.alreadySelectedProducts,
    required this.onSelected,
    this.hintText,
    this.withoutBorder = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchProductState<T>();
}

class _SearchProductState<T> extends ConsumerState<SearchBarMenuWidget<T>> {
  List<T> values = [];
  List<T> filteredValues = [];

  @override
  void initState() {
    super.initState();
    values = widget.values;
    filteredValues = values;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      viewOnChanged: _filterValues,
      viewBackgroundColor: colorScheme.surface,
      viewSurfaceTintColor: colorScheme.surface,
      viewShape: widget.withoutBorder
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusCornerInside),
              side: BorderSide(color: colorScheme.primaryContainer),
            ),
      dividerColor: Colors.transparent,
      suggestionsBuilder: (context, controller) {
        return filteredValues.map((value) => _buildListTile(controller, value)).toList();
      },
      builder: (context, controller) => _buildSearchBar(context, controller),
    );
  }

  void _filterValues(String value) {
    if (value.isEmpty) {
      filteredValues = values;
    }
    filteredValues = values.where((element) {
      if (element is Customer) {
        final byName = '${element.name} ${element.lastName}'.toLowerCase().contains(value.toLowerCase());
        final byEmail = element.email?.toLowerCase().contains(value.toLowerCase()) ?? false;
        return byName || byEmail;
      } else if (element is Product) {
        final byCode = element.code.toLowerCase().contains(value.toLowerCase());
        final byName = element.name.toLowerCase().contains(value.toLowerCase());
        return byCode || byName;
      } else if (element is PurchaseStatus) {
        final byName = element.name.toLowerCase().contains(value.toLowerCase());
        return byName;
      }

      return false;
    }).toList();
  }

  Widget _buildSearchBar(BuildContext context, SearchController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = widget.initialValue ?? '';
    });

    return SearchBar(
      controller: controller,
      leading: const Icon(PhosphorIcons.magnifying_glass),
      hintText: widget.hintText,
      side: widget.withoutBorder
          ? WidgetStateProperty.all(BorderSide.none)
          : WidgetStateProperty.all<BorderSide>(BorderSide(color: colorScheme.primaryContainer)),
      shape: widget.withoutBorder
          ? WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(side: BorderSide.none))
          : WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusCornerInside)),
            ),
      onTap: () {
        controller.openView();
      },
    );
  }

  Widget _buildListTile(SearchController controller, T value) {
    String title = '';
    String subtitle = '';

    if (value is Customer) {
      title = '${value.name} ${value.lastName}';
      subtitle = value.email ?? '-';
    } else if (value is Product) {
      title = value.name;
      subtitle = value.code;
    } else if (value is PurchaseStatus) {
      title = value.name;
    }

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => _select(controller, value),
    );
  }

  void _select(SearchController searchController, T value) {
    String selectedText = '';
    if (value is Customer) {
      selectedText = '${value.name} ${value.lastName}';
    } else if (value is Product) {
      selectedText = value.code;
    } else if (value is PurchaseStatus) {
      selectedText = value.name;
    }

    filteredValues = values;
    searchController.closeView(selectedText);
    widget.onSelected(value);
  }
}
