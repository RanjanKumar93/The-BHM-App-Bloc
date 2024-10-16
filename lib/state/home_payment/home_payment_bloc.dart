import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'home_payment_event.dart';
part 'home_payment_state.dart';

class HomePaymentScannerBloc
    extends Bloc<QRCodeScannerEvent, QRCodeScannerState> {
  HomePaymentScannerBloc() : super(QRCodeScannerInitial()) {
    on<QRCodeDetected>(_onBarcodeDetected);
  }

  void _onBarcodeDetected(
      QRCodeDetected event, Emitter<QRCodeScannerState> emit) {
    final rawValue = event.barcode.rawValue;
    if (rawValue == null) {
      emit(const QRCodeScannerFailure('Failed to scan Barcode'));
      return;
    }

    try {
      // Assuming the barcode contains a JSON string
      final data = json.decode(rawValue) as Map<String, dynamic>;

      emit(QRCodeScannerSuccess(data));
    } catch (e) {
      emit(const QRCodeScannerFailure('Invalid barcode format'));
    }
  }
}
