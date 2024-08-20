import 'package:event_planner/helpers.dart';
import 'package:event_planner/custom_widgets/event_view.dart';
import 'package:event_planner/custom_widgets/side_menu.dart';
import 'package:event_planner/pages/add_event.dart';
import 'package:event_planner/pages/event_page.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static final String routeName = 'explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context,listen:false).getAllEvents();

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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  defaultTextFormFiled(
                    type: TextInputType.text,
                    controller: searchController,
                    hint: 'Search events here',
                    prefixIcon: const Icon(Icons.search),
                    side: BorderSide.none,
                    onChanged: (value) {
                      Provider.of<AppProvider>(context,listen: false).search(searchController.text);
                    },
                  ), //TextFormFiled
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Discover events near you',
                        style: TextStyle(
                          color: blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Consumer<AppProvider>(
                    builder: (BuildContext context, AppProvider appProvider,
                            Widget? child) =>
                    (!appProvider.isDone)? const Center(child: CircularProgressIndicator()) :
                        ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appProvider.searchResults.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          appProvider.selectedEvent = appProvider.searchResults[index];
                          Provider.of<AppProvider>(context,listen: false).getHost(appProvider.selectedEvent.host);
                          context.goNamed(EventPage.routeName);
                        },
                        child: EventView(
                          event: appProvider.searchResults[index],
                          myEvent: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
