// import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
// import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
// import 'package:control_stock_web_admin/presentation/utils/constants.dart';
// import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
// import 'package:control_stock_web_admin/presentation/widgets/shared/selector_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PaymentMethodSelector extends ConsumerStatefulWidget {
//   final PaymentMethod? initialValue;
//   final void Function(PaymentMethod?) onConfirm;

//   const PaymentMethodSelector({super.key, this.initialValue, required this.onConfirm});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _PaymentMethodSelectorState();
// }

// class _PaymentMethodSelectorState extends ConsumerState<PaymentMethodSelector> {
//   List<PaymentMethod> paymentMethods = [];
//   PaymentMethod? _selected;

//   @override
//   void initState() {
//     super.initState();
//     paymentMethods = ref.read(paymentMethodsControllerProvider.notifier).paymentMethods;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SelectorWidget<PaymentMethod>(
//             label: Texts.paymentMethods,
//             items: paymentMethods,
//             onSelected: (value) {
//               setState(() {
//                 _selected = value;
//                 widget.onConfirm(value);
//               });
//             }),
//         const Gap.small(),
//       ],
//     );
//   }
// }
