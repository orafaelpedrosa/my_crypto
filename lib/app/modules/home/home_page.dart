import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Modular.to.pushNamed('/home/cryptocurrency/');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return Scaffold(
      body: RouterOutlet(),
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
                setState(() {
                  if (index == 0) {
                    Modular.to.pushReplacementNamed('/home/cryptocurrency/');
                  } else if (index == 1) {
                    Modular.to.pushReplacementNamed('/home/favorites/');
                  } else if (index == 2) {
                    Modular.to.pushReplacementNamed('/home/wallet/');
                  } else if (index == 3) {
                    Modular.to.pushReplacementNamed('/home/profile/');
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
