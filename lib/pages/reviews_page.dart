import 'package:flutter/material.dart';
import 'package:flutter_application_10/auth/constans.dart';
import 'package:flutter_application_10/auth/onehelpers.dart';
import 'package:flutter_application_10/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewsPage extends StatefulWidget {
  final int productId;
  const ReviewsPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = true;
  List<dynamic> reviews = [];
  double rating = 3.0;
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5f3),
        title: Text('Reviews Page'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : reviews.isEmpty
              ? Center(child: Text('No reviews available'))
              : ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    var review = reviews[index];
                    var title = review['user']?['name'] ?? 'No title';
                    var content = review['review'] ?? 'No content';
                    var rating = review['rating'] ?? 0;
                    var createdAt = review['created_at'] ?? 'No date';
                    // ignore: unused_local_variable
                    var userName = review['user']?['name'] ?? 'Anonymous';
                    var userId = review['user_id'];

                    return ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.person_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            " : ${title}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content),
                          SizedBox(height: 4),
                          Text(createdAt,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$rating ⭐'),
                          SizedBox(width: 8),
                          FutureBuilder<SharedPreferences>(
                            future: SharedPreferences.getInstance(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                var prefs = snapshot.data!;
                                int currentUserId = prefs.getInt('userId')!;
                                if (currentUserId == userId) {
                                  return IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm Delete'),
                                          content: Text(
                                              'Are you sure you want to delete this review?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                deleteReview(review['id']);
                                              },
                                              child: Text('Yes'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Review'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The content is required';
                        }
                        return null;
                      },
                      cursorColor: Colors.red,
                      controller: reviewController,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          )),
                          hintText: 'Enter your review'),
                    ),
                  ),
                  SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await addNewReview().then((response) {
                        setState(() {
                          isLoading = false;
                        });

                        var jsonResponse = json.decode(response.body);

                        final _context = MyApp.navKey.currentContext;

                        if (response.statusCode == 200) {
                          if (_context != null) {
                            ScaffoldMessenger.of(_context)
                                .showSnackBar(SnackBar(
                                    content: Text(transformErrors(
                              jsonResponse.containsKey("errors")
                                  ? jsonResponse['errors']
                                  : {},
                              singleError: jsonResponse.containsKey("message")
                                  ? jsonResponse['message']
                                  : "",
                            ))));
                            reviewController.clear();
                            Navigator.pushNamed(context, 'rev');
                          }
                        } else {
                          if (_context != null) {
                            ScaffoldMessenger.of(_context)
                                .showSnackBar(SnackBar(
                                    content: Text(transformErrors(
                              jsonResponse.containsKey("errors")
                                  ? jsonResponse['errors']
                                  : {},
                              singleError: jsonResponse.containsKey("message")
                                  ? jsonResponse['message']
                                  : "",
                            ))));
                          }
                        }
                      });
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
        label: Text(
          'New Review',
          style: TextStyle(color: Colors.red),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Future<void> fetchReviews() async {
    String url =
        API_URL + 'product-review/showProductReviews/${widget.productId}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('Fetching reviews from: $url'); // طباعة URL للتحقق منه
    print('Response status: ${response.statusCode}'); // طباعة حالة الاستجابة
    print('Response body: ${response.body}'); // طباعة محتوى الاستجابة

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('reviews')) {
          setState(() {
            reviews = jsonResponse['reviews'];
            isLoading = false;
          });
        } else {
          print('No reviews key in the response');
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print('Error parsing JSON: $e');
        setState(() {
          isLoading = false;
        });
      }
    } else if (response.statusCode == 401) {
      // إذا كانت حالة الاستجابة 401، فهذا يعني أن المستخدم غير مصادق عليه
      print('Unauthorized: Check your token');
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load reviews');
    }
  }

// add riview function
  Future<Response> addNewReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userIdInt = prefs.getInt('userId')!;
    String userId = userIdInt.toString();
    String token = prefs.getString('token')!;

    String url = API_URL + 'product-review/store';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'user_id': userId,
        'product_id': widget.productId,
        'review': reviewController.text,
        'rating': rating,
      }),
    );

    return response;
  }

  // Delete review
  Future<void> deleteReview(int reviewId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    String url = API_URL + 'product-review/delete/$reviewId';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        reviews.removeWhere((review) => review['id'] == reviewId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review')),
      );
    }
  }
}
