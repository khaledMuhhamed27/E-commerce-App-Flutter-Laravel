import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/main.dart';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWishList extends StatefulWidget {
  const MyWishList({Key? key});

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  List<dynamic> wishlist = [];
  List<dynamic> products = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTimeLine();
    getTimeLineP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('My WishLists'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                var item = wishlist[index];
                var product = item['product'];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    width: 380,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Image
                          Image.network(
                            product['image'],
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Product Name
                                Text(
                                  product['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Product Description
                                Text(
                                  product['description'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                // Rating
                                RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 18,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                  onRatingUpdate: (index) {},
                                ),
                                // Product Price
                                Text(
                                  "\$${product['price']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Icons
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Delete From Favorites
                                IconButton(
                                  onPressed: () async {
                                    var deleteProductResponse =
                                        await removeWishlist(
                                            wishlist[index]['id']);
                                    print(product['id']);
                                    if (deleteProductResponse.statusCode ==
                                        200) {
                                      print("OK");
                                      await getTimeLine();
                                      final _context =
                                          MyApp.navKey.currentContext;
                                      if (_context != null) {
                                        ScaffoldMessenger.of(_context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Wishlist item deleted successfully!"),
                                          ),
                                        );
                                        await getTimeLine();
                                      }
                                    } else {
                                      print("Problem");
                                      await getTimeLine();
                                      final _context =
                                          MyApp.navKey.currentContext;
                                      if (_context != null) {
                                        ScaffoldMessenger.of(_context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Failed to delete wishlist item."),
                                          ),
                                        );
                                        await getTimeLine();
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.red,
                                    size: 26,
                                  ),
                                ),

                                // Cart Icon
                                Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.red,
                                  size: 26,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Fetch wishlist items
  Future<void> getTimeLine() async {
    setState(() {
      isLoading = true;
    });

    String url = API_URL + 'wishlists/timeline';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        // Filter wishlist to show only items for the current user
        wishlist = jsonResponse['wishlists']
            .where((item) => item['user_id'] == prefs.getInt('userId'))
            .toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // delete from wishlist
  Future<Response> removeWishlist(id) async {
    setState(() {
      isLoading = true;
    });
    String url = API_URL + 'wishlists/delete/${id.toString()}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var resposne = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    setState(() {
      isLoading = false;
    });
    return resposne;
  }

  // see every products
  Future<void> getTimeLineP() async {
    //
    setState(() {
      isLoading = true;
    });
    // this Route
    String url = API_URL + 'product/timeline';
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
        products = jsonResponse['products'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
