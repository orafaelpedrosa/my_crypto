import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  PageController _pageController = PageController();
  LoginStore _loginStore = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Center(
            child: Text(
              'Home',
              style: optionStyle,
            ),
          ),
          Center(
            child: Text(
              'Likes',
              style: optionStyle,
            ),
          ),
          Center(
            child: Text(
              'Search',
              style: optionStyle,
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: optionStyle,
                ),
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    _loginStore.authLogout();
                    Modular.to.pushReplacementNamed('/login/');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Theme.of(context).primaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.grey[700]!,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  style: GnavStyle.oldSchool,
                  textStyle: Theme.of(context).textTheme.headline6!,
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favoritas',
                  textStyle: Theme.of(context).textTheme.headline6!,
                ),
                GButton(
                  icon: Icons.wallet,
                  text: 'Carteira',
                  textStyle: Theme.of(context).textTheme.headline6!,
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Perfil',
                  textStyle: Theme.of(context).textTheme.headline6!,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                log('index: $index');
                setState(() {
                  _selectedIndex = index;
                });
                switch (index) {
                  case 0:
                    _pageController.jumpToPage(0);
                    break;
                  case 1:
                    _pageController.jumpToPage(1);
                    break;
                  case 2:
                    _pageController.jumpToPage(2);
                    break;
                  case 3:
                    _pageController.jumpToPage(3);
                    break;

                  default:
                    _pageController.jumpToPage(0);
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
