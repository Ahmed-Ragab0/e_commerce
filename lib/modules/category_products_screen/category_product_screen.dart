import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key, this.categoryName});

  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = LoginCubit.get(context).categoryProductModel?.data!.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(categoryName!),
            ),
            body: ConditionalBuilder(
              condition: state is! GetCatProductLoadingState,
              builder: (context) => SingleChildScrollView(
                child: customGridView(list, context),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
