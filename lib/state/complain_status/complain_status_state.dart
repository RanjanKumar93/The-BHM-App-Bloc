part of 'complain_status_bloc.dart';

sealed class ComplainStatusState {}

class ComplainStatusStateInitial extends ComplainStatusState {}

class ComplainStatusStateLoading extends ComplainStatusState {}

class ComplainStatusStateLoaded extends ComplainStatusState {
  final List<ComplainStatusModel> complainStatusData;
  ComplainStatusStateLoaded(this.complainStatusData);
}

class ComplainStatusStateError extends ComplainStatusState {
  final String message;
  ComplainStatusStateError(this.message);
}
