import 'package:flutter/material.dart';
import 'package:the_bhm_app_bloc/screens/home/home_payment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.6,
              width: double.infinity,
              color: Colors.blue,
              child: const Text("data"),
            ),
            const Payment()
          ],
        ),
      ),
    );
  }
}
