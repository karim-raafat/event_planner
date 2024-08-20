import 'package:event_planner/helpers.dart';
import 'package:event_planner/pages/explore_page.dart';
import 'package:event_planner/pages/register_page.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static final String routeName = '/';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        backgroundColor: Colors.white,
        title: const Text('Login Page'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  return emailValidation(value);
                },
              ), //textFormFiled
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
              defaultButton(
                context: context,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Login',
                  style: TextStyle(color: secondaryPurple),
                ),
                color: Colors.white,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var response = await Provider.of<AppProvider>(
                      context,
                      listen: false,
                    ).login(
                      emailController.text,
                      passwordController.text,
                    );
                    if (response == 200) {
                      context.goNamed(ExplorePage.routeName);
                    }
                  }
                },
              ), // TextButton
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: blueGrey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'or',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: blueGrey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an Account? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(RegisterPage.routeName);
                    },
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                          color: blueGrey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
