import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/authentication.dart';
import 'package:webrtc_conference/main.dart';


part 'home/contact.dart';
part 'home/information.dart';
part 'home/feed.dart';
part 'home/profile.dart';
part 'home/search.dart';

enum HomeTabValue { contact, information, feed, search, profile }
extension HomeTabValueExtension on HomeTabValue {
  Widget get screen {
    switch (this) {
      case HomeTabValue.contact:
        return HomeContact();
      case HomeTabValue.information:
        return HomeInformation();
      case HomeTabValue.feed:
        return HomeFeed();
      case HomeTabValue.search:
        return HomeSearch();
      case HomeTabValue.profile:
        return HomeProfile();
    }
  }
}

class HomeScreen extends StatefulWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/home',
      builder: (_) => this,
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = HomeTabValue.feed.index;

  List<Widget> tabs = [
    HomeTabValue.contact.screen,
    HomeTabValue.information.screen,
    HomeTabValue.feed.screen,
    HomeTabValue.search.screen,
    HomeTabValue.profile.screen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80))),
            actions: <Widget>[
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.notifications_outlined))
            ],
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.cyan),
            centerTitle: true,
            title: Image.asset(
              'assets/images/ADSD_Logo_small.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.pngall.com/wp-content/uploads/2016/05/Man-Download-PNG.png'),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  accountName: Text(
                    'jon jon',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  accountEmail: Text(
                    'umail@mail.ru',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text('Home'),
                leading: const Icon(Icons.home),
                onTap: () {
                  navigator?.pop();
                  goToTab(HomeTabValue.feed);
                },
              ),
              ListTile(
                title: Text('Profile'),
                leading: const Icon(Icons.person),
                onTap: () {
                  navigator?.pop();
                  goToTab(HomeTabValue.profile);
                },
              ),
              ListTile(
                title: Text('About us'),
                leading: const Icon(Icons.info),
                onTap: () {
                  navigator?.pop();
                  goToTab(HomeTabValue.information);
                },
              ),
              ListTile(
                title: Text('Contact us'),
                leading: const Icon(Icons.phone),
                onTap: () {
                  navigator?.pop();
                  goToTab(HomeTabValue.contact);
                },
              ),
              ListTile(
                title: Text('Log out'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  context.read<AuthenticationCubit>().requestLogout();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(color: Colors.cyan, size: 30),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              label: 'Mail',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Info',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_off_outlined),
              label: 'Search',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color.fromRGBO(84, 116, 129, 1),
            )
          ],
          onTap: (int index) {
            this.onTapHandler(index);
          },
          currentIndex: pageIndex,
          selectedItemColor: Colors.cyan,
        ),
        body: tabs[pageIndex]);
  }

  void goToTab(HomeTabValue tab) {
    onTapHandler(tab.index);
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.pageIndex = index;
    });
  }
}
