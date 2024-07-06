import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/main.dart';
import 'package:flutter_application_10/pages/edit_address.dart';
import 'package:flutter_application_10/widgets/my_drawer_widget.dart';
import 'package:flutter_application_10/widgets/show_my_address_widget.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // my list
  List<dynamic> address = [];
  // bool
  bool isLoading = false;
  // init

  String? username;
  void initState() {
    // TODO: implement initState
    super.initState();
    getMYTimeLine();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('My Profile'),
        centerTitle: true,
      ),
      drawer: MYyDrawerWidget(),
      body: ListView(
        children: [
          // image
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 30),
            height: 200,
            child: Image.asset('lib/images/man.png'),
          ),
          // username
          Center(
            child: Text(
              username ?? 'Default Username',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
          ),
          //
          SizedBox(
            height: 20,
          ),
          // divider
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.red,
            ),
          ),

          Container(
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'newaddress');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // icon
                        Icon(
                          CupertinoIcons.home,
                          color: Colors.red,
                        ),
                        //text
                        Text(
                          "  Add New Adress",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    // icon
                    Icon(
                      Icons.add_location,
                      color: Colors.red,
                    )
                  ],
                )),
          ),
          // my Address
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              "My Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          // get my every address
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                itemCount: address.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: ShowMyAddress(
                        firstName: "${address[index]['first_name']}",
                        lastName: "${address[index]['last_name']}",
                        addressLine: "${address[index]['address_line_1']}",
                        city: "${address[index]['city']}",
                        state: "${address[index]['state']}",
                        zip_code: "${address[index]['zip_code'].toString()}",
                        country: "${address[index]['country']}",
                        onTap: () {
                          print("Edit");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAddress(
                                currentAddress: address[index],
                              ),
                            ),
                          );
                        },
                        label: 'Edit',
                        // Delete Button
                        // build var and give value ID

                        onTap2: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // yes delete
                                          TextButton(
                                            onPressed: () async {
                                              var deleteProductResponse =
                                                  await deleteAddress(
                                                      address[index]['id']);
                                              //
                                              if (deleteProductResponse
                                                      .statusCode ==
                                                  200) {
                                                // problem snack bar (context)
                                                final _context =
                                                    MyApp.navKey.currentContext;

                                                if (_context != null) {
                                                  ScaffoldMessenger.of(_context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "The Address deleted successfully"),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                }
                                                await getMYTimeLine();
                                                // faield
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Address deleted successfully"),
                                                ));
                                                await getMYTimeLine();
                                              }
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ), // close
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Close",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                    title: Text("Delete Address"),
                                    contentPadding: EdgeInsets.all(20),
                                    content: Text(
                                      "Are you sure you want to delete this address?",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16),
                                    ),
                                  ));
                        },
                        label2: 'Delete',
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  // see every My address
  Future<void> getMYTimeLine() async {
    //
    setState(() {
      isLoading = true;
    });
    // this Route
    String url = API_URL + 'locations/me/locations';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    var resposne = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (resposne.statusCode == 200) {
      var jsonResponse = jsonDecode(resposne.body);
      setState(() {
        isLoading = false;
        address = jsonResponse['Locations'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // delete my delete function
  Future<Response> deleteAddress(id) async {
    //
    setState(() {
      isLoading = true;
    });
    // this Route
    String url = API_URL + 'locations/delete/${id.toString()}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    var resposne = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    setState(() {
      isLoading = false;
    });

    return resposne;
  }
}
