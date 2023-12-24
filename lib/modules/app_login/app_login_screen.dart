import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../app_router.dart';
import '../../shared/adptive/adaptive_circuar.dart';
import '../../shared/adptive/os.dart';
import '../../shared/components/components.dart';
import '../../shared/services/local/cache_data.dart';
import '../../shared/services/local/cahce_helper.dart';
import '../../shared/styles/my_main.dart';
import 'cupit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
        if (state is LoginSucess) {
          CacheHelper.saveCacheData(key: 'uId', value: state.uId).then(
                (_) {
              CacheData.uId = CacheHelper.getCacheData(key: 'uId');

              Navigator.pushReplacementNamed(
                context,
                AppRouter.homeLayoutScreen,
              );
            },
          );
        }
      },
      builder: (context, state) {
        LoginCubit _loginCubit = LoginCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: _buildBody(
            context,
            _emailController,
            _passwordController,
            state,
            _loginCubit,
          ),
        );
      },
    );
  }

  Center _buildBody(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController,
      LoginState state,
      LoginCubit _loginCubit,
      ) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Image(image:AssetImage(
                  'assets/images/image5.png'
                ) ,
                width: double.infinity,
                  height: 300.0,
                ),
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: MyMainColors.myBlack,
                  ),
                ),
                Text(
                  'Login now to connect with world',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultFormField(
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Adress';
                    }
                  },
                  label: 'Email Adress',
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultFormField(
                  controller: _passwordController,
                  type: TextInputType.visiblePassword,
                  isPassword: _loginCubit.isPassword,
                  suffix: _loginCubit.suffix,
                  suffixPressed: () {
                    _loginCubit.changePasswordVisibality();
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                  },
                  onSubmit: (_) {
                    _loginAuthorization(
                      context,
                      _emailController,
                      _passwordController,
                      _loginCubit,
                    );
                  },
                  label: 'Password',
                  prefix: Icons.lock_outline,
                ),
                const SizedBox(
                  height: 30,
                ),
            Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) {
                    return state is! LoginLoading;
                  },
                  widgetBuilder: (BuildContext context) {
                    return defaultButton(
                      onPressedFunction: () {
                        _loginAuthorization(
                          context,
                          _emailController,
                          _passwordController,
                          _loginCubit,
                        );
                      },
                      text: 'login',
                    );
                  },

                  fallbackBuilder: (context) => Center(
                    child: AdaptiveCircularProgressIndicator(
                      os: OperatingSystem.getOs(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t Have An Account'),
                    defaultTextButton(
                      onPressedFunction: () => _goToRegisterScreen(context),
                      text: 'Register',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginAuthorization(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController,
      LoginCubit _loginCubit,
      ) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      _loginCubit.userLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _goToRegisterScreen(context) {
    Navigator.pushNamed(context, AppRouter.registerScreen);
  }
}