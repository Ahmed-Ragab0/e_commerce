import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/modules/category_products_screen/category_product_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: InkWell(
          onTap: () {
            LoginCubit.get(context).getCategoryProducts(model.id);
            navigateTo(
              context,
              CategoryProductScreen(
                categoryName: model.name,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(10),
                    bottomStart: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    imageUrl: model.image.toString(),
                  ),
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
          ),
        ),
      );
}
