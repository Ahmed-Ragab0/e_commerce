import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/models/change_favorite_model.dart';
import 'package:e_commerce/models/favorites_data_model.dart';
import 'package:e_commerce/models/sign_in_model.dart';
import 'package:e_commerce/models/home_model.dart';
import 'package:e_commerce/modules/category_screen/category_screen.dart';
import 'package:e_commerce/modules/favorite_screen/favorite_screen.dart';
import 'package:e_commerce/modules/home_screen/home_screen.dart';
import 'package:e_commerce/modules/setting_screen/settings_screen.dart';
import 'package:e_commerce/network/remote/dio_helper.dart';
import 'package:e_commerce/network/end_point.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

//بعمل اوبجكت من الكيوبت علشان استخدمه ف اي مكان
  static LoginCubit get(context) => BlocProvider.of(context);

  SignInModel? signInModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: lOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      //print(value!.data['message']);
      signInModel = SignInModel.fromJson(value?.data);
      //print(dataModel!.message);
      emit(LoginSuccessState(signInModel!));
    }).catchError((error) {
      emit(
        LoginErrorState(
          error.toString(),
        ),
      );
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility;
  bool isSecure = true;
  void changePasswordIcon() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordIconState());
  }

  List<Widget> screens = const [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category_rounded),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<GButton> gItems = const [
    GButton(
      icon: Icons.home_rounded,
      text: 'Home',
    ),
    GButton(
      icon: Icons.category_rounded,
      text: 'Categories',
    ),
    GButton(
      icon: Icons.favorite_rounded,
      text: 'Favorites',
    ),
    GButton(
      icon: Icons.settings,
      text: 'Settings',
    )
  ];

  int currentIndex = 0;
  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value!.data);
      // print(homeModel!.status);
      // print(homeModel!.data!.banners![0].id);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFav!,
        });
      });

      print(favorites.toString());

      emit(HomeDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(HomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;
  void getCategories() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: getCategory).then(
      (value) {
        categoryModel = CategoryModel.fromJson(value!.data);
        print(categoryModel!.status);
        print(categoryModel!.data!.data[0].id);
        emit(CategoriesSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(CategoriesErrorState());
      },
    );
  }

  FavoritesModel? favoritesModel;

  void changeFav(pId) {
    favorites[pId] = !favorites[pId]!;
    emit(ChangeFavSuccessState());

    DioHelper.postData(
      url: fav,
      data: {
        'product_id': pId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value!.data);
      print(favoritesModel!.message);

      if (!favoritesModel!.status!) {
        favorites[pId] = !favorites[pId]!;
      } else {
        getFav();
      }
      emit(ChangeFavSuccessState());
    }).catchError((error) {
      print(error);
      favorites[pId] = !favorites[pId]!;
      emit(ChangeFavErrorState());
    });
  }

  FavoriteDataModel? favoriteDataModel;
  void getFav() {
    emit(GetFavLoadingState());

    DioHelper.getData(
      url: fav,
      token: token,
    ).then(
      (value) {
        favoriteDataModel = FavoriteDataModel.fromJson(value!.data);
        print(favoriteDataModel!.status);

        emit(GetFavSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(GetFavErrorState());
      },
    );
  }
}
