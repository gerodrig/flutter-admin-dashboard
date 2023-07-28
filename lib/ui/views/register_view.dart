import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/index.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: Builder(builder: (context) {
          final registerFormProvider =
              Provider.of<RegisterFormProvider>(context, listen: false);
          return Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.green,
              child: Center(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 370),
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: registerFormProvider.formKey,
                          child: Column(
                            children: [
                              //Username
                              TextFormField(
                                validator: usernameValidator,
                                onChanged: (value) =>
                                    registerFormProvider.name = value,
                                style: const TextStyle(color: Colors.white),
                                decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Enter your name',
                                  label: 'Name',
                                  icon: Icons.supervised_user_circle_outlined,
                                ),
                              ),
                              const SizedBox(height: 20),
                              //Email
                              TextFormField(
                                validator: (value) {
                                  if (!EmailValidator.validate(value ?? '')) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    registerFormProvider.email = value,
                                style: const TextStyle(color: Colors.white),
                                decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Enter your email',
                                  label: 'Email',
                                  icon: Icons.email_outlined,
                                ),
                              ),
                              const SizedBox(height: 20),
                              //Password
                              TextFormField(
                                validator: validatePassword,
                                onChanged: (value) =>
                                    registerFormProvider.password = value,
                                style: const TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: CustomInputs.loginInputDecoration(
                                  hint: 'Enter your password',
                                  label: 'Password',
                                  icon: Icons.lock_outline_rounded,
                                ),
                              ),
                              const SizedBox(height: 20),
                              //Button
                              CustomOutlinedButton(
                                onPressed: () {
                                  final validForm =
                                      registerFormProvider.validateForm();

                                  if (!validForm) return;

                                  //TODO: Register Auth Provider.
                                  final authProvider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  authProvider.register(
                                      registerFormProvider.email,
                                      registerFormProvider.password,
                                      registerFormProvider.name);
                                },
                                text: 'Create account',
                                isFilled: true,
                              ),
                              const SizedBox(height: 20),
                              LinkText(
                                  text: 'Login',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, Flurorouter.loginRoute);
                                  }),
                            ],
                          )))));
        }));
  }

  String? usernameValidator(value) {
    if (value == null || value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must be 6 characters';
    }
    return null; //Valid
  }
}
