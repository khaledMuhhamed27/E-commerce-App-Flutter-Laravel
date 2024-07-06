import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? ontap;
  final Widget child;
  const MyButton({super.key, required this.ontap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]),
        child: child,
        padding: const EdgeInsets.all(25),
      ),
    );
  }
}
