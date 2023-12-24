import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cupit/app_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.appBarTitles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notification_important)),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),

          body:
          cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(


            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavigationBarItems(index);
            },
            items: cubit.bottomNavigationBarItems,
          ),

        );
      },
    ),
    );
  }
}