import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/news_feeds/news_feeds_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/home/news_widget.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class NewsFeedsScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const NewsFeedsScreen({super.key, required this.navigateTo});

  @override
  State<NewsFeedsScreen> createState() => _NewsFeedsScreenState();
}

class _NewsFeedsScreenState extends State<NewsFeedsScreen>
    with AutomaticKeepAliveClientMixin {
   NewsFeedsBloc newsFeedsBloc = NewsFeedsBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    newsFeedsBloc = BlocProvider.of<NewsFeedsBloc>(context);
    if (newsFeedsBloc.state is! NewsFeedsSuccessState) {
      newsFeedsBloc.add(NewsFeedsFetchEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const SizedBox(),
          surfaceTintColor: Colors.white,
          toolbarHeight: 0),
      body: SafeArea(
          child: BlocConsumer<NewsFeedsBloc, NewsFeedsState>(
        bloc: newsFeedsBloc,
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is NewsFeedsSuccessState) {
            return RefreshIndicator(
              onRefresh:_refreshFeeds,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Widgets().customAppbar("News Feeds", context, false),
                    NewsWidget(results: state.newsFeedsResponse!.results!),
                    const CustomSizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is NewsFeedsLoadingState) {
            return Widgets().widgetLoader();
          } else if (state is NewsFeedsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Error Please Try Again"),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      newsFeedsBloc.add(NewsFeedsFetchEvent());
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF49108C)),
                      child: const Center(
                          child: Text(
                        "Rety",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

   Future<void> _refreshFeeds() async {
     newsFeedsBloc.add(NewsFeedsFetchEvent());
   }
}
