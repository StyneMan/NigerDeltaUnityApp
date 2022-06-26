import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/news/news_model.dart';
import 'package:niger_delta_unity_app/screens/news/news_detail.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NewsCard extends StatelessWidget {
  final PreferenceManager manager;
  final NewsModel? news;
  var data;
  NewsCard({ Key? key, this.news, required this.manager, this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        margin: const EdgeInsets.only(bottom: 18.0, left: 4, right: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: NewsDetail(
                manager: manager,
                newsItem: news,
                data: data,
              ),
            );
            // Get.to(NewsDetail(newsItem: data));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.46,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: '${news?.category ?? data['category']}'.contains("ports")
                            ? const Color(0x8FFFAF66)
                            : '${news?.category ?? data['category']}'.contains("news")
                                ? const Color(0x330871BD)
                                : Colors.grey[400]!,
                      ),
                      child: TextRopa(
                        fontSize: 8,
                        text: '${news?.category ?? data['category']}',
                        color: '${news?.category ?? data['category']}'.contains("ports")
                            ? const Color(0xFFF87900)
                            : '${news?.category ?? data['category']}'.contains("news")
                                ? const Color(0xFF0871BD)
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    TextAriel(
                      text: '${news?.title ?? data['title']}',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    TextAriel(
                      text: '${news?.summary ?? data['summary']}'.toString().length > 85
                          ? '${news?.summary ?? data['summary']}'.toString().substring(0, 85) + "..."
                          : '${news?.summary ?? data['summary']}',
                      softWrap: true,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextRopa(
                      text: 'Read more',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0871BD),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: '${news?.image ?? data['image']}',
                  height: 156,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      height: 156,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.33,
                    );
                  },
                  width: MediaQuery.of(context).size.width * 0.33,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        elevation: 4.0,
      ),
    );
  }
}