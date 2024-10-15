import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/state/mess_menu/mess_menu_bloc.dart';

class MessMenuScreen extends StatelessWidget {
  const MessMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Text(
                'Hi Sheersh,',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                'Your Today\'s Meal',
                style: TextStyle(color: Colors.black, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<MessMenuBloc, MessMenuState>(
        builder: (context, state) {
          if (state is MessMenuStateInitial) {
            return const Center(child: Text('Welcome!'));
          } else if (state is MessMenuStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessMenuStateLoaded) {
            final mealData = state.menus;
            final selectedDate = state.selectedDate;
            final selectedMeal = state.selectedMeal;

            // Find the selected date's data
            final selectedMenu =
                mealData.firstWhere((menu) => menu.day == selectedDate);

            final meals = selectedMenu.meals;
            final mealList = selectedMeal == 'Breakfast'
                ? meals.breakfast
                : selectedMeal == 'Lunch'
                    ? meals.lunch
                    : meals.dinner;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Text(
                      '10 - 16 (7 Days) September',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mealData.map((date) {
                        return DayTile(
                          day: getDayName(date.day),
                          date: date.day,
                          isSelected: selectedDate == date.day,
                          onTap: () {
                            context
                                .read<MessMenuBloc>()
                                .add(MessMenuEventSetDate(date.day));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      'Today\'s Meal',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Breakfast', 'Lunch', 'Dinner'].map((meal) {
                      return MealTypeTile(
                        title: meal,
                        isSelected: selectedMeal == meal,
                        onTap: () {
                          context
                              .read<MessMenuBloc>()
                              .add(MessMenuEventSetMeal(meal));
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: mealList
                              .map((item) => Text(
                                    item,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MessMenuStateError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  String getDayName(String date) {
    final days = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return days[(int.parse(date) - 10) % 7];
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DayTile({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 37,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.grey
              : const Color.fromRGBO(158, 158, 158, 0.2),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$day\n\n$date",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealTypeTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MealTypeTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black
              : const Color.fromRGBO(158, 158, 158, 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
