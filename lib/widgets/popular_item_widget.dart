import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopularItemWidget extends StatelessWidget {
  Widget? ImageSrc;
  String? nameProd;
  String? descProd;
  String? priceProd;
  IconData? yourIcon;
  final VoidCallback onTap;
  PopularItemWidget({
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
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            child: ImageSrc),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "${nameProd}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${descProd}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${priceProd}",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: onTap,
                            child: Icon(
                              yourIcon,
                              color: Colors.red,
                              size: 26,
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
