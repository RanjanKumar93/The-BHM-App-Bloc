part of 'home_bloc.dart';

sealed class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateImagesLoading extends HomeState {}

class HomeStateImagesLoaded extends HomeState {
  final HomeImagesModel homeImages;

  HomeStateImagesLoaded(this.homeImages);
}

class HomeStateError extends HomeState {
  final String message;
  HomeStateError(this.message);
}
