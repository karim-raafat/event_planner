import 'package:event_planner/helpers.dart';
import 'package:event_planner/custom_widgets/event_view.dart';
import 'package:event_planner/custom_widgets/side_menu.dart';
import 'package:event_planner/pages/edit_event_page.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  static final routeName = 'my_events';

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      drawer: const SideMenu(),
      appBar: defaultAppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'My Events',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AppProvider>(
              builder: (BuildContext context, AppProvider appProvider,
                      Widget? child) =>
                  (!appProvider.isDone)
                      ? const Center(child: CircularProgressIndicator())
                      : (appProvider.myEvents.isEmpty && appProvider.isDone)
                          ? Center(
                              child: Text(
                                'You don\'t have any event yet!',
                                style: TextStyle(color: blueGrey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: appProvider.myEvents.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () async{
                                  appProvider.eventMainPhoto =
                                      appProvider.myEvents[index].mainPhoto;

                                  appProvider.getEventMedia(
                                      appProvider.myEvents[index]);

                                  appProvider.selectedImages =
                                      appProvider.myEvents[index].photos;

                                  appProvider.selectedEvent =
                                      appProvider.myEvents[index];

                                  print(appProvider.myEvents[index].photos);
                                  context.goNamed(EditEventPage.routeName);
                                  await Provider.of<AppProvider>(context,listen: false).getEventMedia(appProvider.myEvents[index]);
                                },
                                child: EventView(
                                  event: appProvider.myEvents[index],
                                  myEvent: true,
                                ),
                              ),
                            ),
            ),
          ),
        ),
      ),
    );
  }
}
