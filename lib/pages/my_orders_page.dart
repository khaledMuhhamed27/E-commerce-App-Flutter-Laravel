import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/widgets/my_drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = false;
  List<dynamic> orders = [];
  Map<String, dynamic> orderDetails = {};

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MYyDrawerWidget(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : orders.isNotEmpty
              ? ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          print("delete");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text('Order #${orders[index]['id']}'),
                      subtitle: Text('Status: ${orders[index]['status']}'),
                      trailing: Text('Total: ${orders[index]['total']}'),
                      onTap: () async {
                        await viewOrderDetails(orders[index]['id']);
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Order Details'),
                                  Divider(),
                                  Text('Status: ${orderDetails['status']}'),
                                  Text('Total: ${orderDetails['total']}'),
                                  Text('Items:'),
                                  orderDetails['order_details'] != null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              orderDetails['order_details']
                                                  .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Text(
                                                  'Product ID: ${orderDetails['order_details'][index]['product_id']}'),
                                              subtitle: Text(
                                                  'Quantity: ${orderDetails['order_details'][index]['quantity']}'),
                                            );
                                          },
                                        )
                                      : Text('No items found'),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: Text('No orders found'),
                ),
    );
  }

  Future<void> getOrders() async {
    setState(() {
      isLoading = true;
    });

    String url = API_URL + 'orders/my/timeline';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token: $token');

    if (token == null) {
      setState(() {
        isLoading = false;
      });
      print('Token is null');
      return;
    }

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          orders = jsonResponse['orders'] ?? [];
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load orders');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching orders: $error');
    }
  }

  Future<void> viewOrderDetails(int orderId) async {
    String url = API_URL + 'orders/show/$orderId';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Token is null');
      return;
    }

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      print('Order details response status: ${response.statusCode}');
      print('Order details response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse != null &&
            jsonResponse is Map &&
            jsonResponse.isNotEmpty) {
          setState(() {
            orderDetails = jsonResponse.cast<String, dynamic>();
          });
          print('Order details: $orderDetails');
        } else {
          print('Invalid response or empty data');
        }
      } else {
        print('Failed to load order details');
      }
    } catch (error) {
      print('Error fetching order details: $error');
    }
  }
}
