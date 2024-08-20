import 'dart:io';
import 'package:event_planner/helpers.dart';
import 'package:event_planner/models/event.dart';
import 'package:event_planner/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

defaultAppBar({
  required Color backgroundColor,
  required Widget? title,
  Widget? leading,
  List<Widget>? actions,
  ShapeBorder? shape,
  double elevation = 0,
  IconThemeData? iconTheme,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    iconTheme: (iconTheme == null) ? const IconThemeData() : iconTheme,
    title: title,
    centerTitle: true,
    shape: shape,
    elevation: elevation,
    leading: leading,
    actions: actions,
  );
}

defaultTextFormFiled({
  required TextInputType? type,
  required TextEditingController? controller,
  Color? fillColor = Colors.white,
  String? hint,
  bool? obscureText = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Function? validate,
  BorderSide? side,
  Function? onChanged,
  InputBorder? inputBorder,
  String? labelText,
  TextStyle? textStyle,
  int? maxLines,
}) {
  return TextFormField(
    maxLines: (maxLines == null) ? 1 : maxLines,
    style: textStyle,
    obscureText: obscureText!,
    keyboardType: type,
    onChanged: (value) {
      if (onChanged != null) {
        return onChanged(value);
      }
    },
    validator: (value) {
      if (validate != null) {
        return validate(value);
      }
    },
    controller: controller,
    cursorColor: const Color(0xFFA73FD2),
    decoration: InputDecoration(
      prefixIcon: (prefixIcon != null) ? prefixIcon : null,
      suffixIcon: (suffixIcon != null) ? suffixIcon : null,
      fillColor: fillColor,
      filled: true,
      hintText: hint,
      labelText: labelText,
      border: (inputBorder == null)
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: (side != null) ? side : const BorderSide(),
            )
          : inputBorder,
    ),
  );
}

Widget defaultButton(
    {required BuildContext context,
    required Widget child,
    required Function? onPressed,
    Color color = secondaryPurple,
    double? width,
    double? radius}) {
  return SizedBox(
    width: (width == null) ? null : width,
    child: TextButton(
      onPressed: () {
        return onPressed!();
      },
      style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((radius == null) ? 10 : radius),
          )),
      child: child,
    ),
  );
}

Widget statsCircle({required Widget child, required Color color}) {
  return CircleAvatar(
    backgroundColor: color,
    radius: 15,
    child: child,
  );
}

Widget profileCircle({
  required double radius,
  required image,
  Color backgroundColor = Colors.transparent,
  // required Image image,
}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: (image == null) ? Colors.grey[400] : Colors.transparent,
    child: ClipOval(
      child: (image == null)
          ? Icon(
              Icons.person,
              size: radius,
            )
          : image,
    ),
  );
}

Widget menuItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  double? fontSize,
  double? iconSize,
  String? destination,
}) {
  return GestureDetector(
    onTap: () {
      if (destination != null) {
        context.goNamed(destination);
      }
      if (title == 'Events Going') {
        Provider.of<AppProvider>(context, listen: false).isGoing = true;
        context.pop();
      } else if (title == 'Events Maybe') {
        Provider.of<AppProvider>(context, listen: false).isGoing = false;
        context.pop();
      }
      if(title == 'Add Event'){
        Provider.of<AppProvider>(context, listen: false).eventMainPhoto = null;
        Provider.of<AppProvider>(context, listen: false).selectedImages = [];
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: blueGrey,
          size: (iconSize == null) ? 25 : iconSize,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: blueGrey,
            fontSize: (fontSize == null) ? 16 : fontSize,
          ),
        ),
      ),
    ),
  );
}

Widget eventStats({required Event event, Color color = Colors.white}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.address,
            style: TextStyle(
              color: color,
              fontSize: 11,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                event.date,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: color,
                  ),
                ),
              ),
              Text(
                event.time,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                ),
              ),
            ],
          )
        ],
      ),
    ],
  );
}

Widget eventSection({
  required BuildContext context,
  required String title,
}) {
  return GestureDetector(
    onTap: () {
      Provider.of<AppProvider>(context, listen: false).selectedSection = title;
    },
    child: Container(
      decoration: BoxDecoration(
          border: (Provider.of<AppProvider>(context, listen: true)
                      .selectedSection ==
                  title)
              ? Border(
                  bottom: BorderSide(
                  color: primaryPurple,
                  width: 2,
                ))
              : const Border()),
      child: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget eventImages({
  required double width,
  required double height,
  required image,
  required Function onDeletePressed,
  bool? edit,
}) {
  return Stack(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:  DecorationImage(image: (edit!=null)? image : FileImage(File(image)), fit: BoxFit.cover),
        ),
      ),
      Positioned(
        right: -3,
        top: -3,
        child: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            return onDeletePressed();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 20,
          ),
        ),
      )
    ],
  );
}
