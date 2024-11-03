part of 'news_feeds_bloc.dart';

@immutable
sealed class NewsFeedsEvent {}

class NewsFeedsFetchEvent extends NewsFeedsEvent {}
class HomeFeedsFeedsFetchEvent extends NewsFeedsEvent {}
