import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/main.dart';
import 'package:flutter_application_10/pages/reviews_page.dart';
import 'package:flutter_application_10/widgets/item_bootom_navbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ItemsPage extends StatefulWidget {
  final Map<String, dynamic> currentAddress;
  const ItemsPage({required this.currentAddress});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  Map<String, dynamic>? currentProduct;
  List<Map<String, dynamic>> orderItems = [];
  double totalPrice = 0.0;

  List<dynamic> products = [];

  bool isLoading = false;
  late int productID;
  var priceP;
  @override
  void initState() {
    super.initState();
    getTimeLine();
  }

  int itemCount = 1;

  void increaseItemCount() {
    setState(() {
      itemCount++;
    });
  }

  void decreaseItemCount() {
    if (itemCount > 1) {
      setState(() {
        itemCount--;
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items Page'),
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (products.isEmpty)
              ? Center(
                  child: Text('No products available'),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    productID = products[index]['id'];
                    priceP = products[index]['price'];
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentProduct = products[index];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: products[index]['image'] != null
                                  ? Image.network(
                                      "${products[index]['image']}",
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Icon(
                                          Icons.error,
                                          size: 200,
                                          color: Colors.red,
                                        );
                                      },
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 200,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          Arc(
                            edge: Edge.TOP,
                            arcType: ArcType.CONVEY,
                            height: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 60, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            direction: Axis.horizontal,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.red,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          Text(
                                            "\$${products[index]['price']}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            products[index]['name'],
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            width: 90,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed:
                                                        decreaseItemCount,
                                                    icon: Icon(
                                                      CupertinoIcons.minus,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    itemCount.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed:
                                                        increaseItemCount,
                                                    icon: Icon(
                                                      CupertinoIcons.plus,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        products[index]['description'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Remaining stock : ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${products[index]['stock']}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Delivery Time : ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Icon(
                                                  CupertinoIcons.clock,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "30 Minutes ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    // Reviws
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "People's opinions : ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewsPage(
                                                          productId: productID),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Icon(
                                                    Icons.reviews_outlined,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  "View all reviews ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.black87),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      bottomNavigationBar: products.isNotEmpty
          ? ItemBottomNAvBar(
              priceTto: products[currentIndex]['price'].toString(),
              ontap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int userId = prefs.getInt('userId') ?? 0;
                if (userId != 0) {
                  try {
                    await createOrder(
                        userId,
                        orderItems,
                        double.parse(products[currentIndex]['price']),
                        'data item');
                    print(userId);
                    print(orderItems);
                    print(totalPrice);

                    final _context = MyApp.navKey.currentContext;
                    if (_context != null) {
                      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
                          content: Text("Order Created Successfully")));
                    }
                  } catch (error) {
                    print('Error : $error');
                  }
                } else {
                  print('User ID not found in SharedPreferences');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User ID not found. Please login again.'),
                    ),
                  );
                }
              },
            )
          : SizedBox.shrink(),
    );
  }

  Future<void> getTimeLine() async {
    setState(() {
      isLoading = true;
    });
    String url = API_URL + 'product/show/${widget.currentAddress['id']}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        products = [jsonResponse['product']];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Response> createOrder(
    int userId,
    List<Map<String, dynamic>> orderItems,
    double totalPrice,
    String deliveryDate,
  ) async {
    setState(() {
      isLoading = true;
    });

    String url = API_URL + 'orders/store';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return Response('Token not found', 400);
    }

    var formattedOrderItems = orderItems.map((item) {
      return {
        'product_id': item['product_id'],
        'quantity': item['quantity'],
        'price': item['price'],
      };
    }).toList();

    var orderData = {
      'total_price': totalPrice,
      'date_of_delivery': deliveryDate,
      'order_items': formattedOrderItems,
    };

    var response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(orderData));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 201) {
      print('Order created successfully');
    } else {
      print('Failed to create order: ${response.body}');
    }

    return response;
  }
}
