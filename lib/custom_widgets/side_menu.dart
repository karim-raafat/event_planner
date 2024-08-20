import 'package:event_planner/pages/add_event.dart';
import 'package:event_planner/pages/events_list_page.dart';
import 'package:event_planner/pages/explore_page.dart';
import 'package:event_planner/pages/login_page.dart';
import 'package:event_planner/pages/my_events_page.dart';
import 'package:event_planner/pages/my_profile_page.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            Row(
              children: [
                profileCircle(
                  image: (Provider.of<AppProvider>(context).loggedUser.profilePhoto!= null)?Image.memory(Provider.of<AppProvider>(context).loggedUser.profilePhoto) : null,
                  radius: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(Provider.of<AppProvider>(context).loggedUser.username),
                ),
              ],
            ),
             Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuItem(
                    icon: Icons.explore_outlined,
                    title: 'Discover',
                    context: context,
                    destination: ExplorePage.routeName,
                  ),
                  menuItem(
                    icon: Icons.add,
                    title: 'Add Event',
                    context: context,
                    destination: AddEvent.routeName
                  ),
                  menuItem(
                    icon: Icons.event,
                    title: 'My Events',
                    context: context,
                    destination: MyEventsPage.routeName
                  ),
                  menuItem(
                    icon: Icons.send,
                    title: 'Messages',
                    context: context,
                  ),
                  menuItem(
                    icon: Icons.call_missed_outgoing,
                    title: 'Events Going',
                    context: context,
                    destination: EventsListPage.routeName
                  ),
                   menuItem(
                    icon: Icons.pending,
                    title: 'Events Maybe',
                    context: context,
                     destination: EventsListPage.routeName
                  ),
                  menuItem(
                    icon: Icons.history,
                    title: 'History',
                    context: context,
                  ),
                  menuItem(
                    icon: Icons.person,
                    title: 'My Profile',
                    context: context,
                    destination: MyProfilePage.routeName,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: menuItem(
                    fontSize: 12,
                    iconSize: 18,
                    icon: Icons.settings,
                    title: 'Settings',
                    context: context,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: menuItem(
                    fontSize: 12,
                    iconSize: 18,
                    icon: Icons.logout,
                    title: 'Logout',
                    context: context,
                    destination: LoginPage.routeName
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
