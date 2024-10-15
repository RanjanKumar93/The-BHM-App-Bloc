import 'dart:io';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:the_bhm_app/modals/complain_category_modal.dart';




part 'complaint_event.dart';
part 'complaint_state.dart';

enum Categories { c1, c2, c3, other }

class Category {
  const Category(this.title);

  final String title;
}

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(const ComplaintState()) {
    on<UpdateTitle>(_onUpdateTitle);
    on<UpdateDescription>(_onUpdateDescription);
    on<UpdateCategory>(_onUpdateCategory);
    on<UpdateAnonymity>(_onUpdateAnonymity);
    on<UpdateImage>(_onUpdateImage);
    on<SubmitComplaint>(_onSubmitComplaint);
  }

  void _onUpdateTitle(UpdateTitle event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onUpdateDescription(UpdateDescription event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onUpdateCategory(UpdateCategory event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(category: event.category));
  }

  void _onUpdateAnonymity(UpdateAnonymity event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(isAnonymous: event.isAnonymous));
  }

  void _onUpdateImage(UpdateImage event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(image: event.image));
  }

  Future<void> _onSubmitComplaint(
      SubmitComplaint event, Emitter<ComplaintState> emit) async {
    // const String url = 'https://api.example.com/data'; // Replace with actual API endpoint

    emit(state.copyWith(submissionStatus: SubmissionStatus.loading, errorMessage: null));

    try {
      // final request = http.MultipartRequest('POST', Uri.parse(url));

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
        emit(state.copyWith(
          submissionStatus: SubmissionStatus.error,
          errorMessage: 'Failed to submit complaint: ${"response.statusCode"}',
        ));
      // }
    } catch (error) {
      emit(state.copyWith(
        submissionStatus: SubmissionStatus.error,
        errorMessage: 'Error: $error',
      ));
    }
  }
}
