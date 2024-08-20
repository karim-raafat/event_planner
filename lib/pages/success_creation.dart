import 'package:event_planner/helpers.dart';
import 'package:event_planner/custom_widgets/side_menu.dart';
import 'package:event_planner/pages/explore_page.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessCreation extends StatelessWidget {
  const SuccessCreation({super.key});

  static final String routeName = 'success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Success',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Success.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Congratulations!',
                  style: TextStyle(
                      color: blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                //#Name of the event
                Text(
                  'Your event "Prom" has been successfully created.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: blueGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  context: context,
                  color: primaryPurple,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Text(
                    'Edit Event',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //#Go to edit event
                  },
                ),

                defaultButton(
                  context: context,
                  color: secondaryPurple,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: const Text(
                    'Explore Events',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    context.goNamed(ExplorePage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
