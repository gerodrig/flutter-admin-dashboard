import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/index.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          return Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // color: Colors.green,
              child: Center(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 370),
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: loginFormProvider.formKey,
                          child: Column(
                            children: [
                              //Email
                              TextFormField(
                                validator: (value) {
                                  if (!EmailValidator.validate(value ?? '')) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    loginFormProvider.email = value,
                                style: const TextStyle(color: Colors.white),
                                decoration: buildInputDecoration(
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
                                    loginFormProvider.password = value,
                                style: const TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: buildInputDecoration(
                                  hint: 'Enter your password',
                                  label: 'Password',
                                  icon: Icons.lock_outline_rounded,
                                ),
                              ),
                              const SizedBox(height: 20),
                              //Button
                              CustomOutlinedButton(
                                onPressed: () {
                                  final isValid =
                                      loginFormProvider.validateForm();

                                  if (isValid) {
                                    authProvider.login(loginFormProvider.email,
                                        loginFormProvider.password);
                                  }
                                },
                                text: 'Login',
                                isFilled: true,
                              ),
                              const SizedBox(height: 20),
                              LinkText(
                                  text: 'New account',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Flurorouter.registerRoute);
                                  }),
                            ],
                          )))));
        }));
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

  InputDecoration buildInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
      );
}
