import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/model/news/news_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NewsDetail extends StatefulWidget {
  PreferenceManager manager;
  NewsModel? newsItem;
  var data;
  NewsDetail({Key? key, this.newsItem, this.data, required this.manager,}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {

  // QuillController _controller = QuillController(
  //   document: Document.fromDelta(delta)
  // );

  @override
  void initState() {
    super.initState();
  }

  void _onShare(BuildContext context) async {
    await Share.share(
      'News feed',
      subject: "ACCESSPRO Access Code",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.61,
          minHeight: MediaQuery.of(context).size.height * 0.61,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: true,
          parallaxOffset: .5,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: '${widget.newsItem?.image ?? widget.data['image']}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 256),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Color(0x41034141),
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0, 0.6, 1],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton.small(
                  elevation: 0.0,
                  backgroundColor: Color(0x46707070),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                FloatingActionButton.small(
                  onPressed: () {
                    _onShare(context);
                  },
                  backgroundColor: Color(0x46707070),
                  child:  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4),),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  elevation: 0.0,
                ),
              ],
            ),
          ),
          top: 36,
          left: 0,
          right: 0,
        ),
      ],
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(21),
            width: double.infinity,
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                      color: '${widget.newsItem?.category ?? widget.data['category']}'.contains("ports")
                          ? const Color(0x8FFFAF66)
                          : '${widget.newsItem?.category ?? widget.data['category']}'.contains("news")
                              ? const Color(0x330871BD)
                              : Colors.grey[400]!,
                      child: TextRopa(
                        text: '${widget.newsItem?.category ?? widget.data['category']}',
                        fontSize: 13,
                        color: '${widget.newsItem?.category ?? widget.data['category']}'.contains("ports")
                            ? const Color(0xFFF87900)
                            : '${widget.newsItem?.category ?? widget.data['category']}'.contains("news")
                                ? const Color(0xFF0871BD)
                                : Colors.black,
                        fontWeight: FontWeight.w400,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextRoboto(
                    text: '${widget.newsItem?.title ?? widget.data['title']}',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/placeholder.png',
                            image: '${widget.newsItem?.authorPhoto ?? widget.data['authorPhoto']}',
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, stack, err) {
                              return Image.asset(
                                "assets/images/placeholder.png",
                                fit: BoxFit.cover,
                                height: 24,
                                width: 24,
                              );
                            }, 
                            height: 24,
                            width: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRoboto(
                              text: '${widget.newsItem?.authorName ?? widget.data['authorName']}',
                              fontSize: 9,
                              color: Colors.black,
                            ),
                            // TextRoboto(
                            //   text: '1hr ago  30 shares',
                            //   fontSize: 8,
                            //   color: const Color(0xFFB6B6B6),
                            // ),
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_outline,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Html(
                  data: "${widget.newsItem?.body ?? widget.data['body']}"),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          // Positioned(
          //   child: Container(
          //     child: ElevatedButton(
          //       onPressed: (){
          //         print("JKJD");
          //       },
          //       child: const Icon(
          //         Icons.share,
          //         color: Colors.white,
          //         size: 32,
          //       ),
          //     ),
          //   ),
          //   top: -24,
          //   right: 16,
          // )
        ],
      ),
    );
  }

}
