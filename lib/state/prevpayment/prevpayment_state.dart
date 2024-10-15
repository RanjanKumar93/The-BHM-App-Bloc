part of "prevpayment_bloc.dart";

sealed class PrevPaymentState {}

class PrevPaymentStateInitial extends PrevPaymentState {}

class PrevPaymentStateLoading extends PrevPaymentState {}

class PrevPaymentStateLoaded extends PrevPaymentState {
  final List<PrevPaymentModel> prevPayments;

  PrevPaymentStateLoaded(this.prevPayments);
}

class PrevPaymentStateError extends PrevPaymentState {
  final String message;
  PrevPaymentStateError(this.message);
}
