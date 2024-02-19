import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/layout/home_layout.dart';
import 'package:e_commerce/modules/register/register_screen.dart';
import 'package:e_commerce/network/local/cach_helper.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.signInModel!.status) {
            debugPrint(state.signInModel!.message);
            debugPrint(state.signInModel?.data?.token);
            CachHelper.setData(
                    key: 'token', value: state.signInModel?.data?.token)
                .then(
              (value) => navigateAndFinish(
                context,
                const HomeLayout(),
              ),
            );

            Fluttertoast.showToast(
              msg: '${state.signInModel!.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            debugPrint(state.signInModel!.message);
            Fluttertoast.showToast(
              msg: '${state.signInModel!.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Login to browse our products',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                        controller: emailController,
                        lable: 'Email',
                        keyboardtype: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        controller: passwordController,
                        lable: 'Password',
                        submit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        keyboardtype: TextInputType.visiblePassword,
                        prefixIcon: Icons.password,
                        suffixIcon: cubit.suffix,
                        secure: cubit.isSecure,
                        suffixPressed: () {
                          cubit.changePasswordIcon();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password s too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? '),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, const RegisterScreen());
                            },
                            child: const Text(
                              'REGISTER',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
