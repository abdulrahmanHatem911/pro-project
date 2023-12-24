import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:pre/modules/risgister/cupit/register_cubit.dart';

import '../../app_router.dart';
import '../../shared/adptive/adaptive_circuar.dart';
import '../../shared/adptive/os.dart';
import '../../shared/components/components.dart';
import '../../shared/services/local/cache_data.dart';
import '../../shared/services/local/cahce_helper.dart';
import '../../shared/styles/my_main.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is CreateUserSucess) {
          CacheHelper.saveCacheData(key: 'uId', value: state.uId).then(
            (_) {
              CacheData.uId = CacheHelper.getCacheData(key: 'uId');

              // to remove all screens from stack and go to homeLayoutScreen
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.homeLayoutScreen,
                (route) => false,
              );
            },
          );
        }
      },
      builder: (context, state) {
        RegisterCubit registerCubit = RegisterCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: _buildBody(
            context: context,
            state: state,
            registerCubit: registerCubit,
            nameController: nameController,
            emailController: emailController,
            phoneController: phoneController,
            passwordController: passwordController,
          ),
        );
      },
    );
  }

  Center _buildBody({
    required BuildContext context,
    required RegisterState state,
    required RegisterCubit registerCubit,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/image5.png'),
                  width: double.infinity,
                  height: 200.0,
                ),
                Text(
                  'REGISTER',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: MyMainColors.myBlack,
                      ),
                ),
                Text(
                  'Register now to connect with world',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                  },
                  label: 'Name',
                  prefix: Icons.person,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Adress';
                    }
                  },
                  label: 'Email Adress',
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Phone';
                    }
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  isPassword: registerCubit.isPassword,
                  suffix: registerCubit.suffix,
                  suffixPressed: () {
                    registerCubit.changePasswordVisibality();
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                  },
                  onSubmit: (_) {
                    _registerAuthorization(
                      context: context,
                      registerCubit: registerCubit,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      passwordController: passwordController,
                    );
                  },
                  label: 'Password',
                  prefix: Icons.lock_outline,
                ),
                const SizedBox(height: 30),
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) {
                    return state is! RegisterLoading;
                  },
                  widgetBuilder: (BuildContext context) {
                    return defaultButton(
                      onPressedFunction: () {
                        _registerAuthorization(
                          context: context,
                          registerCubit: registerCubit,
                          nameController: nameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          passwordController: passwordController,
                        );
                      },
                      text: 'Register',
                    );
                  },
                  fallbackBuilder: (context) => Center(
                    child: AdaptiveCircularProgressIndicator(
                      os: OperatingSystem.getOs(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerAuthorization({
    required BuildContext context,
    required RegisterCubit registerCubit,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  }) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      registerCubit.userRegister(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
    }
  }
}
