import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    bool isPassword = true;
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
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validatorText: 'Email must not be empty',
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      prefix: Icons.lock,
                      validatorText: 'Password Must not be empty',
                      label: 'Password',
                      suffixIcon: Icons.remove_red_eye,
                      isPassword: isPassword,
                      suffixIconPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      text: 'login',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?!'),
                      TextButton(
                          onPressed: () {}, child: const Text('Register Now'))
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
