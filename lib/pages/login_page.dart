import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/auth/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  // 1 Email Controller
  TextEditingController emailController = TextEditingController();
  // 2 Password Controller
  TextEditingController passwordController = TextEditingController();
  // Variables
  // 1 Token VAR
  String? token;
  // 2 Loding VAR
  bool isLoading = false;
  // 3 messaging
  // Keys
  // 1 Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool fobstc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('Login Screen'),
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
                    // sizedbox
                    SizedBox(
                      height: 20,
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
                    // login button// زر تسجيل الدخول

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        minWidth: double.infinity,
                        color: Colors.red,
                        onPressed: () async {
                          // التحقق من الاتصال بالإنترنت
                          if (!await checkInternetConnection()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please check your internet connection.'),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          // التحقق من صحة الحقول
                          if (formKey.currentState!.validate()) {
                            try {
                              final response = await loginUser(
                                emailController.text,
                                passwordController.text,
                              );

                              final jsonResponse = jsonDecode(response.body);

                              if (response.statusCode == 200) {
                                // حفظ بيانات الجلسة المسترجعة
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('token', jsonResponse['token']);
                                prefs.setString('name', jsonResponse['name']);
                                prefs.setBool('is_loggedin', true);
                                prefs.getInt('userId');
                                print(prefs.getInt('USERID : userId'));
                                // توجيه المستخدم إلى الصفحة الرئيسية
                                Navigator.pushReplacementNamed(context, 'home');

                                // مسح بيانات الحقول
                                emailController.clear();
                                passwordController.clear();
                              } else {
                                // التعامل مع الأخطاء في حالة فشل تسجيل الدخول
                                final errorMessage = transformErrors(
                                  jsonResponse['errors'],
                                  emailNotFound: jsonResponse
                                          .containsKey('email_not_found')
                                      ? jsonResponse['email_not_found']
                                      : false,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: errorMessage,
                                  ),
                                );
                              }
                            } catch (error) {
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // text button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Don't Have Account Go To ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            "REGISTER",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // get Token function
  Future<void> getToken() async {
    String? fcm_token;
    setState(() {
      token = fcm_token;
    });
    print('Token : $token');
  }

  // login user function
  Future<Response> loginUser(
    String email,
    String password,
  ) async {
    String url = API_URL + 'login';

    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'fcm_token': token,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

    return response;
  }

  // دالة للتحقق من اتصال الإنترنت
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
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

  Padding my_image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/user.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // Function to check if a given string represents a valid email address
  bool _isValidEmail(String email) {
    // Regular expression for validating email addresses
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
