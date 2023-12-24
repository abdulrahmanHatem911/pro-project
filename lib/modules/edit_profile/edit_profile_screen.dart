// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../layout/cupit/app_cubit.dart';
// // import '../../models/user_model.dart';
// // import '../../shared/components/components.dart';
// //
// //
// // class EditProfileScreen extends StatelessWidget {
// //   const EditProfileScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //      return
// //     BlocConsumer<AppCubit, AppState>(
// //       listener: (context, state) {},
// //       builder: (context, state) {
// //         UserModel? userModel = AppCubit.get(context).currentUser;
// //
// //         TextEditingController nameController = TextEditingController();
// //         TextEditingController phoneController = TextEditingController();
// //         TextEditingController bioController = TextEditingController();
// //
// //         nameController.text = userModel!.name;
// //         phoneController.text = userModel.phone;
// //         bioController.text = userModel.bio;
// //
// //         File? profileImage = AppCubit.get(context).profileImage;
// //         File? coverImage = AppCubit.get(context).coverImage;
// //
// //         return Scaffold(
// //           appBar: defaultAppBar(
// //             context: context,
// //             title: 'Edit profile',
// //             actions: [
// //               defaultTextButton(
// //                 onPressedFunction: () {
// //                   AppCubit.get(context).updateUser(
// //                     name: nameController.text,
// //                     phone: phoneController.text,
// //                     bio: bioController.text,
// //                   );
// //                 },
// //                 text: 'update',
// //               ),
// //               const SizedBox(width: 15.0),
// //             ],
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: SingleChildScrollView(
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     if (state is UpdateUserLoading) LinearProgressIndicator(),
// //                     Container(
// //                       height: 190,
// //                       child: Align(
// //                         alignment: AlignmentDirectional.topCenter,
// //                         child: Stack(
// //                           clipBehavior: Clip.none,
// //                           alignment: AlignmentDirectional.bottomCenter,
// //                           children: [
// //                             Stack(
// //                               alignment: AlignmentDirectional.bottomEnd,
// //                               children: [
// //                                 Column(
// //                                   children: [
// //                                     Container(
// //                                       height: 150.0,
// //                                       width: double.infinity,
// //                                       decoration: BoxDecoration(
// //                                         image: DecorationImage(
// //                                           image: coverImage == null
// //                                               ? NetworkImage(
// //                                                   '${userModel.cover}',
// //                                                 )
// //                                               : FileImage(coverImage)
// //                                                   as ImageProvider<Object>,
// //                                           fit: BoxFit.cover,
// //                                         ),
// //                                         borderRadius: BorderRadius.only(
// //                                           topLeft: Radius.circular(4.0),
// //                                           topRight: Radius.circular(4.0),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     const SizedBox(height: 10.0),
// //                                   ],
// //                                 ),
// //                                 Transform.translate(
// //                                   offset: Offset(0, -20.0),
// //                                   child: IconButton(
// //                                     onPressed: () {
// //                                       AppCubit.get(context).getCoverImage();
// //                                     },
// //                                     icon: CircleAvatar(
// //                                       radius: 20.0,
// //                                       child: Icon(
// //                                        Icons.camera,
// //                                         size: 16.0,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             Positioned(
// //                               bottom: -20,
// //                               child: Stack(
// //                                 alignment: AlignmentDirectional.bottomEnd,
// //                                 children: [
// //                                   Column(
// //                                     children: [
// //                                       CircleAvatar(
// //                                         backgroundColor: Theme.of(context)
// //                                             .scaffoldBackgroundColor,
// //                                         radius: 70.0,
// //                                         child: CircleAvatar(
// //                                           radius: 60.0,
// //                                           backgroundImage: profileImage == null
// //                                               ? NetworkImage(
// //                                                   '${userModel.image}',
// //                                                 )
// //                                               : FileImage(profileImage)
// //                                                   as ImageProvider<Object>?,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 10.0),
// //                                     ],
// //                                   ),
// //                                   Transform.translate(
// //                                     offset: Offset(5.0, -15.0),
// //                                     child: IconButton(
// //                                       onPressed: () {
// //                                         AppCubit.get(context)
// //                                             .getProfileImage();
// //                                       },
// //                                       icon: CircleAvatar(
// //                                         radius: 20.0,
// //                                         child: Icon(
// //                                           Icons.add,
// //                                           size: 16.0,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 40),
// //                     defaultFormField(
// //                       controller: nameController,
// //                       type: TextInputType.name,
// //                       validate: (val) {
// //                         if (val.isEmpty) {
// //                           return 'Name must not be empty';
// //                         }
// //                         return null;
// //                       },
// //                       label: 'Name',
// //                       prefix: Icons.account_circle_outlined,
// //                     ),
// //                     const SizedBox(height: 10),
// //                     defaultFormField(
// //                       controller: phoneController,
// //                       type: TextInputType.phone,
// //                       validate: (val) {
// //                         if (val.isEmpty) {
// //                           return 'Phone must not be empty';
// //                         }
// //                         return null;
// //                       },
// //                       label: 'Phone',
// //                       prefix: Icons.call_end_rounded,
// //                     ),
// //                     const SizedBox(height: 10),
// //                     defaultFormField(
// //                       controller: bioController,
// //                       type: TextInputType.name,
// //                       validate: (val) {
// //                         if (val.isEmpty) {
// //                           return 'Bio must not be empty';
// //                         }
// //                         return null;
// //                       },
// //                       label: 'Bio',
// //                       prefix: Icons.info_outline_rounded,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //    // )
// //         );
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../layout/cupit/app_cubit.dart';
// import '../../models/user_model.dart';
// import '../../shared/components/components.dart';
//
// class EditProfileScreen extends StatefulWidget {
// const EditProfileScreen({Key? key}) : super(key: key);
//
// @override
// _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
// late TextEditingController nameController;
// late TextEditingController phoneController;
// late TextEditingController bioController;
//
// @override
// void initState() {
// super.initState();
// nameController = TextEditingController();
// phoneController = TextEditingController();
// bioController = TextEditingController();
// }
//
// @override
// void dispose() {
// nameController.dispose();
// phoneController.dispose();
// bioController.dispose();
// super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
// return BlocConsumer<AppCubit, AppState>(
// listener: (context, state) {},
// builder: (context, state) {
// UserModel? userModel = AppCubit.get(context).currentUser;
//
// if (userModel != null) {
// nameController.text = userModel.name;
// phoneController.text = userModel.phone;
// bioController.text = userModel.bio;
// }
//
// File? profileImage = AppCubit.get(context).profileImage;
// File? coverImage = AppCubit.get(context).coverImage;
//
// return Scaffold(
// appBar: defaultAppBar(
// context: context,
// title: 'Edit profile',
// actions: [
// defaultTextButton(
// onPressedFunction: () {
// AppCubit.get(context).updateUser(
// name: nameController.text,
// phone: phoneController.text,
// bio: bioController.text,
// );
// },
// text: 'update',
// ),
// const SizedBox(width: 15.0),
// ],
// ),
// body: Padding(
// padding: const EdgeInsets.all(8.0),
// child: SingleChildScrollView(
// child: Column(
// children: [
//   if (state is UpdateUserLoading) LinearProgressIndicator(),
//                     Container(
//                       height: 190,
//                       child: Align(
//                         alignment: AlignmentDirectional.topCenter,
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           alignment: AlignmentDirectional.bottomCenter,
//                           children: [
//                             Stack(
//                               alignment: AlignmentDirectional.bottomEnd,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       height: 150.0,
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: coverImage == null
//                                               ? NetworkImage(
//                                                   '${userModel?.cover}',/////////////////////////////////
//                                                 )
//                                               : FileImage(coverImage)
//                                                   as ImageProvider<Object>,
//                                           fit: BoxFit.cover,
//                                         ),
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(4.0),
//                                           topRight: Radius.circular(4.0),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10.0),
//                                   ],
//                                 ),
//                                 Transform.translate(
//                                   offset: Offset(0, -20.0),
//                                   child: IconButton(
//                                     onPressed: () {
//                                       AppCubit.get(context).getCoverImage();
//                                     },
//                                     icon: CircleAvatar(
//                                       radius: 20.0,
//                                       child: Icon(
//                                        Icons.camera_alt_outlined,
//                                         size: 16.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Positioned(
//                               bottom: -20,
//                               child: Stack(
//                                 alignment: AlignmentDirectional.bottomEnd,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: Theme.of(context)
//                                             .scaffoldBackgroundColor,
//                                         radius: 70.0,
//                                         child: CircleAvatar(
//                                           radius: 60.0,
//                                           backgroundImage: profileImage == null
//                                               ? NetworkImage(
//                                                   '${userModel?.image}',////////////////////////////
//                                                 )
//                                               : FileImage(profileImage)
//                                                   as ImageProvider<Object>?,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10.0),
//                                     ],
//                                   ),
//                                   Transform.translate(
//                                     offset: Offset(5.0, -15.0),
//                                     child: IconButton(
//                                       onPressed: () {
//                                         AppCubit.get(context)
//                                             .getProfileImage();
//                                       },
//                                       icon: CircleAvatar(
//                                         radius: 20.0,
//                                         child: Icon(
//                                           Icons.add,
//                                           size: 16.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     defaultFormField(
//                       controller: nameController,
//                       type: TextInputType.name,
//                       validate: (val) {
//                         if (val.isEmpty) {
//                           return 'Name must not be empty';
//                         }
//                         return null;
//                       },
//                       label: 'Name',
//                       prefix: Icons.account_circle_outlined,
//                     ),
//                     const SizedBox(height: 10),
//                     defaultFormField(
//                       controller: phoneController,
//                       type: TextInputType.phone,
//                       validate: (val) {
//                         if (val.isEmpty) {
//                           return 'Phone must not be empty';
//                         }
//                         return null;
//                       },
//                       label: 'Phone',
//                       prefix: Icons.call_end_rounded,
//                     ),
//                     const SizedBox(height: 10),
//                     defaultFormField(
//                       controller: bioController,
//                       type: TextInputType.name,
//                       validate: (val) {
//                         if (val.isEmpty) {
//                           return 'Bio must not be empty';
//                         }
//                         return null;
//                       },
//                       label: 'Bio',
//                       prefix: Icons.info_outline_rounded,
//                     ),
// ],
// ),
// ),
// ),
// );
// },
// );
// }
// }
//
//




import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cupit/app_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';

class EditProfileScreen extends StatefulWidget {
const EditProfileScreen({Key? key}) : super(key: key);

@override
_EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
late TextEditingController nameController;
late TextEditingController phoneController;
late TextEditingController bioController;

@override
void initState() {
super.initState();
nameController = TextEditingController();
phoneController = TextEditingController();
bioController = TextEditingController();
}

@override
void dispose() {
nameController.dispose();
phoneController.dispose();
bioController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return BlocConsumer<AppCubit, AppState>(
listener: (context, state) {},
builder: (context, state) {
UserModel? userModel = AppCubit.get(context).currentUser;

if (userModel != null) {
nameController.text = userModel.name;
phoneController.text = userModel.phone;
bioController.text = userModel.bio;
}

File? profileImage = AppCubit.get(context).profileImage;
File? coverImage = AppCubit.get(context).coverImage;

return Scaffold(
appBar: defaultAppBar(
context: context,
title: 'Edit profile',
actions: [
defaultTextButton(
onPressedFunction: () {
AppCubit.get(context).updateUser(
name: nameController.text,
phone: phoneController.text,
bio: bioController.text,
);
},
text: 'update',
),
const SizedBox(width: 15.0),
],
),
body: Padding(
padding: const EdgeInsets.all(8.0),
child: SingleChildScrollView(
child: Column(
children: [
if (state is UpdateUserLoading) LinearProgressIndicator(),
Container(
height: 190,
child: Align(
alignment: AlignmentDirectional.topCenter,
child: Stack(
clipBehavior: Clip.none,
alignment: AlignmentDirectional.bottomCenter,
children: [
Stack(
alignment: AlignmentDirectional.bottomEnd,
children: [
Column(
children: [
Container(
height: 150.0,
width: double.infinity,
decoration: BoxDecoration(
image: DecorationImage(
image: coverImage == null
? AssetImage(
'assets/images/image2.png',
)
    : FileImage(coverImage)
as ImageProvider<Object>,
fit: BoxFit.cover,
),
borderRadius: BorderRadius.only(
topLeft: Radius.circular(4.0),
topRight: Radius.circular(4.0),
),
),
),
const SizedBox(height: 10.0),
],
),
Transform.translate(
offset: Offset(0, -20.0),
child: IconButton(
onPressed: () {
AppCubit.get(context).getCoverImage();
},
icon: CircleAvatar(
radius: 20.0,
child: Icon(
Icons.camera_alt_outlined,
size: 16.0,
),
),
),
),
],
),
Positioned(
bottom: -20,
child: Stack(
alignment: AlignmentDirectional.bottomEnd,
children: [
Column(
children: [
CircleAvatar(
backgroundColor: Theme.of(context)
    .scaffoldBackgroundColor,
radius: 70.0,
child: CircleAvatar(
radius: 60.0,
backgroundImage: profileImage == null
? AssetImage(
'assets/images/image1.png',
)
    : FileImage(profileImage)
as ImageProvider<Object>?,
),
),
const SizedBox(height: 10.0),
],
),
Transform.translate(
offset: Offset(5.0, -15.0),
child: IconButton(
onPressed: () {
AppCubit.get(context)
    .getProfileImage();
},
icon: CircleAvatar(
radius: 20.0,
child: Icon(
Icons.add,
size: 16.0,
),
),
),
),
],
),
),
],
),
),
),
const SizedBox(height: 40),
defaultFormField(
controller: nameController,
type: TextInputType.name,
validate: (val) {
if (val.isEmpty) {
return 'Name must not be empty';
}
return null;
},
label: 'Name',
prefix: Icons.account_circle_outlined,
),
const SizedBox(height: 10),
defaultFormField(
controller: phoneController,
type: TextInputType.phone,
validate: (val) {
if (val.isEmpty) {
return 'Phone must not be empty';
}
return null;
},
label: 'Phone',
prefix: Icons.call_end_rounded,
),
const SizedBox(height: 10),
defaultFormField(
controller: bioController,
type: TextInputType.name,
validate: (val) {
if (val.isEmpty) {
return 'Bio must not be empty';
}
return null;
},
label: 'Bio',
prefix: Icons.info_outline_rounded,
),
],
),
),
),
);
},
);
}
}


