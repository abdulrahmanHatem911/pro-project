// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // import 'package:intl/intl.dart';
// // // //
// // // // import '../layout/cupit/app_cubit.dart';
// // // // import '../shared/components/components.dart';
// // // //
// // // // class NoteScreen extends StatelessWidget {
// // // // // Variables
// // // // var scaffoldKey = GlobalKey<ScaffoldState>();
// // // // var formKey = GlobalKey<FormState>();
// // // // var titleController = TextEditingController();
// // // // var timeController = TextEditingController();
// // // // var dateController = TextEditingController();
// // // //
// // // // @override
// // // // Widget build(BuildContext context) {
// // // // return BlocProvider(
// // // // create: (BuildContext context) => AppCubit()..createDatabase(),
// // // // child: BlocConsumer<AppCubit, AppState>(
// // // // listener: (BuildContext context, AppState state) {
// // // // if (state is AppInsertDatabaseState) {
// // // // Navigator.pop(context);
// // // // }
// // // // },
// // // // builder: (BuildContext context, state) {
// // // // AppCubit cubit = AppCubit.get(context);
// // // //
// // // // Widget bodyWidget;
// // // //
// // // // if (state is! AppCreateDatabaseLoadingState) {
// // // // bodyWidget = cubit.bodyScreens[cubit.currentIndex];
// // // // } else {
// // // // bodyWidget = Center(child: CircularProgressIndicator());
// // // // }
// // // //
// // // // return Scaffold(
// // // // key: scaffoldKey,
// // // // appBar: AppBar(
// // // // title: Text(cubit.titleScreen[cubit.currentIndex]),
// // // // ),
// // // // body: bodyWidget,
// // // // floatingActionButton: FloatingActionButton(
// // // // onPressed: () {
// // // // if (cubit.isBottomSheetShawn) {
// // // // if (formKey.currentState!.validate()) {
// // // // cubit.insertToDatabase(
// // // // date: dateController.text, time: timeController.text, title: titleController.text);
// // // // }
// // // // } else {
// // // // scaffoldKey.currentState!
// // // //     .showBottomSheet(
// // // // (context) => Container(
// // // // color: Colors.white,
// // // // padding: EdgeInsets.all(20),
// // // // child: Form(
// // // // key: formKey,
// // // // child: Column(
// // // // mainAxisSize: MainAxisSize.min,
// // // // children: [
// // // // defaultFormField(
// // // // prefix: Icons.title,
// // // // validate: (String? val) {
// // // // if (val!.isEmpty) {
// // // // return 'title is empty';
// // // // }
// // // // return null;
// // // // },
// // // // controller: titleController,
// // // // label: 'Task Title',
// // // // type: TextInputType.text,
// // // // ),
// // // // SizedBox(height: 15),
// // // // defaultFormField(
// // // // prefix: Icons.watch_later_outlined,
// // // // validate: (String? val) {
// // // // if (val!.isEmpty) {
// // // // return 'time is empty';
// // // // }
// // // // return null;
// // // // },
// // // // controller: timeController,
// // // // label: 'Task Time',
// // // // type: TextInputType.datetime,
// // // // onTap: () {
// // // // showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
// // // // timeController.text = value!.format(context).toString();
// // // // });
// // // // },
// // // // ),
// // // // SizedBox(height: 15),
// // // // defaultFormField(
// // // // prefix: Icons.calendar_today,
// // // // validate: (String? val) {
// // // // if (val!.isEmpty) {
// // // // return 'Date is empty';
// // // // }
// // // // return null;
// // // // },
// // // // controller: dateController,
// // // // label: 'Task Date',
// // // // type: TextInputType.datetime,
// // // // onTap: () {
// // // // showDatePicker(
// // // // context: context,
// // // // initialDate: DateTime.now(),
// // // // firstDate: DateTime.now(),
// // // // lastDate: DateTime.parse('2021-12-12'))
// // // //     .then((value) {
// // // // dateController.text = DateFormat.yMMMd().format(value!);
// // // // });
// // // // },
// // // // ),
// // // // ],
// // // // ),
// // // // ),
// // // // ),
// // // // elevation: 20,
// // // // )
// // // //     .closed
// // // //     .then((value) {
// // // // cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
// // // // });
// // // // cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
// // // // }
// // // // },
// // // // child: Icon(cubit.fabIcon),
// // // // ),
// // // // bottomNavigationBar: BottomNavigationBar(
// // // // type: BottomNavigationBarType.fixed,
// // // // currentIndex: cubit.currentIndex,
// // // // onTap: (index) {
// // // // cubit.changeIndex(index);
// // // // },
// // // // items: [
// // // // BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
// // // // BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Done'),
// // // // BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'archived'),
// // // // ],
// // // // ),
// // // // );
// // // // },
// // // // ),
// // // // );
// // // // }
// // // // }
// // // //
// // // //
// // // //
// // //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:intl/intl.dart';
// // //
// // // import '../layout/cupit/app_cubit.dart';
// // // import '../shared/components/components.dart';
// // //
// // // class NoteScreen extends StatelessWidget {
// // // // المتغيرات
// // // var scaffoldKey = GlobalKey<ScaffoldState>();
// // // var formKey = GlobalKey<FormState>();
// // // var titleController = TextEditingController();
// // // var timeController = TextEditingController();
// // // var dateController = TextEditingController();
// // //
// // // @override
// // // Widget build(BuildContext context) {
// // // return BlocProvider(
// // // create: (BuildContext context) => AppCubit()..createDatabase(),
// // // child: BlocConsumer<AppCubit, AppState>(
// // // listener: (BuildContext context, AppState state) {
// // // if (state is AppInsertDatabaseState) {
// // // Navigator.pop(context);
// // // }
// // // },
// // // builder: (BuildContext context, state) {
// // // AppCubit cubit = AppCubit.get(context);
// // //
// // // Widget bodyWidget;
// // //
// // // if (state is! AppCreateDatabaseLoadingState) {
// // // bodyWidget = cubit.bodyScreens[cubit.currentIndex];
// // // } else {
// // // bodyWidget = Center(child: CircularProgressIndicator());
// // // }
// // //
// // // return Scaffold(
// // // key: scaffoldKey,
// // // appBar: AppBar(
// // // title: Text(cubit.titleScreen[cubit.currentIndex]),
// // // leading: IconButton(
// // // icon: Icon(Icons.menu),
// // // onPressed: () {
// // // scaffoldKey.currentState!.openDrawer();
// // // },
// // // ),
// // // ),
// // // body: bodyWidget,
// // // drawer: Drawer(
// // // child: ListView(
// // // padding: EdgeInsets.zero,
// // // children: <Widget>[
// // // DrawerHeader(
// // // child: Text('Header'), // عنوان القائمة الجانبية هنا
// // // decoration: BoxDecoration(
// // // color: Colors.blue, // يمكن تغيير اللون حسب الرغبة
// // // ),
// // // ),
// // // ListTile(
// // // title: Text('Tasks'),
// // // onTap: () {
// // // cubit.changeIndex(0); // أي عملية تريدها عند النقر على هذا العنصر
// // // Navigator.pop(context); // لإخفاء القائمة الجانبية
// // // },
// // // ),
// // // ListTile(
// // // title: Text('Done'),
// // // onTap: () {
// // // cubit.changeIndex(1); // أي عملية تريدها عند النقر على هذا العنصر
// // // Navigator.pop(context); // لإخفاء القائمة الجانبية
// // // },
// // // ),
// // // ListTile(
// // // title: Text('Archived'),
// // // onTap: () {
// // // cubit.changeIndex(2); // أي عملية تريدها عند النقر على هذا العنصر
// // // Navigator.pop(context); // لإخفاء القائمة الجانبية
// // // },
// // // ),
// // // ],
// // // ),
// // // ),
// // // floatingActionButton: FloatingActionButton(
// // // onPressed: () {
// // // if (cubit.isBottomSheetShawn) {
// // // if (formKey.currentState!.validate()) {
// // // cubit.insertToDatabase(
// // // date: dateController.text,
// // // time: timeController.text,
// // // title: titleController.text,
// // // );
// // // }
// // // } else {
// // // scaffoldKey.currentState!
// // //     .showBottomSheet(
// // // (context) => Container(
// // // color: Colors.white,
// // // padding: EdgeInsets.all(20),
// // // child: Form(
// // // key: formKey,
// // // child: Column(
// // // mainAxisSize: MainAxisSize.min,
// // // children: [
// // // defaultFormField(
// // // prefix: Icons.title,
// // // validate: (String? val) {
// // // if (val!.isEmpty) {
// // // return 'title is empty';
// // // }
// // // return null;
// // // },
// // // controller: titleController,
// // // label: 'Task Title',
// // // type: TextInputType.text,
// // // ),
// // // SizedBox(height: 15),
// // // defaultFormField(
// // // prefix: Icons.watch_later_outlined,
// // // validate: (String? val) {
// // // if (val!.isEmpty) {
// // // return 'time is empty';
// // // }
// // // return null;
// // // },
// // // controller: timeController,
// // // label: 'Task Time',
// // // type: TextInputType.datetime,
// // // onTap: () {
// // // showTimePicker(
// // // context: context,
// // // initialTime: TimeOfDay.now(),
// // // ).then((value) {
// // // timeController.text =
// // // value!.format(context).toString();
// // // });
// // // },
// // // ),
// // // SizedBox(height: 15),
// // // defaultFormField(
// // // prefix: Icons.calendar_today,
// // // validate: (String? val) {
// // // if (val!.isEmpty) {
// // // return 'Date is empty';
// // // }
// // // return null;
// // // },
// // // controller: dateController,
// // // label: 'Task Date',
// // // type: TextInputType.datetime,
// // // onTap: () {
// // // showDatePicker(
// // // context: context,
// // // initialDate: DateTime.now(),
// // // firstDate: DateTime.now(),
// // // lastDate: DateTime.parse('2021-12-12'),
// // // ).then((value) {
// // // dateController.text =
// // // DateFormat.yMMMd().format(value!);
// // // });
// // // },
// // // ),
// // // ],
// // // ),
// // // ),
// // // ),
// // // )
// // //     .closed
// // //     .then((value) {
// // // cubit.changeBottomSheetState(
// // // isShow: false,
// // // icon: Icons.edit,
// // // );
// // // });
// // // cubit.changeBottomSheetState(
// // // isShow: true,
// // // icon: Icons.add,
// // // );
// // // }
// // // },
// // // child: Icon(cubit.fabIcon),
// // // ),
// // // );
// // // },
// // // ),
// // // );
// // // }
// // // }
// // //
// // //
// //
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:intl/intl.dart';
// //
// // import '../layout/cupit/app_cubit.dart';
// // import '../shared/components/components.dart';
// //
// // class NoteScreen extends StatelessWidget {
// // var scaffoldKey = GlobalKey<ScaffoldState>();
// // var formKey = GlobalKey<FormState>();
// // var titleController = TextEditingController();
// // var timeController = TextEditingController();
// // var dateController = TextEditingController();
// //
// // @override
// // Widget build(BuildContext context) {
// // return BlocProvider(
// // create: (BuildContext context) => AppCubit()..createDatabase(),
// // child: BlocConsumer<AppCubit, AppState>(
// // listener: (BuildContext context, AppState state) {
// // if (state is AppInsertDatabaseState) {
// // Navigator.pop(context);
// // }
// // },
// // builder: (BuildContext context, state) {
// // AppCubit cubit = AppCubit.get(context);
// //
// // Widget bodyWidget;
// //
// // if (state is! AppCreateDatabaseLoadingState) {
// // bodyWidget = cubit.bodyScreens[cubit.currentIndex];
// // } else {
// // bodyWidget = Center(child: CircularProgressIndicator());
// // }
// //
// // return Scaffold(
// // key: scaffoldKey,
// // appBar: AppBar(
// // title: Text(cubit.titleScreen[cubit.currentIndex]),
// // leading: IconButton(
// // icon: Icon(Icons.menu),
// // onPressed: () {
// // scaffoldKey.currentState!.openDrawer();
// // },
// // ),
// // ),
// // drawer: Drawer(
// // child: ListView(
// // padding: EdgeInsets.zero,
// // children: <Widget>[
// // DrawerHeader(
// // child: Text('Header'),
// // decoration: BoxDecoration(
// // color: Colors.blue,
// // ),
// // ),
// // ListTile(
// // title: Text('Tasks'),
// // onTap: () {
// // cubit.changeIndex(0);
// // Navigator.pop(context);
// // },
// // ),
// // ListTile(
// // title: Text('Done'),
// // onTap: () {
// // cubit.changeIndex(1);
// // Navigator.pop(context);
// // },
// // ),
// // ListTile(
// // title: Text('Archived'),
// // onTap: () {
// // cubit.changeIndex(2);
// // Navigator.pop(context);
// // },
// // ),
// // ],
// // ),
// // ),
// // body: GestureDetector(
// // onHorizontalDragEnd: (details) {
// // if (details.primaryVelocity! > 0) {
// // scaffoldKey.currentState!.openDrawer();
// // }
// // },
// // child: bodyWidget,
// // ),
// // floatingActionButton: FloatingActionButton(
// // onPressed: () {
// // if (cubit.isBottomSheetShawn) {
// // if (formKey.currentState!.validate()) {
// // cubit.insertToDatabase(
// // date: dateController.text,
// // time: timeController.text,
// // title: titleController.text,
// // );
// // }
// // } else {
// // scaffoldKey.currentState!
// //     .showBottomSheet(
// // (context) => Container(
// // color: Colors.white,
// // padding: EdgeInsets.all(20),
// // child: Form(
// // key: formKey,
// // child: Column(
// // mainAxisSize: MainAxisSize.min,
// // children: [
// // defaultFormField(
// // prefix: Icons.title,
// // validate: (String? val) {
// // if (val!.isEmpty) {
// // return 'title is empty';
// // }
// // return null;
// // },
// // controller: titleController,
// // label: 'Task Title',
// // type: TextInputType.text,
// // ),
// // SizedBox(height: 15),
// // defaultFormField(
// // prefix: Icons.watch_later_outlined,
// // validate: (String? val) {
// // if (val!.isEmpty) {
// // return 'time is empty';
// // }
// // return null;
// // },
// // controller: timeController,
// // label: 'Task Time',
// // type: TextInputType.datetime,
// // onTap: () {
// // showTimePicker(
// // context: context,
// // initialTime: TimeOfDay.now(),
// // ).then((value) {
// // timeController.text =
// // value!.format(context).toString();
// // });
// // },
// // ),
// // SizedBox(height: 15),
// // defaultFormField(
// // prefix: Icons.calendar_today,
// // validate: (String? val) {
// // if (val!.isEmpty) {
// // return 'Date is empty';
// // }
// // return null;
// // },
// // controller: dateController,
// // label: 'Task Date',
// // type: TextInputType.datetime,
// // onTap: () {
// // showDatePicker(
// // context: context,
// // initialDate: DateTime.now(),
// // firstDate: DateTime.now(),
// // lastDate: DateTime.parse('2021-12-12'),
// // ).then((value) {
// // dateController.text =
// // DateFormat.yMMMd().format(value!);
// // });
// // },
// // ),
// // ],
// // ),
// // ),
// // ),
// // )
// //     .closed
// //     .then((value) {
// // cubit.changeBottomSheetState(
// // isShow: false,
// // icon: Icons.edit,
// // );
// // });
// // cubit.changeBottomSheetState(
// // isShow: true,
// // icon: Icons.add,
// // );
// // }
// // },
// // child: Icon(Icons.add), // تغيير الأيقونة إلى زر الإضافة
// // ),
// // );
// // },
// // ),
// // );
// // }
// // }
// //
// //
// //
// //
// //
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
//
// import '../layout/cupit/app_cubit.dart';
// import '../shared/components/components.dart';
//
// class NoteScreen extends StatelessWidget {
// var scaffoldKey = GlobalKey<ScaffoldState>();
// var formKey = GlobalKey<FormState>();
// var titleController = TextEditingController();
// var timeController = TextEditingController();
// var dateController = TextEditingController();
//
// @override
// Widget build(BuildContext context) {
// return BlocProvider(
// create: (BuildContext context) => AppCubit()..createDatabase(),
// child: BlocConsumer<AppCubit, AppState>(
// listener: (BuildContext context, AppState state) {
// if (state is AppInsertDatabaseState) {
// Navigator.pop(context);
// }
// },
// builder: (BuildContext context, state) {
// AppCubit cubit = AppCubit.get(context);
//
// Widget bodyWidget;
//
// if (state is! AppCreateDatabaseLoadingState) {
// bodyWidget = cubit.bodyScreens[cubit.currentIndex];
// } else {
// bodyWidget = Center(child: CircularProgressIndicator());
// }
//
// return Scaffold(
// key: scaffoldKey,
// drawer: Drawer(
// child: ListView(
// padding: EdgeInsets.zero,
// children: <Widget>[
// DrawerHeader(
// child: Text('Header'),
// decoration: BoxDecoration(
// color: Colors.blue,
// ),
// ),
// ListTile(
// title: Text('Tasks'),
// onTap: () {
// cubit.changeIndex(0);
// Navigator.pop(context);
// },
// ),
// ListTile(
// title: Text('Done'),
// onTap: () {
// cubit.changeIndex(1);
// Navigator.pop(context);
// },
// ),
// ListTile(
// title: Text('Archived'),
// onTap: () {
// cubit.changeIndex(2);
// Navigator.pop(context);
// },
// ),
// ],
// ),
// ),
// body: Stack(
// children: [
// GestureDetector(
// onHorizontalDragEnd: (details) {
// if (details.primaryVelocity! > 0) {
// scaffoldKey.currentState!.openDrawer();
// }
// },
// child: bodyWidget,
// ),
// Positioned(
// top: 30,
// left: 10,
// child: TextButton(
// onPressed: () {
// scaffoldKey.currentState!.openDrawer();
// },
// child: Text(
// 'Menu',
// style: TextStyle(color: Colors.black),
// ),
// ),
// ),
// ],
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// if (cubit.isBottomSheetShawn) {
// if (formKey.currentState!.validate()) {
// cubit.insertToDatabase(
// date: dateController.text,
// time: timeController.text,
// title: titleController.text,
// );
// }
// } else {
// scaffoldKey.currentState!
//     .showBottomSheet(
// (context) => Container(
// color: Colors.white,
// padding: EdgeInsets.all(20),
// child: Form(
// key: formKey,
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// defaultFormField(
// prefix: Icons.title,
// validate: (String? val) {
// if (val!.isEmpty) {
// return 'title is empty';
// }
// return null;
// },
// controller: titleController,
// label: 'Task Title',
// type: TextInputType.text,
// ),
// SizedBox(height: 15),
// defaultFormField(
// prefix: Icons.watch_later_outlined,
// validate: (String? val) {
// if (val!.isEmpty) {
// return 'time is empty';
// }
// return null;
// },
// controller: timeController,
// label: 'Task Time',
// type: TextInputType.datetime,
// onTap: () {
// showTimePicker(
// context: context,
// initialTime: TimeOfDay.now(),
// ).then((value) {
// timeController.text =
// value!.format(context).toString();
// });
// },
// ),
// SizedBox(height: 15),
// defaultFormField(
// prefix: Icons.calendar_today,
// validate: (String? val) {
// if (val!.isEmpty) {
// return 'Date is empty';
// }
// return null;
// },
// controller: dateController,
// label: 'Task Date',
// type: TextInputType.datetime,
// onTap: () {
// showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime.now(),
// lastDate: DateTime.parse('2021-12-12'),
// ).then((value) {
// dateController.text =
// DateFormat.yMMMd().format(value!);
// });
// },
// ),
// ],
// ),
// ),
// ),
// )
//     .closed
//     .then((value) {
// cubit.changeBottomSheetState(
// isShow: false,
// icon: Icons.edit,
// );
// });
// cubit.changeBottomSheetState(
// isShow: true,
// icon: Icons.add,
// );
// }
// },
// child: Icon(Icons.add),
// ),
// );
// },
// ),
// );
// }
// }
//
//
//
//
//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../layout/cupit/app_cubit.dart';
import '../shared/components/components.dart';

class NoteScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          Widget bodyWidget;

          if (state is! AppCreateDatabaseLoadingState) {
            bodyWidget = cubit.bodyScreens[cubit.currentIndex];
          } else {
            bodyWidget = Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Image(
                      image: AssetImage('assets/images/image6.png'),
                      width: double.infinity,
                      height: 300.0,
                    ),
                  ),
                  ListTile(
                    title: Text('Tasks'),
                    onTap: () {
                      cubit.changeIndex(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Done'),
                    onTap: () {
                      cubit.changeIndex(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Archived'),
                    onTap: () {
                      cubit.changeIndex(2);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      scaffoldKey.currentState!.openDrawer();
                    }
                  },
                  child: bodyWidget,
                ),
                Container(
                  height: 70,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Positioned(
                    top: 80,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.arrow_right,
                          color: Colors.black38, size: 40),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShawn) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      date: dateController.text,
                      time: timeController.text,
                      title: titleController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  prefix: Icons.title,
                                  validate: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'title is empty';
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  label: 'Task Title',
                                  type: TextInputType.text,
                                ),
                                SizedBox(height: 15),
                                defaultFormField(
                                  prefix: Icons.watch_later_outlined,
                                  validate: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'time is empty';
                                    }
                                    return null;
                                  },
                                  controller: timeController,
                                  label: 'Task Time',
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                ),
                                SizedBox(height: 15),
                                defaultFormField(
                                  prefix: Icons.calendar_today,
                                  validate: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'Date is empty';
                                    }
                                    return null;
                                  },
                                  controller: dateController,
                                  label: 'Task Date',
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-12-12'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
