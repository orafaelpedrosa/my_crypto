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
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Theme.of(context).colorScheme.secondary.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 5,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              color: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).colorScheme.background,
              tabs: [
                GButton(
                  icon: Icons.home,
                ),
                GButton(
                  icon: Icons.star,
                ),
                GButton(
                  icon: Icons.wallet,
                ),
                GButton(
                  icon: Icons.person,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  if (index == 0) {
                    Modular.to.pushNamedAndRemoveUntil(
                        '/home/cryptocurrency/', (route) => false);
                  } else if (index == 1) {
                    Modular.to.pushNamedAndRemoveUntil(
                        '/home/favorites/', (route) => false);
                  } else if (index == 2) {
                    Modular.to.pushNamedAndRemoveUntil(
                        '/home/wallet/', (route) => false);
                  } else if (index == 3) {
                    Modular.to.pushNamedAndRemoveUntil(
                        '/home/profile/', (route) => false);
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
