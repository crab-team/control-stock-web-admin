import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/category.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerRecordDrawer extends ConsumerStatefulWidget {
  final Customer? client;
  const CustomerRecordDrawer({super.key, this.client});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends ConsumerState<CustomerRecordDrawer> {
  final formKey = GlobalKey<FormState>();
  String selectedType = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Category? category;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      nameController.text = widget.client!.name;
      lastNameController.text = widget.client!.lastName;
      emailController.text = widget.client!.email ?? '';
      phoneController.text = widget.client!.phone ?? '';
      addressController.text = widget.client!.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.client != null ? Texts.editCustomer : Texts.addCustomer,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap.medium(),
        const Divider(),
        const Gap.medium(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: Texts.name),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: lastNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: Texts.lastName),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Texts.requiredField;
                        }
                        return null;
                      },
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: Texts.email),
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: Texts.phone),
                    ),
                    const Gap.small(),
                    TextFormField(
                      controller: addressController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: Texts.address),
                    ),
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
                            label: Text(widget.client != null ? Texts.edit : Texts.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final client = Customer(
        id: widget.client?.id,
        name: nameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
      );

      if (widget.client != null) {
        ref.read(customersControllerProvider.notifier).updateClient(client);
      } else {
        ref.read(customersControllerProvider.notifier).create(client);
      }
      ref.read(navigationServiceProvider).goBack(context);
    }
  }
}
