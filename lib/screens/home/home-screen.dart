import 'package:animal_app/constants/constant_colors.dart';
import 'package:animal_app/constants/constant_sizes.dart';
import 'package:animal_app/enum/icons.dart';
import 'package:animal_app/extention/extetion.dart';
import 'package:animal_app/generated/l10n.dart';
import 'package:animal_app/screens/home/home-cubit.dart';
import 'package:animal_app/screens/home/home-state.dart';
import 'package:animal_app/screens/login/login-cubit.dart';
import 'package:animal_app/screens/my_profile/my-profile-cubit.dart';
import 'package:animal_app/screens/my_profile/my-profile-screen.dart';
import 'package:animal_app/screens/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.request_page_outlined),
        label: S.of(context).requests,
      ),
      BottomNavigationBarItem(
        label: '',
        icon: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 3))
            ],
            shape: BoxShape.circle,
            color: Color(0xff539DF3),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.search_rounded),
        label: S.of(context).discover,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.watch_later_outlined),
        label: S.of(context).more,
      ),
    ];
    final cubit = BlocProvider.of<HomeCubit>(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  cubit.changeSearchBar();
                },
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  cubit.getNotifications();
                  Navigator.pushNamed(context, NotificationsScreen.id);
                },
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                )),
          ],
          leading: InkWell(
              onTap: () {
                BlocProvider.of<MyProfileCubit>(context).getMyProfile();
                Navigator.pushNamed(context, MyProfileScreen.id);

              },
              child: ThemeImageIconWidget(
                ThemeImageIcon.person,
              )),
        ),
        backgroundColor: KDefaultColor,
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: KDefaultColor,
          unselectedItemColor: KUnselectedColor,
          onTap: (index) {
            cubit.ChangeBottomNavBar(index);
          },
          items: bottomNavItems,
          currentIndex: cubit.currentNavIndex,
        ),
        body: Container(
          constraints: BoxConstraints(
            minHeight: AppSizes.getScreenHeight(context),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          width: AppSizes.getScreenWidth(context),
          child: SingleChildScrollView(

            child: Column(
              children: [
                cubit.layouts[cubit.currentNavIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
