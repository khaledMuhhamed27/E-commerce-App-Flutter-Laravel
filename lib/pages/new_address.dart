import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/auth/onehelpers.dart';
import 'package:flutter_application_10/main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  // Controllers
  // 1 first name
  TextEditingController firstnameController = TextEditingController();
  // 2 last name
  TextEditingController lastnameController = TextEditingController();
  // 3 address_line
  TextEditingController addresslineController = TextEditingController();
  // 4 city
  TextEditingController cityController = TextEditingController();
  // 5 state
  TextEditingController stateController = TextEditingController();
  // 6 zip_code
  TextEditingController zipCodeController = TextEditingController();
  // 7 country
  TextEditingController countryController = TextEditingController();
  String? token;
  // 2 Loding VAR
  bool isLoading = false;
  // Keys
  // 1 Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('Add Adress'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // firstname
              // sizedbox
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'firstname is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),
              // 2 last name
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Last Name is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),
              // 3 address_line_1
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: addresslineController,
                    decoration: InputDecoration(
                      labelText: 'Address Line',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address Line is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),
              // 4 city
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The City is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),
              // 5 state
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'State is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),
              // 6 zip_code
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: zipCodeController,
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType
                        .number, // تعيين نوع لوحة المفاتيح إلى الأرقام فقط
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Zip Code is required';
                      }
                      // Check if the value is a valid email address
                      return null;
                    },
                  ),
                ),
              ),

              // 7 country
              // sizedbox
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5f3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      // Enabled Border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffc5c5c5), width: 2.0),
                      ),
                      // Focused Border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      // Erorr Border
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      //Focused  Erorr Border
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The Country is required';
                      }

                      // Check if the value is a valid email address

                      return null;
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  minWidth: double.infinity,
                  color: Colors.red,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      await CreateAdress().then((response) {
                        setState(() {
                          isLoading = false;
                        });

                        var jsonResponse = json.decode(response.body);

                        final _context = MyApp.navKey.currentContext;

                        if (response.statusCode == 200) {
                          if (_context != null) {
                            ScaffoldMessenger.of(_context)
                                .showSnackBar(SnackBar(
                                    content: Text(transformErrors(
                              jsonResponse.containsKey("errors")
                                  ? jsonResponse['errors']
                                  : {},
                              singleError: jsonResponse.containsKey("message")
                                  ? jsonResponse['message']
                                  : "",
                            ))));
                            firstnameController.clear();
                            lastnameController.clear();
                            addresslineController.clear();
                            cityController.clear();
                            stateController.clear();
                            zipCodeController.clear();
                            countryController.clear();
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'profile', (route) => false);
                          }
                        } else {
                          if (_context != null) {
                            ScaffoldMessenger.of(_context)
                                .showSnackBar(SnackBar(
                                    content: Text(transformErrors(
                              jsonResponse.containsKey("errors")
                                  ? jsonResponse['errors']
                                  : {},
                              singleError: jsonResponse.containsKey("message")
                                  ? jsonResponse['message']
                                  : "",
                            ))));
                          }
                        }
                      });
                    }
                  },
                  child: Text(
                    "Create Address",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // CREATE NEW ADDRESS
  Future<Response> CreateAdress() async {
    setState(() {
      isLoading = true;
    });

    String url = API_URL + 'locations/store';

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token')!;

    print(token);

    var response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'first_name': firstnameController.text,
          'last_name': lastnameController.text,
          'address_line_1': addresslineController.text,
          'city': cityController.text,
          'state': stateController.text,
          'zip_code': zipCodeController.text.toString(),
          'country': countryController.text
        }));

    return response;
  }
}
