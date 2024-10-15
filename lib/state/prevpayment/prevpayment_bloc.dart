import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/prev_payment.dart';
import 'package:the_bhm_app_bloc/state/prevpayment/prevpayment_provider.dart';

part 'prevpayment_event.dart';
part 'prevpayment_state.dart';

class PrevPaymentBloc extends Bloc<PrevPaymentEvent, PrevPaymentState> {
  final PrevpaymentProvider prevPaymentProvider;
  PrevPaymentBloc(this.prevPaymentProvider) : super(PrevPaymentStateInitial()) {
    on<PrevpaymentEventFetch>(
      (event, emit) async {
        try {
          emit(PrevPaymentStateLoading());
          final List<PrevPaymentModel> prevPayment =
              await prevPaymentProvider.getPrevPayments();
          emit(PrevPaymentStateLoaded(prevPayment));
        } catch (e) {
          emit(PrevPaymentStateError(e.toString()));
        }
      },
    );
  }
}
