import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/order.dart';
import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:control_stock_web_admin/domain/entities/product_order.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/order_products_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/order_summary.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/products_order_manager.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDrawer extends ConsumerStatefulWidget {
  final Order? order;
  const OrderDrawer({super.key, this.order});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDrawerStateConsumer();
}

class _OrderDrawerStateConsumer extends ConsumerState<OrderDrawer> {
  List<Product> product = [];
  Customer? customer;

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.order != null ? Texts.editCustomer : Texts.createOrder,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap.medium(),
        const Divider(),
        const Gap.medium(),
        Expanded(
          child: ListView(
            children: [
              _buildCustomerSelector(),
              const Gap.small(),
              const Divider(),
              const Gap.small(),
              const SizedBox(height: 400, child: ProductsManager()),
              const Gap.small(),
              const Divider(),
              const Gap.small(),
              const OrderSummary(),
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
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(error.toString())),
        ),
      ],
    );
  }

  void _onSubmit() {
    List<ProductOrder> productsSelected = ref.read(orderProductsControllerProvider);
    if (productsSelected.isEmpty || customer == null) return;

    Order order = Order(
      customer: customer!,
      products: productsSelected,
      paymentMethod: 'Contado',
    );

    ref.read(ordersControllerProvider.notifier).addOrder(order);
    ref.read(navigationServiceProvider).goBack(context);
  }
}
