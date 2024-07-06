import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  List<dynamic> products = [];
  List<dynamic> categories = [];
  bool isLoading = false;

  HomeProvider() {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    setLoading(true);
    await getTimeLine();
    await getCategories();
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getTimeLine() async {
    String url = API_URL + 'product/timeline';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      products = jsonDecode(response.body)['products'];
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    String url = API_URL + 'categories';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      categories = jsonDecode(response.body)['categories'];
      notifyListeners();
    }
  }

  Future<void> addToWishlist(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    if (userId != 0) {
      String url = API_URL + 'wishlists/store';
      String token = prefs.getString('token')!;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'user_id': userId, 'product_id': productId}),
      );

      if (response.statusCode == 200) {
        final context = MyApp.navKey.currentContext;
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("The Added Favorite Successfully")),
          );
        }
      } else {
        print('Error adding to wishlist');
      }
    } else {
      print('User ID not found in SharedPreferences');
      ScaffoldMessenger.of(MyApp.navKey.currentContext!).showSnackBar(
        SnackBar(content: Text('User ID not found. Please login again.')),
      );
    }
  }
}
