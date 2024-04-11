import 'package:control_stock_web_admin/domain/entities/commerce.dart';
import 'package:control_stock_web_admin/presentation/providers/commerce/commerce_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceForm extends ConsumerStatefulWidget {
  const CommerceForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommerceFormState();
}

class _CommerceFormState extends ConsumerState<CommerceForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commerceControllerProvider);
    Commerce commerce = state.asData!.value!;
    nameController.text = commerce.name;
    addressController.text = commerce.address;
    phoneController.text = commerce.phone ?? '';
    emailController.text = commerce.email ?? '';
    return _buildCommerceData(commerce);
  }

  Widget _buildCommerceData(Commerce commerce) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: Texts.commerceName,
            ),
          ),
          const Gap.medium(),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: Texts.address,
            ),
          ),
          const Gap.medium(),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: Texts.phone,
            ),
          ),
          const Gap.medium(),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: Texts.email,
            ),
          ),
          const Gap.small(),
          ElevatedButton(
            onPressed: () => _onSubmit(commerce),
            child: const Text(Texts.save),
          ),
        ],
      ),
    );
  }

  _onSubmit(Commerce commerce) {
    if (formKey.currentState!.validate()) {
      Commerce commerceUpdated = Commerce(
        id: commerce.id,
        name: nameController.text,
        address: addressController.text,
        phone: phoneController.text,
        email: emailController.text,
        imageUrl: commerce.imageUrl,
      );

      ref.read(commerceControllerProvider.notifier).updateData(commerceUpdated);
    }
  }
}
