import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null || value.trim() == '') {
                          return 'Email must be entered';
                        }
                        return null;
                      },
                      label: 'Email',
                      prefixIcon: Icons.email),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value == null || value.trim() == '') {
                          return 'Password must be entered';
                        }
                        return null;
                      },
                      label: 'Password',
                      prefixIcon: Icons.lock,
                      suffixIcon:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      obsecure: isPassword,
                      suffixIconPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                  const SizedBox(height: 15.0),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text +
                              " = " +
                              passwordController.text);
                        }
                      },
                      text: 'login'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?!!'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Register Now'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
