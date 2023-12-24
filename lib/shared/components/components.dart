import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cupit/app_cubit.dart';

TextFormField defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    enabled: isClickable,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate as String? Function(String?)?,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: suffixPressed as void Function()?,
        icon: Icon(
          suffix,
        ),
      )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Container defaultButton({
  required Function onPressedFunction,
  required String text,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
}) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: onPressedFunction as VoidCallback,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

TextButton defaultTextButton({
  required Function onPressedFunction,
  required String text,
}) {
  return TextButton(
    onPressed: onPressedFunction as VoidCallback,
    child: Text(
      text.toUpperCase(),
    ),
  );
}

enum ToastStates {
  SUCCESS,
  WARNING,
  ERROR,
}

Color chooseToastColor({
  required ToastStates state,
}) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    titleSpacing: 0.0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios_sharp),
    ),
    title: Text(title != null ? title : ''),
    actions: actions != null ? actions : [],
  );
}

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: Icon(Icons.archive),
          color: Colors.black45,
        ),
      ],
    ),
  ),
);


Widget tasksBuilder(List<Map> tasks) {
  if (tasks.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  } else {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
      itemCount: tasks.length,
    );
  }
}



