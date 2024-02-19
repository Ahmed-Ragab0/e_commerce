import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginCubit>(context);
        return ListView.builder(
          itemBuilder: (context, index) {
            return buildCatItem(
              context,
              cubit.categoryModel!.data!.data[index],
            );
          },
          itemCount: cubit.categoryModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(context, CategoryDataModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              imageUrl: model.image.toString(),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ],
        ),
      );
}
