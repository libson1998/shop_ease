import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shope_ease/network/model_class/FeedsResponse.dart';
import 'package:shope_ease/network/model_class/NewsFeedsResponse.dart';
import 'package:shope_ease/network/repos/news_feeds_repo.dart';

part 'news_feeds_event.dart';

part 'news_feeds_state.dart';

class NewsFeedsBloc extends Bloc<NewsFeedsEvent, NewsFeedsState> {
  NewsFeedsBloc() : super(NewsFeedsInitial()) {
    on<NewsFeedsFetchEvent>(_getNewsFeeds);
  }

  FutureOr<void> _getNewsFeeds(
      NewsFeedsFetchEvent event, Emitter<NewsFeedsState> emit) async {
    try {
      emit(NewsFeedsLoadingState());
      final homeFeedsResponse = await NewsFeedsRepo.fetchNewsFeeds();
      final products = await NewsFeedsRepo().fetchProducts();

      if (homeFeedsResponse.status == "success") {
        emit(NewsFeedsSuccessState(
            newsFeedsResponse: homeFeedsResponse, feeds: products));
        print("Success state emitted");
      } else {
        emit(NewsFeedsErrorState(error: homeFeedsResponse.status.toString()));
      }
    } catch (e) {
      print("Error state emitted: $e");
      emit(NewsFeedsErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _getHomeProducts(
      NewsFeedsFetchEvent event, Emitter<NewsFeedsState> emit) async {
    try {
      final products = await NewsFeedsRepo().fetchProducts();
      emit(NewsFeedsSuccessState(feeds: products));
    } catch (e) {
      emit(NewsFeedsErrorState(error: 'Failed to fetch products'));
    }
  }
}
