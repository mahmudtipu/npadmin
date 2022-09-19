import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:npadmin/screens/body.dart';
import 'package:npadmin/screens/payment/payment.dart';
import 'package:npadmin/screens/settings/settings.dart';
import 'package:npadmin/screens/shop/shop.dart';

import 'leaderboard/leaderboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SettingsScreen();
              },
            )
        );
      }
      else if (_selectedIndex == 1)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ShopScreen();
              },
            )
        );
      }
      else if (_selectedIndex == 2)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentScreen();
              },
            )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.blueGrey,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.blueGrey))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          //backgroundColor: Colors.black54,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.blueGrey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/shop.png'),
                color: Colors.blueGrey,
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment,color: Colors.orange,),
              label: 'Payment',
            ),
          ],
        ),
      ),
    );
  }
}
