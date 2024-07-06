import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesWidget extends StatelessWidget {
  String? CategoriesNameProduct;
  String? CategoriesProdCpount;
  CategoriesWidget({
    super.key,
    required this.CategoriesNameProduct,
    required this.CategoriesProdCpount,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            // Single Item

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 80,
                height: 70,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      "${CategoriesNameProduct}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text("${CategoriesProdCpount}")
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
