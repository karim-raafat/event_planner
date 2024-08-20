import 'package:event_planner/pages/add_event.dart';
import 'package:event_planner/pages/edit_event_page.dart';
import 'package:event_planner/pages/event_page.dart';
import 'package:event_planner/pages/events_list_page.dart';
import 'package:event_planner/pages/explore_page.dart';
import 'package:event_planner/pages/login_page.dart';
import 'package:event_planner/pages/my_events_page.dart';
import 'package:event_planner/pages/my_profile_page.dart';
import 'package:event_planner/pages/register_page.dart';
import 'package:event_planner/pages/success_creation.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AppProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _route,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _route = GoRouter(
    routes: [
      GoRoute(
        path: LoginPage.routeName,
        name: LoginPage.routeName,
        builder: (context, state) => LoginPage(),
        routes: [
          GoRoute(
              path: RegisterPage.routeName,
              name: RegisterPage.routeName,
              builder: (context, state) => RegisterPage()),
          GoRoute(
            path: ExplorePage.routeName,
            name: ExplorePage.routeName,
            builder: (context, state) => ExplorePage(),
            routes: [
              GoRoute(
                path: AddEvent.routeName,
                name: AddEvent.routeName,
                builder: (context, state) => AddEvent(),
              ),
              GoRoute(
                path: SuccessCreation.routeName,
                name: SuccessCreation.routeName,
                builder: (context, state) => const SuccessCreation(),
              ),
              GoRoute(
                path: EventPage.routeName,
                name: EventPage.routeName,
                builder: (context, state) => EventPage(
                  event: Provider.of<AppProvider>(
                    context,
                    listen: false,
                  ).selectedEvent,
                ),
              ),
            ],
          ),
          GoRoute(
              path: MyEventsPage.routeName,
              name: MyEventsPage.routeName,
              builder: (context, state) => const MyEventsPage(),
              routes: [
                GoRoute(
                  path: EditEventPage.routeName,
                  name: EditEventPage.routeName,
                  builder: (context,state) => EditEventPage(event: Provider.of<AppProvider>(
                    context,
                    listen: false,
                  ).selectedEvent,)
                ),
              ]),
          GoRoute(
            path: MyProfilePage.routeName,
            name: MyProfilePage.routeName,
            builder: (context, state) => MyProfilePage(),
          ),
          GoRoute(
            path: EventsListPage.routeName,
            name: EventsListPage.routeName,
            builder: (context, state) => EventsListPage(),
          ),
        ],
      )
    ],
  );
}
