import 'package:flutter/material.dart';
import 'package:flutter_application_10/pages/cart_page.dart';
import 'package:flutter_application_10/pages/home_page.dart';
import 'package:flutter_application_10/pages/intro_page.dart';
import 'package:flutter_application_10/pages/login_page.dart';
import 'package:flutter_application_10/pages/my_orders_page.dart';
import 'package:flutter_application_10/pages/new_address.dart';
import 'package:flutter_application_10/pages/ny_wish_list.dart';
import 'package:flutter_application_10/pages/profile_page.dart';
import 'package:flutter_application_10/pages/regster.dart';
import 'package:flutter_application_10/providers/home_provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedin = prefs.getBool('is_loggedin') ?? false;
  print(isLoggedin);
  runApp(
    MultiProvider(
      child: Phoenix(
        child: MyApp(isLoggedin),
      ),
      providers: [
        // home page provider
        ChangeNotifierProvider(
            create: (_) => HomeProvider()..loadInitialData()),
        // item page provider
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedin;
  MyApp(this.isLoggedin);

  // global key for SnackBar Problem
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khaled Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: Color(0xFFF5F5F3),
        useMaterial3: true,
      ),
      navigatorKey: navKey,
      home: isLoggedin ? HomePage() : IntroPage(),
      routes: {
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'home': (context) => HomePage(),
        'cart': (context) => CartPage(),
        'profile': (context) => ProfilePage(),
        'newaddress': (context) => AddNewAddress(),
        'wishlist': (context) => MyWishList(),
        'myorders': (context) => OrderScreen(),
        'rev': (context) => HomePage(),
      },
    );
  }
}
