import 'package:e_commerce/models/sign_in_model.dart';

class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final SignInModel? signInModel;
  LoginSuccessState(this.signInModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class ChangePasswordIconState extends LoginStates {}

class ChangeBottomNavState extends LoginStates {}

class HomeDataLoadingState extends LoginStates {}

class HomeDataSuccessState extends LoginStates {}

class HomeDataErrorState extends LoginStates {}

class CategoriesLoadingState extends LoginStates {}

class CategoriesSuccessState extends LoginStates {}

class CategoriesErrorState extends LoginStates {}

class ChangeFavSuccessState extends LoginStates {}

class ChangeFavErrorState extends LoginStates {}

class GetFavLoadingState extends LoginStates {}

class GetFavSuccessState extends LoginStates {}

class GetFavErrorState extends LoginStates {}

class GetCatProductLoadingState extends LoginStates {}

class GetCatProductSuccessState extends LoginStates {}

class GetCatProductErrorState extends LoginStates {}

class GetProductDetailsLoadingState extends LoginStates {}

class GetProductDetailsSuccessState extends LoginStates {}

class GetProductDetailsErrorState extends LoginStates {}

class GetProfileLoadingState extends LoginStates {}

class GetProfileSuccessState extends LoginStates {
  final SignInModel? userModel;
  GetProfileSuccessState(this.userModel);
}

class GetProfileErrorState extends LoginStates {}

class UpdateDataLoadingState extends LoginStates {}

class UpdateDataSuccessState extends LoginStates {}

class UpdateDataErrorState extends LoginStates {}
