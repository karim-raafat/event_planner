import 'package:event_planner/custom_widgets/event_list_view.dart';
import 'package:event_planner/helpers.dart';
import 'package:event_planner/custom_widgets/side_menu.dart';
import 'package:event_planner/pages/add_event.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  static final String routeName = 'events_list';

  @override
  State<EventsListPage> createState() => _EventsGoingPage();
}

class _EventsGoingPage extends State<EventsListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      drawer: const SideMenu(),
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        backgroundColor: primaryPurple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Hi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            //# UserName
            Text(
              appProvider.loggedUser.username,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          GestureDetector(
            onTap: () {
              context.goNamed(AddEvent.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ), // AppBar
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Consumer<AppProvider>(
                builder:
                    (BuildContext context, AppProvider value, Widget? child) =>
                        Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          appProvider.isGoing
                              ? 'Events I am Going to:'
                              : 'Events I am interested in: ',
                          style: TextStyle(
                            color: blueGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      appProvider.loggedUser.goingEvents.length,
                      itemBuilder: (context, index) => EventListView(
                        event: appProvider.loggedUser.goingEvents[index],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
