import 'package:event_planner/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Event {
  int id;
  int host;
  String name;
  String date;
  String time;
  String address;
  String description;
  ImageProvider mainPhoto;
  List photos;
  List<User>? going = [];
  List<User>? maybe = [];

  Event({
    required this.id,
    required this.host,
    required this.name,
    required this.date,
    required this.time,
    required this.address,
    required this.description,
    required this.mainPhoto,
    required this.photos,
    this.going,
    this.maybe,
  });
}
