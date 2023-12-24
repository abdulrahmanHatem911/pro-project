import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../app_router.dart';
import '../../layout/cupit/app_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/adptive/adaptive_circuar.dart';
import '../../shared/adptive/os.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = AppCubit.get(context).currentUser;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) => userModel != null,
            widgetBuilder: (context) => Column(
              children: [
                Container(
                  height: 190,
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                '${userModel!.cover}'
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -70,
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 70.0,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                            ),
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(

                  userModel.name,//////////////
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(

                  userModel.bio,//////////////
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '205',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '0',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '64',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          AppCubit.get(context)
                              .signOutAndClraeCache(context);
                        },
                        child: const Text('Signout'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRouter.editProfileScreen,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
            fallbackBuilder: (context) => Center(
              child: AdaptiveCircularProgressIndicator(
                os: OperatingSystem.getOs(),
              ),
            ),
          ),
        );
      },
    );
  }
}



