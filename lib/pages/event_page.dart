import 'package:event_planner/helpers.dart';
import 'package:event_planner/models/event.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  EventPage({super.key, required this.event});

  static final routeName = 'event';

  Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false)
        .getEventMedia(widget.event);
    Provider.of<AppProvider>(context, listen: false).rsvpData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.event.mainPhoto, fit: BoxFit.cover)),
              ),
              Positioned(
                top: 30,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 0,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: eventStats(
                      event: widget.event,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              color: primaryPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Hosted by ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            profileCircle(
                              radius: 20,
                              image: (Provider.of<AppProvider>(context)
                                          .loggedUser
                                          .profilePhoto !=
                                      null)
                                  ? Image.memory(
                                      Provider.of<AppProvider>(context)
                                          .loggedUser
                                          .profilePhoto)
                                  : null,
                            ),
                            Text(
                              ' ${Provider.of<AppProvider>(
                                context,
                              ).host.name}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            //#Go to chat
                          },
                          child: const Icon(
                            Icons.chat_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultButton(
                        context: context,
                        color: Colors.white,
                        radius: 20,
                        child: Text(
                          'Invite Friends',
                          style: TextStyle(
                            color: primaryPurple,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Consumer<AppProvider>(
                                    builder: (BuildContext context,
                                            AppProvider appProvider,
                                            Widget? child) =>
                                        SizedBox(
                                      height: 30,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemExtent:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            appProvider.eventSection.length,
                                        itemBuilder: (context, index) =>
                                            eventSection(
                                          context: context,
                                          title:
                                              appProvider.eventSection[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Consumer<AppProvider>(
                                      builder: (
                                        BuildContext context,
                                        AppProvider appProvider,
                                        Widget? child,
                                      ) =>
                                          (appProvider.selectedSection ==
                                                  'Details')
                                              ? Text(
                                                  widget.event.description,
                                                  style: TextStyle(
                                                      color: blueGrey),
                                                )
                                              : (appProvider.selectedSection ==
                                                      'Photos')
                                                  ? photos() //#GridView for photos
                                                  : const Placeholder(), //# Facilities
                                    ),
                                  ),
                                  defaultButton(
                                    context: context,
                                    radius: 30,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: const Text(
                                      'RSVP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (
                                          BuildContext context,
                                        ) =>
                                            SafeArea(
                                          child: StatefulBuilder(
                                            builder: (
                                              BuildContext context,
                                              void Function(
                                                void Function(),
                                              ) setState,
                                            ) =>
                                                SingleChildScrollView(
                                                    child: modalBottomSheet(
                                                        context)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget modalBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text(
              'Your response to',
              style: TextStyle(
                color: blueGrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  eventStats(event: widget.event, color: Colors.black),
                  const Divider(
                    color: Colors.blueGrey,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rsvpSelect(
                            context: context,
                            icon: Icons.check_circle_outline,
                            title: 'Going',
                            bodyColor: Colors.green,
                            backgroundColor: const Color(0xFFC8E6C9),
                            isSelected: Provider.of<AppProvider>(
                              context,
                            ).isGoing,
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .isGoing = !Provider.of<AppProvider>(context,
                                      listen: false)
                                  .isGoing;
                            }),
                        rsvpSelect(
                            context: context,
                            icon: Icons.sentiment_neutral_outlined,
                            title: 'Maybe',
                            bodyColor: Colors.amber,
                            backgroundColor: const Color(0xFFFFECB3),
                            isSelected: !Provider.of<AppProvider>(
                              context,
                            ).isGoing,
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .isGoing = !Provider.of<AppProvider>(context,
                                      listen: false)
                                  .isGoing;
                            }),
                      ],
                    ),
                  ),
                  Divider(
                    color: blueGrey,
                    thickness: 1,
                  ),
                  Consumer<AppProvider>(
                    builder: (BuildContext context, AppProvider appProvider,
                            Widget? child) =>
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        counter(
                          count: appProvider.adultCount,
                          label: 'Adults',
                          onPressedUp: () {
                            appProvider.adultCount++;
                          },
                          onPressedDown: () {
                            appProvider.adultCount--;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: VerticalDivider(
                            color: blueGrey,
                            thickness: 1,
                          ),
                        ),
                        counter(
                          count: appProvider.kidsCount,
                          label: 'Kids',
                          onPressedUp: () {
                            appProvider.kidsCount++;
                          },
                          onPressedDown: () {
                            appProvider.kidsCount--;
                          },
                        ),
                      ],
                    ),
                  ),
                  defaultButton(
                    width: MediaQuery.of(context).size.width,
                    context: context,
                    child: const Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false).RSVP();
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rsvpSelect({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color bodyColor,
    required Color backgroundColor,
    required bool isSelected,
    required Function onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        return onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: 80,
        decoration: BoxDecoration(
          border: (isSelected)
              ? Border.all(
                  color: bodyColor,
                  width: 3,
                )
              : const Border(),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: bodyColor,
            ),
            Text(
              title,
              style: TextStyle(
                color: bodyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget counter({
    required int count,
    required String label,
    required Function onPressedUp,
    required Function onPressedDown,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            return onPressedUp();
          },
          icon: Icon(
            Icons.arrow_drop_up,
            color: blueGrey,
          ),
        ),
        Text(
          '$count',
          style: TextStyle(color: blueGrey),
        ),
        Text(
          label,
          style: TextStyle(color: blueGrey, fontSize: 12),
        ),
        IconButton(
          onPressed: () {
            return onPressedDown();
          },
          icon: Icon(
            Icons.arrow_drop_down,
            color: blueGrey,
          ),
        ),
      ],
    );
  }

  Widget photos() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
      ),
      itemCount: widget.event.photos.length,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: widget.event.photos[index], fit: BoxFit.cover)),
      ),
    );
  }
}
