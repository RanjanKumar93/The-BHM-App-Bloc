import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenWidth * 0.02,
        ),
        Text(
          'Extra Messing',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth * 0.4,
              height: screenWidth * 0.175,
              child: ElevatedButton.icon(
                onPressed: () {
                  GoRouter.of(context).go("/payment");
                },
                icon: Icon(
                  Icons.qr_code,
                  size: screenWidth * 0.14,
                ),
                label:  Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.01),
            SizedBox(
              width: screenWidth * 0.4,
              height: screenWidth * 0.175,
              child: ElevatedButton.icon(
                onPressed: () {
                  GoRouter.of(context).go("/prevpayment");
                },
                icon: Icon(
                  Icons.history,
                  size: screenWidth * 0.14,
                ),
                label:  Text(
                  'Previous\nPayment',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
