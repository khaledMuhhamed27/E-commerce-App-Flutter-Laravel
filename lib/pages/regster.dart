import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/auth/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool fobstc = true;

  // Controllers
  // 1 Name Controller
  TextEditingController nameController = TextEditingController();
  // 2 Email Controller
  TextEditingController emailController = TextEditingController();
  // 3 Password Controller
  TextEditingController passwordController = TextEditingController();
  // Variables
  // 1 Token VAR
  String? token;
  // 2 Loding VAR
  bool isLoading = false;
  // Keys
  // 1 Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // inistial state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('Register Screen'),
        centerTitle: true,
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // sizedbox
                    SizedBox(
                      height: 20,
                    ),
                    my_image(),
                    SizedBox(
                      height: 20,
                    ),
                    // name input
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5f3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            // Enabled Border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffc5c5c5), width: 2.0),
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
                              return ' Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    // email input
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5f3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            // Enabled Border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffc5c5c5), width: 2.0),
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
                              return 'Email is required';
                            }

                            // Check if the value is a valid email address
                            if (!_isValidEmail(value)) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    // password input
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5f3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          obscureText: fobstc,
                          obscuringCharacter: '●',
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: togglePassword(),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            // Enabled Border
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffc5c5c5), width: 2.0),
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
                              return 'Password is required';
                            }

                            // Check if the password has at least eight characters
                            if (value.length < 8) {
                              return 'Password must be at least eight characters long';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    // register button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          minWidth: double.infinity,
                          color: Colors.red,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            // التحقق من صحة الحقول
                            if (formKey.currentState!.validate()) {
                              try {
                                final response = await registerUser(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                );

                                final jsonResponse = jsonDecode(response.body);

                                if (response.statusCode == 200) {
                                  // حفظ بيانات الجلسة المسترجعة
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setInt(
                                      'userId', jsonResponse['user']['id']);
                                  // عرض رسالة نجاح التسجيل ومسح البيانات المدخلة
                                  print(jsonResponse['user']['id']);
                                  print('User Registered successfully');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(jsonResponse['message']),
                                    ),
                                  );
                                  nameController.clear();
                                  emailController.clear();
                                  passwordController.clear();
                                } else {
                                  // التعامل مع الأخطاء في حالة فشل التسجيل
                                  print('Failed to register user');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: transformErrors(
                                          jsonResponse['errors']),
                                    ),
                                  );
                                }
                              } catch (error) {
                                // التعامل مع الأخطاء الغير متوقعة
                                print('Error: $error');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'An error occurred. Please try again later.'),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  // firebase messaging function

  // get Token function
  Future<void> getToken() async {
    String? fcm_token;
    setState(() {
      token = fcm_token;
    });
    print('Token : $token');
  }

  // register user function
  Future<Response> registerUser(
    String name,
    String email,
    String password,
  ) async {
    // this Route
    String url = API_URL + 'register';

    var resposne = await http.post(Uri.parse(url),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    return resposne;
  }

  Padding my_image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/pen.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // toggle password
  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            fobstc = !fobstc;
          });
        },
        icon: fobstc
            ? Icon(
                Icons.visibility_off,
                size: 26,
                color: Colors.black54,
              )
            : Icon(
                Icons.visibility,
                size: 26,
                color: Colors.black54,
              ));
  }

  // Function to check if a given string represents a valid email address
  bool _isValidEmail(String email) {
    // Regular expression for validating email addresses
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
