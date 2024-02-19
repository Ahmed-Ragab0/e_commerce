import 'package:e_commerce/cubit/login_cubit/login_cubit.dart';
import 'package:e_commerce/cubit/login_cubit/login_states.dart';
import 'package:e_commerce/modules/search_screen/search_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginCubit>(context);
        return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: const Text(
                'MISR STORE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                tabBackgroundGradient: LinearGradient(colors: [
                  primary,
                  Colors.deepPurple[200]!,
                ]),
                haptic: true,
                tabBorderRadius: 15,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black54, // navigation bar padding
                tabs: cubit.gItems,
                onTabChange: (value) {
                  cubit.changeBottomNavBar(value);
                },
                selectedIndex: cubit.currentIndex,
              ),
            ));
      },
    );
  }
}
