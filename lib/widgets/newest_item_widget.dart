import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class NewestItemWidget extends StatelessWidget {
  Widget? ImageSrc;
  String? nameProd;
  String? descProd;
  String? priceProd;
  IconData? yourIcon;
  final VoidCallback onTap;
  NewestItemWidget({
    super.key,
    required this.ImageSrc,
    required this.descProd,
    required this.nameProd,
    required this.priceProd,
    required this.yourIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
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
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 1 widget
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                              alignment: Alignment.center, child: ImageSrc),
                        ),
                      ),
                      // 2 widget
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 190,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${nameProd}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "${descProd}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              // Rating *
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
                              // price
                              Text(
                                "\$${priceProd}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
