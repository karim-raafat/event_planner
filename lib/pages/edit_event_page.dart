import 'package:event_planner/helpers.dart';
import 'package:event_planner/models/event.dart';

import 'package:event_planner/provider/app_provider.dart';
import 'package:event_planner/reusable_components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEventPage extends StatefulWidget {
  EditEventPage({super.key, required this.event});

  Event event;

  static final String routeName = 'edit_event';

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  TextEditingController eventNameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    eventNameController.text = widget.event.name;
    locationController.text = widget.event.address;
    dateController.text = widget.event.date;
    timeController.text = widget.event.time;
    descriptionController.text = widget.event.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      appBar: defaultAppBar(
        actions: [
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Event',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  defaultTextFormFiled(
                      type: TextInputType.text,
                      controller: eventNameController,
                      labelText: 'Event Name',
                      inputBorder: const UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      textStyle: TextStyle(color: blueGrey),
                      onChanged: (value) {
                        eventNameController.text = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormFiled(
                      type: TextInputType.text,
                      controller: locationController,
                      labelText: 'Location',
                      inputBorder: const UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      textStyle: TextStyle(color: blueGrey),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          //#Date Picker
                        },
                        child: const Icon(
                          Icons.location_pin,
                        ),
                      ),
                      onChanged: (value) {
                        locationController.text = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormFiled(
                      type: TextInputType.text,
                      controller: dateController,
                      labelText: 'Date',
                      inputBorder: const UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      textStyle: TextStyle(color: blueGrey),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          //#Date Picker
                        },
                        child: const Icon(
                          Icons.date_range,
                        ),
                      ),
                      onChanged: (value) {
                        dateController.text = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormFiled(
                      type: TextInputType.text,
                      controller: timeController,
                      labelText: 'Time',
                      inputBorder: const UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      textStyle: TextStyle(color: blueGrey),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          //#Time Picker
                        },
                        child: const Icon(
                          Icons.watch_later_outlined,
                        ),
                      ),
                      onChanged: (value) {
                        timeController.text = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormFiled(
                      type: TextInputType.text,
                      controller: descriptionController,
                      labelText: 'Description',
                      inputBorder: const UnderlineInputBorder(),
                      fillColor: Colors.transparent,
                      textStyle: TextStyle(color: blueGrey, fontSize: 12),
                      maxLines: 7,
                      onChanged: (value) {
                        descriptionController.text = value;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Main Photo',
                        style: TextStyle(
                          color: blueGrey,
                        ),
                      ),
                      defaultButton(
                        context: context,
                        radius: 30,
                        child: const Text(
                          'Upload',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await selectImage(
                            context,
                            false,
                          );
                        },
                      ),
                    ],
                  ),
                  Consumer<AppProvider>(
                    builder: (BuildContext context, AppProvider appProvider,
                            Widget? child) =>
                        (appProvider.eventMainPhoto != null)
                            ? eventImages(
                                width: 200,
                                height: 200,
                                image: appProvider.eventMainPhoto,
                                edit: true,
                                onDeletePressed: () {
                                  appProvider.eventMainPhoto = null;
                                },
                              )
                            : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add events Photos(optional)',
                        style: TextStyle(
                          color: blueGrey,
                        ),
                      ),
                      defaultButton(
                        context: context,
                        radius: 30,
                        child: const Text(
                          'Upload',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await selectMultiImages(context);
                        },
                      ),
                    ],
                  ),
                  (widget.event.photos.isNotEmpty)
                      ? SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: widget.event.photos.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: eventImages(
                                width: 150,
                                height: 150,
                                edit: true,
                                image: widget.event.photos[index],
                                onDeletePressed: () {
                                  setState(() {
                                    widget.event.photos.remove(widget.event.photos[index]);
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  //#Add Photos......
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    context: context,
                    color: secondaryPurple,
                    width: MediaQuery.of(context).size.width * 0.3,
                    radius: 20,
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      Provider.of<AppProvider>(context,listen: false).updateEvent(eventNameController.text, dateController.text, timeController.text, locationController.text, descriptionController.text);
                    },
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
