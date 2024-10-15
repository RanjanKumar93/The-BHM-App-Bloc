import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/complain_status.dart';
import 'package:the_bhm_app_bloc/state/complain_status/complain_status_provider.dart';

part 'complain_status_event.dart';
part 'complain_status_state.dart';

class ComplainStatusBloc
    extends Bloc<ComplainStatusEvent, ComplainStatusState> {
  final ComplainStatusProvider complainStatusProvider;
  ComplainStatusBloc(this.complainStatusProvider)
      : super(ComplainStatusStateInitial()) {
    on<ComplainStatusEventFetch>(_onFetchComplainStatus);
  }

  Future<void> _onFetchComplainStatus(
      ComplainStatusEvent event, Emitter<ComplainStatusState> emit) async {
    try {
      emit(ComplainStatusStateLoading());

     final List<ComplainStatusModel> complainData = await complainStatusProvider.fetchComplainStatus();
      emit(ComplainStatusStateLoaded(complainData));
    } catch (e) {
      emit(ComplainStatusStateError(e.toString()));
    }
  }
}
