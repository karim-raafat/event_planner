import 'dart:convert';
import 'package:event_planner/endpoint_api/mariadb_api.dart';
import 'package:event_planner/models/contact.dart';
import 'package:event_planner/models/event.dart';
import 'package:event_planner/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AppProvider extends ChangeNotifier {
  bool _obscure = true;
  List<Event> _allEvents = [];
  List<Event> _myEvents = [];
  late Event _selectedEvent;
  late Contact _host =
  Contact(id: 2, name: 'Karim Ahmed', email: 'karim@gmail.com');
  final List<String> _eventSection = ['Details', 'Photos', 'Facilities'];
  late User loggedUser = User(
      id: 2,
      username: 'Karim Ahmed',
      email: 'karim@gmail.com',
      password: 'sss');
  String _selectedSection = 'Details';
  int _adultCount = 0;
  int _kidsCount = 0;
  bool _isSaveEnabled = false;
  List<Event> _searchResults = [];
  bool _isDone = true;
  var _eventMainPhoto;
  List _selectedImages = [];
  var _userProfilePhoto;

  get userProfilePhoto => _userProfilePhoto;

  set userProfilePhoto(value) {
    _userProfilePhoto = value;
    notifyListeners();
  }

  List get selectedImages => _selectedImages;

  void addImage(image) {
    selectedImages.add(image);
    notifyListeners();
  }

  set selectedImages(List value) {
    _selectedImages = value;
    notifyListeners();
  }

  void deleteImage(image) {
    selectedImages.remove(image);
    notifyListeners();
  }

  get eventMainPhoto => _eventMainPhoto;

  set eventMainPhoto(value) {
    _eventMainPhoto = value;
    notifyListeners();
  }

  bool get isDone => _isDone;

  set isDone(bool value) {
    _isDone = value;
  }

  Contact get host => _host;

  set host(Contact value) {
    _host = value;
  }

  List<Event> get searchResults => _searchResults;
  bool _isGoing = true;

  bool get isGoing => _isGoing;

  set isGoing(bool value) {
    _isGoing = value;
    notifyListeners();
  }

  set searchResults(List<Event> value) {
    _searchResults = value;
  }

  bool get isSaveEnabled => _isSaveEnabled;

  set isSaveEnabled(bool value) {
    _isSaveEnabled = value;
  }

  int get adultCount => _adultCount;

  set adultCount(int value) {
    if (value >= 0) {
      _adultCount = value;
    }
    notifyListeners();
  }

  List<String> get eventSection => _eventSection;

  Event get selectedEvent => _selectedEvent;

  set selectedEvent(Event value) {
    _selectedEvent = value;
  }

  List<Event> get myEvents => _myEvents;

  set myEvents(List<Event> value) {
    _myEvents = value;
  }

  List<Event> get allEvents => _allEvents;

  set allEvents(List<Event> value) {
    _allEvents = value;
  }

  bool get obscure => _obscure;

  set obscure(bool value) {
    _obscure = value;
    notifyListeners();
  }

  String get selectedSection => _selectedSection;

  set selectedSection(String value) {
    _selectedSection = value;
    notifyListeners();
  }

  int get kidsCount => _kidsCount;

  set kidsCount(int value) {
    if (value >= 0) {
      _kidsCount = value;
    }
    notifyListeners();
  }

  Future<void> getAllEvents() async {
    allEvents = [];
    isDone = false;
    Response response = await get_all_events();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        allEvents.add(
          Event(
            id: data[i]['eventID'],
            host: data[i]['eventHost'],
            name: data[i]['eventName'],
            date: data[i]['eventDate'],
            time: data[i]['eventTime'],
            address: data[i]['eventAddress'],
            description: data[i]['eventDescription'],
            mainPhoto: (data[i]['eventImage'] == null)
                ? const AssetImage('assets/images/Default Event.png')
                : MemoryImage(base64Decode(data[i]['eventImage'])),
            photos: [],
          ),
        );
      }
    }
    searchResults = allEvents;
    isDone = true;
    notifyListeners();
  }

  Future<void> getHost(int id) async {
    Response response = await get_host(id);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      host = Contact(id: data[0], name: data[1], email: data[2]);
    }
    notifyListeners();
  }

  Future<int> createUser(String email, String password, String username) async {
    Response response = await create_user(email, password, username);
    return response.statusCode;
  }

  Future<int> login(String email, String password) async {
    Response response = await login_user(email, password);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      loggedUser = User(
          id: data['id'],
          username: data['username'],
          email: email,
          password: password,
          profilePhoto: (data['profile picture']!='none')? base64Decode(data['profile picture']) : null
      );
    }
    return response.statusCode;
  }

  Future<void> getMyEvents() async {
    myEvents = [];
    isDone = false;
    Response response = await get_my_events(loggedUser.id);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        myEvents.add(
          Event(
            id: data[i]['eventID'],
            host: data[i]['eventHost'],
            name: data[i]['eventName'],
            date: data[i]['eventDate'],
            time: data[i]['eventTime'],
            address: data[i]['eventAddress'],
            description: data[i]['eventDescription'],
            mainPhoto: (data[i]['eventImage'] == null)
                ? const AssetImage('assets/images/Default Event.png')
                : MemoryImage(base64Decode(data[i]['eventImage'])),
            photos: [],
          ),
        );
      }
    }
    isDone = true;
    notifyListeners();
  }

  Future<int> createEvent(int host, String name, String date, String time,
      String address, String description) async {
    var mainPhotoBase64;
    List photosBytes = [];
    if (eventMainPhoto != null) {
      mainPhotoBase64 = base64Encode(await eventMainPhoto.readAsBytes());
    }

    if (selectedImages.isNotEmpty) {
      for (var image in selectedImages) {
        photosBytes.add(base64Encode(await image.readAsBytes()));
      }
    }

    Response response = await create_event(
        loggedUser.id,
        name,
        date,
        time,
        address,
        description,
        mainPhotoBase64,
        photosBytes);
    return response.statusCode;
  }

  Future<void> getEventMedia(Event event) async {
    isDone = false;
    Response response = await get_event_media(event.id);
    event.photos = [];
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        event.photos.add(MemoryImage(base64Decode(data[i])));
      }
    }
    print(event.photos);
    isDone = true;
    notifyListeners();
  }

  Future<void> updateUserProfile(String username, String email,
      String password) async {
    var userProfilePhoto64;
    if (userProfilePhoto != null) {
      userProfilePhoto64 = base64Encode(await userProfilePhoto.readAsBytes());
    }
    Response response = await update_user_profile(
        loggedUser.id, username, email, password, userProfilePhoto64);
    if (response.statusCode == 200) {
      //# Message Success
      userProfilePhoto = null;
      loggedUser.username = username;
      loggedUser.email = email;
      loggedUser.password = password;
      loggedUser.profilePhoto = base64Decode(userProfilePhoto64);
    }
  }

  Future<void> RSVP() async{
    String status = (isGoing)? 'Going' : 'Maybe';
    Response response = await rsvp(loggedUser.id, selectedEvent.id, status, kidsCount, adultCount);
    if(response.statusCode == 200){
      if(status == 'Going'){
        loggedUser.goingEvents.add(selectedEvent);
      }
      else if(status == 'Maybe'){
        loggedUser.maybeEvents.add(selectedEvent);
      }
    }
    notifyListeners();
  }

  Future<void> rsvpData() async{
    Response response = await get_guest_info(loggedUser.id, selectedEvent.id);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      isGoing = (data['status']=='Going')? true : false;
      kidsCount = data['kidsNo'];
      adultCount = data['adultsNo'];
    }


  }

  void search(String searchPrompt) {
    searchResults = [];
    for (Event event in allEvents) {
      if (event.name.contains(searchPrompt)) {
        searchResults.add(event);
      }
    }
    eventMainPhoto = null;
    selectedImages = [];
    notifyListeners();
  }
  Future<void> updateEvent(String name, String date, String time, String address, String description,) async{
    List photoBytes = [];
    if(selectedImages.isNotEmpty){
      for (final image in selectedImages){
        photoBytes.add(base64Encode(await image.readAsBytes()));
      }
    }
    var mainPhotoBytes;
    if(eventMainPhoto!=null){
      mainPhotoBytes = base64Encode(await eventMainPhoto.readAsBytes());
    }
    await update_event(selectedEvent.id, name, date, time, address, description, mainPhotoBytes, photoBytes);
  }
}

