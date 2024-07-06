import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/pages/items_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  final String searchResults;

  const SearchPage({Key? key, required this.searchResults}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> searchResults = [];
  bool isLoading = false;
  // my list for products
  List<dynamic> products = [];
  @override
  void initState() {
    super.initState();
    getTimeLine();
    searchProducts(widget.searchResults.isNotEmpty ? widget.searchResults : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : searchResults.isEmpty
                ? Text('No results found!')
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final product = searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          print("go to items page");
                          print(products[index]['id']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemsPage(currentAddress: product),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Delete From Favorites

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
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Future<void> searchProducts(String query) async {
    setState(() {
      isLoading = true;
    });

    String url = API_URL + 'product/search/$query';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        searchResults = jsonResponse;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  // see every products
  Future<void> getTimeLine() async {
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
        products = jsonResponse['products'];
      });
    } else {
      // handle error
    }
    setState(() {
      isLoading = false;
    });
  }
}
