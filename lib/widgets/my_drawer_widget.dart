import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MYyDrawerWidget extends StatefulWidget {
  const MYyDrawerWidget({super.key});

  @override
  State<MYyDrawerWidget> createState() => _MYyDrawerWidgetState();
}

class _MYyDrawerWidgetState extends State<MYyDrawerWidget> {
  String? username;
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name');
      print(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User Name And Icon
          Container(
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
                child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 80,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.home,
                    size: 40,
                    color: Colors.white,
                  )),
            )),
          ),
          // listtt
          // 1
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.red,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'profile');
              },
              leading: Icon(
                CupertinoIcons.person,
                color: Colors.red,
              ),
              title: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'myorders');
              },
              leading: Icon(
                CupertinoIcons.cart_fill,
                color: Colors.red,
              ),
              title: Text(
                "My Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'wishlist');
              },
              leading: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              ),
              title: Text(
                "My Wish List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),

          // logout user
          ListTile(
              onTap: () async {
                Response response = await logoutUser();
                if (response.statusCode == 200) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                }
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }

  // logout user function
  Future<Response> logoutUser() async {
    String url = API_URL + 'logout';

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token')!;

    print(token);

    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    return response;
  }
}
