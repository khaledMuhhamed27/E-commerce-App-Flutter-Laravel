import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomNAvBar extends StatelessWidget {
  final void Function()? ontap;
  final String? priceTto;

  const ItemBottomNAvBar(
      {super.key, required this.ontap, required this.priceTto});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shadowColor: Colors.black,
      elevation: 0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // total text
                Text(
                  "Total :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                // sizedbox
                SizedBox(
                  width: 15,
                ),
                // total price
                Text(
                  "\$${priceTto}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            //material button
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 18,
              ),
              color: Colors.red,
              onPressed: ontap,
              child: Row(
                children: [
                  // icon
                  Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                  ),
                  //text
                  Text(
                    "  Order Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
