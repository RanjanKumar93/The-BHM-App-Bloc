part of "qr_bloc.dart";

sealed class QRState {}

class QRStateInitial extends QRState {}

class QRStateLoading extends QRState {}

class QRStateLoaded extends QRState {
  final QRModel qrData;
  QRStateLoaded(this.qrData);
}

class QRStateError extends QRState {
  final String message;
  QRStateError(this.message);
}
