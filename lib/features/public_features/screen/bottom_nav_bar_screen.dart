import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeupflutter/features/category_features/screen/category_screen.dart';
import 'package:makeupflutter/features/home_features/screen/home_screen.dart';
import 'package:makeupflutter/features/public_features/logic/bottom_nav_cubit.dart';

import '../../../config/app_config/app_color/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});
  static const String screenId = '/bottomNavBar';

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget>screenList = [
    HomeScreen(),
    CategoryScreen(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit , int>(builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'peyda',
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'peyda',
          ),
          items: [
            BottomNavigationBarItem(
              label: 'خانه',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'دسته بندی ها',
              icon: Icon(Icons.category_outlined),
              activeIcon: Icon(Icons.category),
            ),
            BottomNavigationBarItem(
              label: 'علاقه مندی ها',
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: 'حساب کاربری',
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
            ),
          ],
          currentIndex: BlocProvider.of<BottomNavCubit>(context).currentIndex,
          onTap: (value) {
            BlocProvider.of<BottomNavCubit>(context).changeIndex(value);
          },
        ),
        body: screenList.elementAt(
          BlocProvider.of<BottomNavCubit>(context).currentIndex,
        ),
      );
    },);
  }
}
