import 'package:event_planner/helpers.dart';
import 'package:event_planner/models/event.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';

class EventView extends StatelessWidget {
  Event event;
  bool myEvent;

  EventView({super.key, required this.event,required this.myEvent});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: event.mainPhoto,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                eventStats(
                  event: event,
                  color: blueGrey,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        statsCircle(
                          child: Text(
                            (event.going == null)
                                ? '0'
                                : '${event.going?.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Going',
                          style: TextStyle(color: blueGrey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        statsCircle(
                          child: Text(
                            (event.maybe == null)
                                ? '0'
                                : '${event.maybe!.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          color: Colors.yellow[700]!,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Maybe Going',
                          style: TextStyle(color: blueGrey, fontSize: 12),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Text(
                        '|',
                        style: TextStyle(color: blueGrey),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat_outlined,
                          color: secondaryPurple,
                          size: 20,
                        ),
                      ),
                    ),
                    defaultButton(
                      context: context,
                      color: primaryPurple,
                      radius: 30,
                      child: Text(
                        (myEvent)? 'Edit' : 'RSVP',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
