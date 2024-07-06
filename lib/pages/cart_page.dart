import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/widgets/app_bar_widget.dart';
import 'package:flutter_application_10/widgets/cart_bottom_navbar_widget.dart';
import 'package:flutter_application_10/widgets/my_drawer_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MYyDrawerWidget(),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "Order List",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //
                  for (int i = 0; i < 2; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 9,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        width: 380,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                CupertinoIcons.person_fill,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              width: 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Hot Pizza",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Test Our Hot Pizza",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "\$ 10",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // - icon
                                    Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                    // num
                                    Text(
                                      "2",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    // + icon
                                    Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  // items +
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(20),
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
                          ]),
                      child: Column(
                        children: [
                          // tile 1
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // text 1
                                Text(
                                  "items : ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                // Text 2
                                Text(
                                  "10",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          // Divider
                          Divider(
                            color: Colors.black87,
                          ),
                          // tile 2
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // text 1
                                Text(
                                  "Sub-Total : ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                // Text 2
                                Text(
                                  "\$60",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          // tile 1
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // text 3
                                Text(
                                  "Delievery",
                                  style: TextStyle(fontSize: 20),
                                ),
                                // Text 2
                                Text(
                                  "\$15",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          // Divider
                          Divider(
                            color: Colors.black54,
                          ),
                          // tile 1
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // text 1
                                Text(
                                  "Total : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text 2
                                Text(
                                  "\$90",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // BOTTOM NAVIGATIO BAR
      bottomNavigationBar: CartBottomNavBarWidget(),
    );
  }
}
