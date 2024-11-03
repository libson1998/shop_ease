import 'package:flutter/material.dart';
import 'package:shope_ease/network/model_class/NewsFeedsResponse.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class NewsWidget extends StatelessWidget {
  final List<Results> results;
  const NewsWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListViewWidget(
        scrollPhysics:
        const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:results.length
       ,
        itemBuilder: (BuildContext context, int index) {
         final newsData = results[index];
          return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  newsData.imageUrl != null
                      ? ClipRRect(
                    borderRadius:
                    BorderRadius.circular(12),
                    child: Image.network(
                      newsData.imageUrl.toString(),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error,
                          stackTrace) =>
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey[300],
                              child: const Icon(
                                  Icons.image,
                                  size: 50),
                            ),
                          ),
                    ),
                  )
                      : ClipRRect(
                    borderRadius:
                    BorderRadius.circular(12),
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image,
                          size: 50),
                    ),
                  ),
                  const CustomSizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsData.title.toString(),
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const CustomSizedBox(
                            height: 8,
                          ),
                          Text(
                            newsData.description.toString(),
                            maxLines: 4,
                            style:
                            const TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ))
                ],
              ));
        },
      ),
    );

  }
}
