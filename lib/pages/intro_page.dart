import 'package:flutter/material.dart';
import 'package:flutter_application_10/widgets/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.shopping_bag,
              size: 72,
              color: Colors.red,
            ),

            const SizedBox(height: 25),

            // title
            const Text(
              "Khaled Online Store",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 25),

            // subtitle
            Text(
              "Premium Quality Products",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            // button
            MyButton(
                ontap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
