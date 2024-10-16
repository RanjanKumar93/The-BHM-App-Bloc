import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:the_bhm_app_bloc/services/notification_service.dart';
import 'package:the_bhm_app_bloc/state/home_payment/home_payment_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isBarcodeScanned = false;
  void _handleBarcode(BarcodeCapture barcodes) {
    if (_isBarcodeScanned) return; // Prevent multiple scans

    final barcode = barcodes.barcodes.first;
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan Barcode');
      return;
    }
    _isBarcodeScanned = true;

    // Dispatch the event to BLoC
    context.read<HomePaymentScannerBloc>().add(QRCodeDetected(barcode));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePaymentScannerBloc, QRCodeScannerState>(
      listener: (context, state) {
        if (state is QRCodeScannerSuccess) {
          GoRouter.of(context).go(
            "/payment-detail",
            extra: state.data, // Pass the scanned data 
          );
        } else if (state is QRCodeScannerFailure) {
          NotificationService.showSimpleSnackBar(state.message);
          _isBarcodeScanned = false;
        }
      },
      child: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Scan Your QR Code',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
