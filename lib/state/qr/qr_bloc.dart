import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/qr.dart';
import 'package:the_bhm_app_bloc/state/qr/qr_provider.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QRBloc extends Bloc<QREvent, QRState> {
  final QRProvider qrProvider;
  QRBloc(this.qrProvider) : super(QRStateInitial()) {
    on<QREventFetch>(_onFetchQR);
  }

  Future<void> _onFetchQR(QREventFetch event, Emitter<QRState> emit) async {
    await _fetchQRData(emit);
  }

  Future<void> _fetchQRData(Emitter<QRState> emit) async {
    try {
      emit(QRStateLoading());
      final qrData = await qrProvider.getQR();
      emit(QRStateLoaded(qrData));
    } catch (e) {
      emit(QRStateError(e.toString()));
    }
  }
}
