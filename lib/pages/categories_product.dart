import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProductScreen extends StatefulWidget {
  final Map<String, dynamic> category;
  CategoryProductScreen(this.category);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  // my list
  List<dynamic> products = [];
  // bool
  bool isLoading = false;
  // init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        centerTitle: true,
        title: Text(
          "${widget.category['name']}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: (isLoading == false && products.length == 0)
          ? Center(
              child: Text("No Products available"),
            )
          : (isLoading == true)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 16,
                        left: 16,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // product image
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.all(12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: products[index]['image'] != null
                                      ? Image.network(
                                          "${products[index]['image']}",
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Icon(
                                              Icons.error,
                                              size: 100,
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
                              SizedBox(
                                height: 12,
                              ),
                              // product name
                              Text(
                                products[index]['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              // product description
                              Text(
                                products[index]['description'],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // product stock
                                    Text(
                                        " Stock : ${products[index]['stock'].toString()}"),

                                    // product name user
                                    Text(
                                        "Advertiser : ${products[index]['user']['name']}"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // price + add to sale
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // product price
                                Text("${products[index]['price']} \$"),
                                // add button
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.red,
                                  ),
                                  child: IconButton(
                                      onPressed: () {}, icon: Icon(Icons.add)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  // see every category products
  Future<void> getCategoryProducts() async {
    //
    setState(() {
      isLoading = true;
    });
    // this Route
    String url = API_URL + 'category/' + widget.category['id'].toString();
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
        products = jsonResponse['category']['products'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
