part of "mess_menu_bloc.dart";

sealed class MessMenuEvent {}

class MessMenuEventFetch extends MessMenuEvent {}

class MessMenuEventSetDate extends MessMenuEvent {
  final String date;
  MessMenuEventSetDate(this.date);
}

class MessMenuEventSetMeal extends MessMenuEvent {
  final String meal;
  MessMenuEventSetMeal(this.meal);
}
