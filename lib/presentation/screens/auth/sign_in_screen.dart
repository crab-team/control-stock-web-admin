import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/sign_in/sign_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_mtc_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/logo_widget.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/version_widget.dart';
import 'package:flutter/material.dart';
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
        data: (data) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              contentPadding: kPaddingAppSmall,
              title: Text(
                'Email enviado',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(PhosphorIcons.envelope, color: colorScheme.primary),
                    const Gap.small(),
                    Text('Se ha enviado un email a ${_controller.text} con un link de inicio de sesión.'),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              contentPadding: kPaddingAppSmall,
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const Gap.small(),
                    Text('Enviando email a ${_controller.text}...'),
                  ],
                ),
              ),
            );
          },
        ),
        error: (error, _) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              contentPadding: kPaddingAppSmall,
              title: Text(
                'Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(PhosphorIcons.warning, color: colorScheme.error),
                    const Gap.small(),
                    Text('Ha ocurrido un error al enviar el email a ${_controller.text}.'),
                    const Gap.small(),
                    Text(error.toString()),
                  ],
                ),
              ),
            );
          },
        ),
        orElse: () {},
      );
    });

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              width: constraints.maxWidth * 0.6,
              child: Image.asset(
                AssetsImages.background,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              width: constraints.maxWidth * 0.6,
              child: Image.asset(
                AssetsImages.background,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: SizedBox(
                width: 500,
                child: Card(
                  child: Padding(
                    padding: kPaddingApp.copyWith(left: 40, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LogoWidget.horizontal(
                          withText: false,
                          size: 120,
                        ),
                        const Gap.medium(),
                        Text("Inicio de sesión", style: Theme.of(context).textTheme.headlineLarge),
                        const Gap.small(),
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
                        const LogoMtcWidget(),
                        const Gap.small(),
                        const VersionWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
