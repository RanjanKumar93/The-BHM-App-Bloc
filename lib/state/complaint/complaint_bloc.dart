import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

enum Categories { c1, c2, c3, other }

class Category {
  const Category(this.title);

  final String title;
}

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(const ComplaintState()) {
    on<ComplaintEventUpdateTitle>(_onUpdateTitle);
    on<ComplaintEventUpdateDescription>(_onUpdateDescription);
    on<ComplaintEventUpdateCategory>(_onUpdateCategory);
    on<ComplaintEventUpdateAnonymity>(_onUpdateAnonymity);
    on<ComplaintEventUpdateImage>(_onUpdateImage);
    on<ComplaintEventSubmitComplaint>(_onSubmitComplaint);
  }

  void _onUpdateTitle(
      ComplaintEventUpdateTitle event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onUpdateDescription(
      ComplaintEventUpdateDescription event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onUpdateCategory(
      ComplaintEventUpdateCategory event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(category: event.category));
  }

  void _onUpdateAnonymity(
      ComplaintEventUpdateAnonymity event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(isAnonymous: event.isAnonymous));
  }

  void _onUpdateImage(
      ComplaintEventUpdateImage event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(image: event.image));
  }

  Future<void> _onSubmitComplaint(
      ComplaintEventSubmitComplaint event, Emitter<ComplaintState> emit) async {
    // const String url = 'https://api.example.com/data'; // Replace with actual API endpoint

    emit(state.copyWith(
        submissionStatus: SubmissionStatus.loading, errorMessage: null));

    try {
      // final request = http.MultipartRequest('POST', Uri.parse(url));
      await Future.delayed(const Duration(seconds: 2));
      // request.fields['title'] = state.title;
      // request.fields['description'] = state.description;
      // request.fields['category'] = state.category.toString().split('.').last;
      // request.fields['isAnonymous'] = state.isAnonymous.toString();

      // if (state.image != null) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'image',
      //     state.image!.path,
      //   ));
      // }

      // final response = await request.send();

      // if (response.statusCode == 200) {
      emit(state.copyWith(
        submissionStatus: SubmissionStatus.success,
        // Clear fields
        title: '',
        description: '',
        category: Categories.c1,
        isAnonymous: false,
        image: null,
      ));
      // }
      // else {
      // emit(state.copyWith(
      //   submissionStatus: SubmissionStatus.error,
      //   errorMessage: 'Failed to submit complaint: ${"response.statusCode"}',
      // ));
      // }
    } catch (error) {
      emit(state.copyWith(
        submissionStatus: SubmissionStatus.error,
        errorMessage: 'Error: $error',
      ));
    }
  }
}
