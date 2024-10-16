part of 'home_payment_bloc.dart';

abstract class QRCodeScannerState extends Equatable {
  const QRCodeScannerState();

  @override
  List<Object?> get props => [];
}

class QRCodeScannerInitial extends QRCodeScannerState {}

class QRCodeScannerSuccess extends QRCodeScannerState {
  final Map<String, dynamic> data;

  const QRCodeScannerSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class QRCodeScannerFailure extends QRCodeScannerState {
  final String message;

  const QRCodeScannerFailure(this.message);

  @override
  List<Object?> get props => [message];
}
