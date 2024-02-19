import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/models/favorites_data_model.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavLoadingState,
          builder: (context) => ListView.builder(
            itemBuilder: (context, index) => buildFavItem(context,
                LoginCubit.get(context).favoriteDataModel!.data!.data![index]),
            itemCount:
                LoginCubit.get(context).favoriteDataModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(context, FavoritesData model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 160,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    CachedNetworkImage(
                      height: 160,
                      width: 160,
                      imageUrl: model.product!.image.toString(),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    if (model.product!.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'DISCOUNT',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.name.toString(),
                        //list[index].name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.product!.price.round()} LE',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.product!.discount != 0)
                            Text(
                              model.product!.oldPrice.round().toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 2,
                                    color: Colors.grey,
                                  ),
                            ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: LoginCubit.get(context)
                                    .favorites[model.product!.id]!
                                ? primary
                                : Colors.grey,
                            child: IconButton(
                              onPressed: () {
                                LoginCubit.get(context)
                                    .changeFav(model.product!.id);
                              },
                              icon: const Icon(
                                Icons.favorite_outline_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
