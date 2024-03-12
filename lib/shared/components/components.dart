import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/modules/product_details_screen/product_details_screen.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: ((context) => widget),
    ),
    (route) => false,
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => widget),
    ),
  );
}

// ignore: must_be_immutable
class DefaultFormField extends StatelessWidget {
  DefaultFormField({
    super.key,
    this.controller,
    this.validate,
    this.keyboardtype,
    this.lable,
    this.prefixIcon,
    this.suffixPressed,
    this.suffixIcon,
    this.secure,
    this.submit,
  });

  final TextEditingController? controller;
  String? Function(String?)? validate;
  final TextInputType? keyboardtype;
  final String? lable;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Function()? suffixPressed;
  bool? secure;
  Function(String)? submit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: submit,
      controller: controller,
      validator: validate,
      keyboardType: keyboardtype,
      obscureText: secure ?? false,
      decoration: InputDecoration(
          label: Text(
            lable!,
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

Widget carouselSlider(LoginCubit cubit) {
  return CarouselSlider(
    items: cubit.homeModel!.data!.banners!
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: e.image.toString(),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        )
        .toList(),
    options: CarouselOptions(
      autoPlay: true,
      height: 220,
      initialPage: 0,
      enableInfiniteScroll: true,
      autoPlayCurve: Curves.fastOutSlowIn,
      autoPlayAnimationDuration: const Duration(seconds: 1),
      autoPlayInterval: const Duration(seconds: 3),
      reverse: false,
      viewportFraction: 1,
    ),
  );
}

Widget builderWidget(cubit, list, context, CategoryModel categoryModel) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carouselSlider(cubit),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 180,
                        height: 60,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(25),
                                bottomStart: Radius.circular(25),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: categoryModel.data!.data[index].image
                                    .toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                categoryModel.data!.data[index].name.toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: categoryModel.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'News Products',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          customGridView(list, context),
        ],
      ),
    );

Widget customGridView(list, context) => GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1 / 1.45,
      children: List.generate(
        list!.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              LoginCubit.get(context).getProductDetails(id: list[index].id);
              navigateTo(context, ProductDetailsScreen());
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        CachedNetworkImage(
                          height: 200,
                          width: double.infinity,
                          imageUrl: list[index].image.toString(),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                          progressIndicatorBuilder: (context, url, progress) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        if (list[index].discount != 0)
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                '${list[index].price.round()} LE',
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
                              if (list[index].discount != 0)
                                Text(
                                  list[index].oldPrice.round().toString(),
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
                                        .favorites[list[index].id]!
                                    ? primary
                                    : Colors.grey,
                                child: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changeFav(list[index].id);
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
          ),
        ),
      ),
    );
