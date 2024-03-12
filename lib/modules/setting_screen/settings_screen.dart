import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/modules/login/login_screen.dart';
import 'package:e_commerce/network/local/cach_helper.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = LoginCubit.get(context).userModel?.data;
        nameController.text = userData!.name.toString();
        emailController.text = userData.email.toString();
        phoneController.text = userData.phone.toString();
        return ConditionalBuilder(
          condition: LoginCubit.get(context).userModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DefaultFormField(
                        controller: nameController,
                        lable: 'Name',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        controller: emailController,
                        lable: 'Email',
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        controller: phoneController,
                        lable: 'Phone',
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton(
                          height: 55,
                          minWidth: double.infinity,
                          color: primary,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).updateData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          child: Text(
                            'update',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton(
                          height: 55,
                          minWidth: double.infinity,
                          color: Colors.red,
                          onPressed: () {
                            CachHelper.removeData(key: 'token').then((value) {
                              navigateAndFinish(context, const LoginScreen());
                            }).catchError((e) {
                              print(e);
                            });
                          },
                          child: Text(
                            'Sign Out',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
