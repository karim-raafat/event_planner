import 'package:event_planner/helpers.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  static final String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        backgroundColor: Colors.white,
        title: const Text('Register Page'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      ), //AppBar
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultTextFormFiled(
                type: TextInputType.emailAddress,
                controller: emailController,
                hint: 'Email',
                prefixIcon: const Icon(Icons.email),
                validate: (String value) {
                  return validation(value);
                },
              ), //TextFormFiled
              const SizedBox(
                height: 10,
              ),
              defaultTextFormFiled(
                type: TextInputType.text,
                controller: usernameController,
                hint: 'UserName',
                prefixIcon: const Icon(Icons.person),
                validate: (String value) {
                  return validation(value);
                },
              ), // TextFormFiled
              const SizedBox(
                height: 10,
              ),
              Consumer<AppProvider>(
                builder: (BuildContext context, AppProvider appProvider,
                        Widget? child) =>
                    defaultTextFormFiled(
                  type: TextInputType.visiblePassword,
                  controller: passwordController,
                  hint: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      appProvider.obscure = !appProvider.obscure;
                    },
                    child: appProvider.obscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  obscureText: appProvider.obscure,
                  validate: (String value) {
                    return validation(value);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<AppProvider>(
                builder: (BuildContext context, AppProvider appProvider,
                        Widget? child) =>
                    defaultTextFormFiled(
                  type: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      appProvider.obscure = !appProvider.obscure;
                    },
                    child: appProvider.obscure
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  obscureText: appProvider.obscure,
                  validate: (String value) {
                    return confirmPasswordValidation(passwordController.text,
                        confirmPasswordController.text);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              defaultButton(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                context: context,
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: secondaryPurple,
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var response = await Provider.of<AppProvider>(
                      context,
                      listen: false,
                    ).createUser(
                      emailController.text,
                      passwordController.text,
                      usernameController.text,
                    );
                    if (response == 200) {
                      context.pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
