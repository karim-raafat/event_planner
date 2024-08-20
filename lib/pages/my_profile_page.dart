import 'dart:io';

import 'package:event_planner/helpers.dart';
import 'package:event_planner/custom_widgets/side_menu.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({super.key});

  static final routeName = 'profile';

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text =
        Provider.of<AppProvider>(context, listen: false).loggedUser.username;
    emailController.text =
        Provider.of<AppProvider>(context, listen: false).loggedUser.email;
    passwordController.text =
        Provider.of<AppProvider>(context, listen: false).loggedUser.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Profile Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Consumer<AppProvider>(
                          builder: (BuildContext context,
                                  AppProvider appProvider, Widget? child) =>
                              profileCircle(
                            image: (appProvider.userProfilePhoto != null)
                                ? Image.file(
                                    File(
                                      appProvider.userProfilePhoto.path,
                                    ),
                                  )
                                : (appProvider.loggedUser.profilePhoto!=null)?
                            Image.memory(appProvider.loggedUser.profilePhoto) :
                                null,
                            radius: MediaQuery.of(context).size.width * 0.35,
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 0,
                          child: IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: primaryPurple),
                            onPressed: () async {
                              await selectImage(context, true);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultTextFormFiled(
                          type: TextInputType.text,
                          controller: usernameController,
                          hint: 'Username',
                          prefixIcon: const Icon(
                            Icons.perm_identity,
                          ),
                          textStyle: TextStyle(
                            color: blueGrey,
                          ),
                          validate: (String value) {
                            validation(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormFiled(
                          type: TextInputType.text,
                          controller: emailController,
                          hint: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          textStyle: TextStyle(
                            color: blueGrey,
                          ),
                          validate: (String value) {
                            emailValidation(value);
                            validation(value);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AppProvider>(
                          builder: (BuildContext context,
                                  AppProvider appProvider, Widget? child) =>
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
                              validation(value);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<AppProvider>(
                          builder: (BuildContext context,
                                  AppProvider appProvider, Widget? child) =>
                              defaultButton(
                            radius: 20,
                            context: context,
                            color: secondaryPurple,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Text(
                              'SAVE',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (usernameController.text !=
                                      appProvider.loggedUser.username ||
                                  emailController.text !=
                                      appProvider.loggedUser.email ||
                                  passwordController.text !=
                                      appProvider.loggedUser.password ||
                                  appProvider.userProfilePhoto != null) {
                                appProvider.updateUserProfile(
                                    usernameController.text,
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
