part of 'news_feeds_bloc.dart';

@immutable
sealed class NewsFeedsState {}

final class NewsFeedsInitial extends NewsFeedsState {}

final class NewsFeedActionState extends NewsFeedsState {}

final class NewsFeedsLoadingState extends NewsFeedActionState {}

final class NewsFeedsSuccessState extends NewsFeedActionState {
  final NewsFeedsResponse? newsFeedsResponse;
  final List<Feeds>? feeds;

  NewsFeedsSuccessState({this.newsFeedsResponse, this.feeds});
}

final class NewsFeedsErrorState extends NewsFeedActionState {
  final String error;

  NewsFeedsErrorState({required this.error});
}
