part of 'complaint_bloc.dart';

enum SubmissionStatus { idle, loading, success, error }

class ComplaintState extends Equatable {
  final String title;
  final String description;
  final Categories category;
  final bool isAnonymous;
  final File? image;
  final SubmissionStatus submissionStatus;
  final String? errorMessage;

  const ComplaintState({
    this.title = '',
    this.description = '',
    this.category = Categories.c1,
    this.isAnonymous = false,
    this.image,
    this.submissionStatus = SubmissionStatus.idle,
    this.errorMessage,
  });

  ComplaintState copyWith({
    String? title,
    String? description,
    Categories? category,
    bool? isAnonymous,
    File? image,
    SubmissionStatus? submissionStatus,
    String? errorMessage,
  }) {
    return ComplaintState(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      image: image ?? this.image,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        isAnonymous,
        image,
        submissionStatus,
        errorMessage,
      ];
}
