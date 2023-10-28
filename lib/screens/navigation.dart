import 'package:congobonmarche/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: const Text(' ',),
        backgroundColor: colorPrimary,
      ),
      drawer: Drawer(
        backgroundColor: colorPrimary,
        child: ListView(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text('HOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/HomeScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.map,
                color: Colors.white,
              ),
              title: const Text('CATEGORIES',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/CategoryScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_circle_up,
                color: Colors.white,
              ),
              title: const Text('SUB CATEGORY',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/SubcategoryScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.add_circle_sharp,
                color: Colors.white,
              ),
              title: const Text('ADS (BOUTIQUES)',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                // Navigator.pushReplacementNamed(context, "/CreateAds");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: const Text('CREATE ADS',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/CreateAds");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: const Text('MY ACCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/AccountScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: const Text('NOTIFICATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                //  Navigator.pushReplacementNamed(context, "/AccountScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              title: const Text('LOG IN',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/loginAll");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text('LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                //  Navigator.pushReplacementNamed(context, "/logoutScreen");
              },
            ),
            Divider(
              color: new Color(0xffffffff),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: const [
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
