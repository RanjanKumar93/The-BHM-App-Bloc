import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/mess_menu.dart';
import 'package:the_bhm_app_bloc/state/mess_menu/mess_menu_provider.dart';

part 'mess_menu_event.dart';
part 'mess_menu_state.dart';

class MessMenuBloc extends Bloc<MessMenuEvent, MessMenuState> {
  final MessMenuProvider messMenuProvider;
  MessMenuBloc(this.messMenuProvider) : super(MessMenuStateInitial()) {
    on<MessMenuEventFetch>(_onFetchMealData);
    on<MessMenuEventSetDate>(_onSetDate);
    on<MessMenuEventSetMeal>(_onSetMeal);
  }

  Future<void> _onFetchMealData(
      MessMenuEventFetch event, Emitter<MessMenuState> emit) async {
    try {
      emit(MessMenuStateLoading());
      final List<MessMenuModel> mealData =
          await messMenuProvider.fetchMessMenu();
      emit(MessMenuStateLoaded(
        menus: mealData,
        selectedDate: '10',
        selectedMeal: 'Breakfast',
      ));
    } catch (e) {
      emit(MessMenuStateError(e.toString()));
    }
  }

  void _onSetDate(MessMenuEventSetDate event, Emitter<MessMenuState> emit) {
    final currentState = state;
    if (currentState is MessMenuStateLoaded) {
      emit(currentState.copyWith(selectedDate: event.date));
    }
  }

  void _onSetMeal(MessMenuEventSetMeal event, Emitter<MessMenuState> emit) {
    final currentState = state;
    if (currentState is MessMenuStateLoaded) {
      emit(currentState.copyWith(selectedMeal: event.meal));
    }
  }
}


