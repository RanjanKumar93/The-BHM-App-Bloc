part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class ComplaintEventUpdateTitle extends ComplaintEvent {
  final String title;

  const ComplaintEventUpdateTitle(this.title);

  @override
  List<Object> get props => [title];
}

class ComplaintEventUpdateDescription extends ComplaintEvent {
  final String description;

  const ComplaintEventUpdateDescription(this.description);

  @override
  List<Object> get props => [description];
}

class ComplaintEventUpdateCategory extends ComplaintEvent {
  final Categories category;

  const ComplaintEventUpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class ComplaintEventUpdateAnonymity extends ComplaintEvent {
  final bool isAnonymous;

  const ComplaintEventUpdateAnonymity(this.isAnonymous);

  @override
  List<Object> get props => [isAnonymous];
}

class ComplaintEventUpdateImage extends ComplaintEvent {
  final File? image;

  const ComplaintEventUpdateImage(this.image);

  @override
  List<Object> get props => [image!];
}

class ComplaintEventSubmitComplaint extends ComplaintEvent {}
