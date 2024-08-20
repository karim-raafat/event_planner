
import 'dart:ui';

import 'package:event_planner/provider/app_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Color primaryPurple = const Color(0xFFA73FD2);
const Color secondaryPurple = Color(0xFF7923EB);
Color blueGrey = const Color(0xFF4B5B6B);
validation(String value){
  if (value.isEmpty) {
    return '* Required filed cannot be empty';
  }
  return null;
}
emailValidation(String value){
  validation(value);
  if (!value.contains('@') || !value.contains('.com')) {
    return '* Invalid Email address';
  }
  return null;
}
confirmPasswordValidation(String pass,String cPass){
  validation(cPass);
  if(pass != cPass){
    return'* Passwords must be identical';
  }
  return null;
}

Future<void> selectImage(context,bool profile)async{
  final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image!=null){
    if(profile){
       Provider.of<AppProvider>(context,listen: false).userProfilePhoto = await image.readAsBytes();
    }
    else{
      Provider.of<AppProvider>(context,listen: false).eventMainPhoto = image;
    }

  }
}
Future<void> selectMultiImages(context) async{
  final List<XFile> images = await ImagePicker().pickMultiImage();
  for(final image in images){
    Provider.of<AppProvider>(context,listen: false).addImage(image);
  }
}
