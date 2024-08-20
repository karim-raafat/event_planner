import 'package:event_planner/models/event.dart';

class User {
  int id;
  String username;
  String email;
  String password;
  List<Event> userEvents = [];
  List<Event> goingEvents = [];
  List<Event> maybeEvents = [];
  var profilePhoto;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.profilePhoto
  });
}
