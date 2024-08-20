import 'package:event_planner/helpers.dart';
import 'package:event_planner/models/event.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  EventListView({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: event.mainPhoto,
            fit: BoxFit.cover
          )
        ),
      ),
      title: Text(event.name,style: TextStyle(color: blueGrey),),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(event.address,style: TextStyle(color: blueGrey,fontSize: 12),),

          Text(event.date,style: TextStyle(color: blueGrey,fontSize: 12),),
          Text(event.time,style: TextStyle(color: blueGrey,fontSize: 12),),
        ],
      ),
    );
  }
}
