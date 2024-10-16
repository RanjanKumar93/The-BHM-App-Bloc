part of 'home_payment_bloc.dart';

abstract class QRCodeScannerEvent extends Equatable {
  const QRCodeScannerEvent();

  @override
  List<Object?> get props => [];
}

class QRCodeDetected extends QRCodeScannerEvent {
  final Barcode barcode;

  const QRCodeDetected(this.barcode);

  @override
  List<Object?> get props => [barcode];
}
