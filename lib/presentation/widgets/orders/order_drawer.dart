import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/order_summary.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/products_order_manager.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/selector_widget.dart';
import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDrawer extends ConsumerStatefulWidget {
  final PurchaseOrder? order;
  const OrderDrawer({super.key, this.order});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDrawerStateConsumer();
}

class _OrderDrawerStateConsumer extends ConsumerState<OrderDrawer> {
  List<Product> product = [];
  Customer? customer;
  PaymentMethod? paymentMethod;

  final globalKey = GlobalKey<FormState>();
  final paidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.order != null ? Texts.editCustomer : Texts.createOrder,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap.small(),
          const Divider(),
          const Gap.medium(),
          Expanded(
            child: ListView(
              children: [
                _buildCustomerSelector(),
                const Gap.small(),
                const Divider(),
                const Gap.small(),
                const SizedBox(height: 300, child: ProductsManager()),
                const Gap.small(),
                const Divider(),
                const Gap.small(),
                _buildPaymentMethodSelector(),
                const Gap.small(),
                _buildGivenAmount(),
                const Gap.small(),
                const Divider(),
                const Gap.small(),
                OrderSummary(paymentMethod: paymentMethod),
                Column(
                  children: [
                    const Gap.medium(),
                    const Divider(),
                    const Gap.medium(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
                            icon: const Icon(Icons.cancel),
                            onPressed: () => ref.read(navigationServiceProvider).goBack(context),
                            label: const Text(Texts.cancel),
                          ),
                          const Gap.small(isHorizontal: true),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
                            icon: const Icon(Icons.save),
                            onPressed: () => _onSubmit(),
                            label: Text(widget.order != null ? Texts.edit : Texts.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGivenAmount() {
    double total = calculateTotal();
    paidController.text = total.toStringAsFixed(2);

    return TextFormField(
      controller: paidController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: Texts.give),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value!.isEmpty) {
          return Texts.requiredField;
        }

        if (double.parse(value) > total.abs()) {
          return 'El monto no puede ser mayor al total de la compra.';
        }

        return null;
      },
    );
  }

  Widget _buildCustomerSelector() {
    final state = ref.watch(customersControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Texts.customer,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap.small(),
        state.when(
          data: (values) {
            return SelectorWidget<Customer>(
              label: Texts.customers,
              initialValue: customer?.name,
              items: values,
              onSelected: (value) {
                customer = value;
                setState(() {});
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
        const Gap.small(),
        if (customer != null) ...[
          Row(
            children: [
              Text(
                '${Texts.balance}: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                CurrencyFormatter.format(customer!.balance, arsSettings),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: customer?.balance == 0 ? Colors.green : Colors.red),
              ),
            ],
          )
        ],
      ],
    );
  }

  Widget _buildPaymentMethodSelector() {
    final state = ref.watch(paymentMethodsControllerProvider);

    return state.when(
      data: (values) {
        return SelectorWidget<PaymentMethod>(
          label: Texts.paymentMethods,
          initialValue: paymentMethod?.name,
          items: values,
          onSelected: (value) {
            paymentMethod = value;
            ref.read(orderProductsControllerProvider.notifier).applySurchargeToProducts(value!.surchargePercentage);
            setState(() {});
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }

  void _onSubmit() {
    List<PurchaseOrderProduct> productsSelected = ref.read(orderProductsControllerProvider);

    if (!globalKey.currentState!.validate()) {
      return;
    }

    if (productsSelected.isEmpty || customer == null || paymentMethod == null || paidController.text == '') {
      ToastUtils.showToast(context, Texts.requiredField, Texts.requiredFieldMessage, ToastType.error);
      return;
    }

    final double paid = double.parse(paidController.text);
    final double total = calculateTotal();

    PurchaseOrder order = PurchaseOrder(
      customer: customer!,
      products: productsSelected,
      debt: total - paid,
      total: total,
      paymentMethod: paymentMethod!,
    );

    ref.read(ordersControllerProvider.notifier).addOrder(order);
    ref.read(navigationServiceProvider).goBack(context);
  }

  double calculateTotal() {
    final products = ref.watch(orderProductsControllerProvider);
    return products.fold(0, (previousValue, element) => previousValue + (element.unitPrice * element.quantity));
  }
}
