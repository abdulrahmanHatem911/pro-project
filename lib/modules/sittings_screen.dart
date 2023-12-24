// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pre/modules/porfile.dart';
// import '../models/database_user.dart';
// import 'dart:io';
//
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   DatabaseHelper dbHelper = DatabaseHelper();
//
//   File? _image;
//   final picker = ImagePicker();
//   int? age;
//   String? phone;
//
//   Future getImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Age'),
//               onChanged: (value) {
//                 setState(() {
//                   age = int.tryParse(value);
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               onChanged: (value) {
//                 setState(() {
//                   phone = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             _image != null
//                 ? Image.file(
//                     _image!,
//                     width: 150,
//                     height: 150,
//                   )
//                 : ElevatedButton(
//                     onPressed: () {
//                       getImage();
//                     },
//                     child: Text('Pick Image'),
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 User user = User(image: _image?.path, age: age, phone: phone);
//                 int userId = await dbHelper.insertUser(user);
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserProfilePage(user: user),
//                   ),
//                 );
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
