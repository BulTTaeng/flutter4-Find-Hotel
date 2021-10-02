
import 'package:Shrine/detail.dart';
import 'package:Shrine/favorite_Hotel.dart';
import 'package:Shrine/signup.dart';
import 'package:flutter/material.dart';


import 'home.dart';
import 'login.dart';
import 'mypage.dart';
import 'signup.dart';
import 'search.dart';



// TODO: Convert ShrineApp to stateful widget (104)
class midApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home: HomePage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/login') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true,
      );
    }
    else if (settings.name == '/signup') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => SignupPage(),
        fullscreenDialog: true,
      );
    }
    else if (settings.name == '/favorite') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => FavoritePage(),
        fullscreenDialog: true,
      );
    }
    else if (settings.name == '/search') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => SearchPage(),
        fullscreenDialog: true,
      );
    }
    else if (settings.name == '/mypage') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => MyPage(),
        fullscreenDialog: true,
      );
    }




    else {
      return null;
    }


  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)
