part of 'post_bloc.dart';

abstract class PostEvent {}

class SelectImagesEvent extends PostEvent {
  final List<XFile> images;

  SelectImagesEvent(this.images);
}

class CreatePostEvent extends PostEvent {
  final String textContent;

  CreatePostEvent(this.textContent);
}