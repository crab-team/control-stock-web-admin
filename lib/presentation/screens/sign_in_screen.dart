import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/presentation/hooks/dialogs_hook.dart';
import 'package:control_stock_web_admin/presentation/providers/sign_in/sign_providers.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_mtc_widget.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signInControllerProvider, (previous, next) {
      if (previous != null && previous.isLoading) {
        Navigator.of(context).pop();
      }

      next.maybeWhen(
        data: (data) => ref.read(navigationServiceProvider).goToSignInConfirmed(context),
        loading: () => useDialogs(context, type: DialogType.loading, message: "Enviando link a su email"),
        error: (error, _) => useDialogs(context, type: DialogType.error, message: error.toString()),
        orElse: () {},
      );
    });

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Inicio de sesión", style: Theme.of(context).textTheme.headlineLarge),
                const Gap.medium(),
                Text(
                  "Ingresá tu email y pedí tu link de inicio de sesión, el mismo será enviado a tu cuenta.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap.large(),
                SizedBox(
                  width: 400,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, ingrese su email";
                            }

                            if (!value.contains("@")) {
                              return "Por favor, ingrese un email válido";
                            }

                            return null;
                          },
                          onFieldSubmitted: (_) => _singIn(context),
                          decoration: const InputDecoration(
                              labelText: "Email", prefixIcon: Icon(PhosphorIcons.envelope_simple_fill)),
                        ),
                        const Gap.medium(),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () => _singIn(context),
                            child: const Text("Pedir link de inicio de sesión"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap.large(),
                const LogoMtcWidget()
              ],
            ),
          ),
        );
      }),
    );
  }

  void _singIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ref.read(signInControllerProvider.notifier).signInWithEmailLink(_controller.text);
    }
  }
}
