import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowMyAddress extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? addressLine;
  final String? city;
  final String? state;
  final String? zip_code;
  final String? country;
  final VoidCallback onTap;
  final String label;
  final VoidCallback onTap2;
  final String label2;
  ShowMyAddress({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.zip_code,
    required this.country,
    required this.onTap,
    required this.label,
    required this.onTap2,
    required this.label2,
  }) : super(key: key);

  @override
  State<ShowMyAddress> createState() => _ShowMyAddressState();
}

class _ShowMyAddressState extends State<ShowMyAddress> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.firstName}  ${widget.lastName}",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            trailing: Icon(
              _isExpanded
                  ? CupertinoIcons.upload_circle_fill
                  : Icons.expand_circle_down,
              color: Colors.red,
            ),
          ),
          Visibility(
            visible: _isExpanded,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // address : $var
                  Row(
                    children: [
                      Text(
                        "The Address : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.addressLine}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  // city : $var
                  Row(
                    children: [
                      Text(
                        "City : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.addressLine}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  // State : $var
                  Row(
                    children: [
                      Text(
                        "State : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.state}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  // zip
                  Row(
                    children: [
                      Text(
                        "Zip Code : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.zip_code}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  // country
                  Row(
                    children: [
                      Text(
                        "Country : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.country}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  // Divider
                  Divider(
                    height: 40,
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  // tow button
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                )),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: widget.onTap,
                              child: Text(
                                "${widget.label}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: widget.onTap2,
                              child: Text(
                                "${widget.label2}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
