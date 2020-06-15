import 'package:flutter/material.dart';
import 'package:fashionapp/pages/home_page.dart';
import 'package:fashionapp/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:fashionapp/pages/splash.dart';
import 'package:fashionapp/provider/app_provider.dart';
import 'package:fashionapp/provider/user_provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),
  ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepOrange
        ),
        home: ScreensController(),
      )));
}

// ScreensController returns a particular screen based on the state of the user
class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}