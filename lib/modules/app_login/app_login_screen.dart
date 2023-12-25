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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        LoginCubit loginCubit = LoginCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: _buildBody(
            context,
            _emailController,
            _passwordController,
            state,
            loginCubit,
          ),
        );
      },
    );
  }

  Center _buildBody(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    LoginState state,
    LoginCubit loginCubit,
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
                const Image(
                  image: AssetImage('assets/images/image5.png'),
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
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  isPassword: loginCubit.isPassword,
                  suffix: loginCubit.suffix,
                  suffixPressed: () {
                    loginCubit.changePasswordVisibality();
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                  },
                  onSubmit: (_) {
                    if (_formKey.currentState!.validate()) {
                      _loginAuthorization(
                        context,
                        emailController,
                        passwordController,
                        loginCubit,
                      );
                    }
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
                        if (_formKey.currentState!.validate()) {
                          _loginAuthorization(
                            context,
                            emailController,
                            passwordController,
                            loginCubit,
                          );
                        }
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
                    const Text('Don\'t Have An Account'),
                    defaultTextButton(
                      onPressedFunction: () {
                        _goToRegisterScreen(context);
                      },
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
    TextEditingController emailController,
    TextEditingController passwordController,
    LoginCubit loginCubit,
  ) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      loginCubit.userLogin(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  void _goToRegisterScreen(context) {
    Navigator.pushNamed(context, AppRouter.registerScreen);
  }
}
