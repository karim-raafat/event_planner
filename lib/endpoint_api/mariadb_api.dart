import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> create_user(
  String email,
  String password,
  String username,
) {
  final url = Uri.parse('http://192.168.1.9:5000/users');
  return http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
        {"email": email, "password": password, "username": username}),
  );
}

Future<http.Response> login_user(String email, String password) {
  final url = Uri.parse(
      'http://192.168.1.9:5000/users?email=$email&password=$password');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> create_event(int host, String name, String date,
    String time, String address, String description, mainPhoto, media) {
  final url = Uri.parse('http://192.168.1.9:5000/events');
  return http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "host": host,
      "name": name,
      "date": date,
      "time": time,
      "address": address,
      "description": description,
      "image": mainPhoto,
      "media": media,
    }),
  );
}

Future<http.Response> get_all_events() {
  final url = Uri.parse('http://192.168.1.9:5000/events');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> get_my_events(int id) {
  final url = Uri.parse('http://192.168.1.9:5000/my_events?id=$id');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> delete_event(int id) {
  final url = Uri.parse('http://192.168.1.9:5000/my_events?id=$id');
  return http.delete(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> get_host(int id) {
  final url = Uri.parse('http://192.168.1.9:5000/host?id=$id');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> get_event_media(int id) {
  final url = Uri.parse('http://192.168.1.9:5000/event_media?id=$id');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> update_user_profile(
    int id, String username, String email, String password, profilePhoto) {
  final url = Uri.parse('http://192.168.1.9:5000/users');
  return http.patch(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'username': username,
        'password': password,
        'image': profilePhoto
      }));
}

Future<http.Response> rsvp(
    int userID, int eventID, String status, int kidsNo, int adultsNo) {
  final url = Uri.parse('http://192.168.1.9:5000/guests');
  return http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      {
        'userID': userID,
        'eventID': eventID,
        'status': status,
        'kidsNo': kidsNo,
        'adultsNo': adultsNo
      },
    ),
  );
}

Future<http.Response> get_guest_info(int userID, int eventID) {
  final url = Uri.parse(
      'http://192.168.1.9:5000/guests?userID=$userID&eventID=$eventID');
  return http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );
}

Future<http.Response> update_event(int id, String name, String date,
    String time, String address, String description, image, media) {
  final url = Uri.parse('http://192.168.1.9:5000/events');
  return http.patch(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'id': id,
      'name' : name,
      'date' : date,
      'time' : time,
      'address' : address,
      'description' : description,
      'image' : image,
      'media' : media,
    }),
  );
}
