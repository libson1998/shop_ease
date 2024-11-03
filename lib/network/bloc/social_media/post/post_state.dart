part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
class PostUploadProgress extends PostState {
  final double progress;

  PostUploadProgress(this.progress);
}