import 'package:e_commerce/bloc_observer.dart';
import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/layout/home_layout.dart';
import 'package:e_commerce/modules/login/login_screen.dart';
import 'package:e_commerce/modules/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce/network/remote/dio_helper.dart';
import 'package:e_commerce/network/local/cach_helper.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  var onBoard = CachHelper.getData(key: 'onBoard');
  token = CachHelper.getData(key: 'token');

  Widget widget;

  if (onBoard != null) {
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(ECommerceApp(
    widget: widget,
  ));
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()
            ..getHomeData()
            ..getCategories()
            ..getFav(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
