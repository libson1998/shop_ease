import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/news_feeds/news_feeds_bloc.dart';
import 'package:shope_ease/network/model_class/HomeFeedsModel.dart';
import 'package:shope_ease/ui/home/home_appbar.dart';
import 'package:shope_ease/ui/home/news_widget.dart';
import 'package:shope_ease/ui/home/story.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:shope_ease/widgets/widget_title.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const HomeScreen({super.key, required this.navigateTo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
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

  Future<void> _refreshFeeds() async {
    newsFeedsBloc.add(NewsFeedsFetchEvent());
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NewsFeedsSuccessState) {
            return RefreshIndicator(
              onRefresh: _refreshFeeds,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const CustomSizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(
                              children: [
                                const HomeAppBar(),
                                const CustomSizedBox(height: 16),
                                SizedBox(
                                  height: 100,
                                  child: ListViewWidget(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeFeedsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final homeStory = homeFeedsList[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: CircularContainerWithBorder(
                                          size: 80,
                                          homeFeedsList: homeStory,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const CustomSizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          ListViewWidget(
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.feeds?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            state.feeds![index].image,
                                            fit: BoxFit.cover,
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                        const CustomSizedBox(
                                          width: 12,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.feeds![index].name ?? "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              state.feeds![index].location
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        ButtonWidget(
                                          buttonPress: () {},
                                          title: 'Connect',
                                          width: screenWidth * 0.25,
                                          isLeftIconVisible: false,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          textStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0.09,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.more_vert_outlined,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  const CustomSizedBox(
                                    height: 12,
                                  ),
                                  Image.network(
                                    state.feeds![index].image,
                                    fit: BoxFit.cover,
                                    width: screenWidth,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.feeds![index].description
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const CustomSizedBox(
                                          height: 8,
                                        ),
                                        const Text("Comments...")
                                      ],
                                    ),
                                  ),
                                  const CustomSizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          ),
                          TitleWidget(
                              title: "News",
                              onPress: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                widget.navigateTo(1);
                              }),
                          NewsWidget(results: state.newsFeedsResponse!.results!),
                        ],
                      ),
                    ),
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

  List<HomeFeedsModel> homeFeedsList = [
    HomeFeedsModel(
        imageUrl:
            'https://photosbook.in/wp-content/uploads/instagram-dp-for-girls-black_95.webp',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://photosnow.org/wp-content/uploads/2024/04/instagram-dp-for-boys.jpg',
        name: "Josephina"),
    HomeFeedsModel(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYKMkReBcSSX6nEwzsCEYzO39sg4OxyPGghQ&s',
        name: "Linda"),
    HomeFeedsModel(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTafzdhRmPdDID_LV0o7t4CEFQIUy8Yiy6QpA&s',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://sabimages.com/wp-content/uploads/2024/08/Instagram-dp-for-boys14-1.jpg',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://pxraja.com/wp-content/uploads/2024/07/attitude-instagram-dp-for-girls_40.webp',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://photosbook.in/wp-content/uploads/instagram-dp-for-girls-black_95.webp',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://photosbook.in/wp-content/uploads/instagram-dp-for-girls-black_95.webp',
        name: "Tina"),
    HomeFeedsModel(
        imageUrl:
            'https://photosbook.in/wp-content/uploads/instagram-dp-for-girls-black_95.webp',
        name: "Tina"),
  ];
}
