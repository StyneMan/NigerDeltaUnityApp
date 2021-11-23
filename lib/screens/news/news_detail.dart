import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/model/temp/news_model.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class NewsDetail extends StatefulWidget {
  final NewsModel newsItem;
  const NewsDetail({Key? key, required this.newsItem}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool _showBottomSheet = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_showBottomSheet) {
        showCupertinoModalBottomSheet(
          expand: false,
          enableDrag: false,
          useRootNavigator: true,
          barrierColor: Colors.transparent,
          elevation: 0.0,
          context: context,
          topRadius: const Radius.circular(32),
          backgroundColor: Colors.white,
          builder: (context) => Container(
            height: 256,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Scaffold(
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: widget.newsItem.category == 'World news'
                            ? const Color(0x8FFFAF66)
                            : widget.newsItem.category == 'Sports news'
                                ? const Color(0x330871BD)
                                : Colors.transparent,
                        child: TextRopa(
                          fontSize: 12,
                          text: widget.newsItem.category,
                          color: widget.newsItem.category == 'World news'
                              ? const Color(0xFFF87900)
                              : widget.newsItem.category == 'Sports news'
                                  ? const Color(0xFF0871BD)
                                  : Colors.transparent,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextRoboto(
                          text: widget.newsItem.title,
                          fontSize: 12,
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
                                  image:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
                                  fit: BoxFit.cover,
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
                                    text: 'John Doe',
                                    fontSize: 8,
                                    color: Colors.black,
                                  ),
                                  TextRoboto(
                                    text: '1hr ago  30 shares',
                                    fontSize: 7,
                                    color: const Color(0xFFB6B6B6),
                                  ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1.0,
                      )
                    ],
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xFF0094FF),
                      onPressed: () {},
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    bottom: -50,
                    top: -50,
                    right: 10,
                  )
                ],
              ),
            ),
          ),
        );
        // Get.bottomSheet(

        //     barrierColor: Colors.transparent,
        //     enableDrag: false,
        //     isDismissible: false);
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset('assets/images/back_circular.svg'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.infinity,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/placeholder.png',
          image: widget.newsItem.image!,
        ),
      ),
    );
  }
}
