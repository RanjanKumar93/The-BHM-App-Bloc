part of 'mess_menu_bloc.dart';

sealed class MessMenuState {}

class MessMenuStateInitial extends MessMenuState {}

class MessMenuStateLoading extends MessMenuState {}

class MessMenuStateLoaded extends MessMenuState {
  final List<MessMenuModel> menus;
  final String selectedDate;
  final String selectedMeal;

  MessMenuStateLoaded({
    required this.menus,
    required this.selectedDate,
    required this.selectedMeal,
  });

  MessMenuStateLoaded copyWith({
    List<MessMenuModel>? menus,
    String? selectedDate,
    String? selectedMeal,
  }) {
    return MessMenuStateLoaded(
      menus: menus ?? this.menus,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedMeal: selectedMeal ?? this.selectedMeal,
    );
  }
}

class MessMenuStateError extends MessMenuState {
  final String message;
  MessMenuStateError(this.message);
}
