import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:handywork0/homepagematerial/settings.dart';
import 'package:handywork0/profile/myprofile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../allconvertthings/getalljobs.dart';
import '../allconvertthings/getownjobs.dart';
import '../main.dart';
import '../addjob/addjobs.dart';
import '../myoffers/myoffers.dart';
import 'myjobs/myjobspage.dart';
import '../brosepage/browsepage.dart';

PersistentTabController homepagebarcontroller = PersistentTabController(initialIndex: 1);
class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
  List<Widget> homepagebarlist() {
    return [
      myoffers(),
      Browsepage(),
      addjob(),
      myjobspage(),
      Myprofile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.local_offer),
        inactiveIcon: Icon(
          Icons.local_offer_outlined,
          color: Colors.black,
        ),
        title: ("My Offers"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.public),
        inactiveIcon: Icon(
          Icons.public_outlined,
          color: Colors.black87,
        ),
        title: ("Browse"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        inactiveIcon: Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
        title: ("Add Request"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.handyman),
        inactiveIcon: Icon(
          Icons.handyman_outlined,
          color: Colors.black,
        ),
        title: ("My jobs"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        inactiveIcon: Icon(
          Icons.person_outline,
          color: Colors.black,
        ),
        title: ("Profile"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  return PersistentTabView(
    context,
    controller: homepagebarcontroller,
    screens: homepagebarlist(),
    items: _navBarsItems(),
    confineInSafeArea: true,
    backgroundColor: Colors.white, // Default is Colors.white.
    handleAndroidBackButtonPress: true, // Default is true.
    resizeToAvoidBottomInset:
    true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    stateManagement: true, // Default is true.
    hideNavigationBarWhenKeyboardShows:
    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(10.0),
      colorBehindNavBar: Colors.white,
    ),
    popAllScreensOnTapOfSelectedTab: true,
    popActionScreens: PopActionScreensType.all,
    itemAnimationProperties: const ItemAnimationProperties(
      // Navigation Bar's items animation properties.
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    ),
    screenTransitionAnimation: const ScreenTransitionAnimation(
      // Screen transition animation on change of selected tab.
      animateTabTransition: true,
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
    ),
    navBarStyle:
    NavBarStyle.style15, // Choose the nav bar style with this property.
  );
}

}
class screen1 extends StatelessWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Offers',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

