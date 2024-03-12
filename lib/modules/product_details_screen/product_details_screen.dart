import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, this.id, this.index});

  final int? id;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! GetProductDetailsLoadingState,
            builder: (context) {
              var productList = LoginCubit.get(context)
                  .productDetailsModel!
                  .data!
                  .data![index!];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: productList.image.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: LoginCubit.get(context)
                                      .favorites[productList.id]!
                                  ? primary
                                  : Colors.grey,
                              child: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changeFav(productList.id);
                                },
                                icon: const Icon(
                                  Icons.favorite_outline_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              productList.name.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(productList.description.toString())
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
