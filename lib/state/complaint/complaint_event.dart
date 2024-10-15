part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class UpdateTitle extends ComplaintEvent {
  final String title;

  const UpdateTitle(this.title);

  @override
  List<Object> get props => [title];
}

class UpdateDescription extends ComplaintEvent {
  final String description;

  const UpdateDescription(this.description);

  @override
  List<Object> get props => [description];
}

class UpdateCategory extends ComplaintEvent {
  final Categories category;

  const UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateAnonymity extends ComplaintEvent {
  final bool isAnonymous;

  const UpdateAnonymity(this.isAnonymous);

  @override
  List<Object> get props => [isAnonymous];
}

class UpdateImage extends ComplaintEvent {
  final File? image;

  const UpdateImage(this.image);

  @override
  List<Object> get props => [image!];
}

class SubmitComplaint extends ComplaintEvent {}
