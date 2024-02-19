import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginCubit>(context);
        var list = cubit.homeModel?.data!.products;
        var categoryModel = cubit.categoryModel;
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) =>
              builderWidget(cubit, list, context, categoryModel!),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
