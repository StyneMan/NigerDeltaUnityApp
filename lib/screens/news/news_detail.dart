import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/model/temp/news_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.60,
          minHeight: 144,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: true,
          parallaxOffset: .5,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: widget.newsItem.image!,
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
          onPanelSlide: (double pos) {
            print('on panel kj...');
          },
        ),
        Positioned(
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/images/back_circular.svg'),
          ),
          top: 36,
          left: 10,
        ),
      ],
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(21),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 21,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                      color: widget.newsItem.category == 'World news'
                          ? const Color(0x8FFFAF66)
                          : widget.newsItem.category == 'Sports news'
                              ? const Color(0x330871BD)
                              : Colors.transparent,
                      child: TextRopa(
                        text: widget.newsItem.category,
                        fontSize: 12,
                        color: widget.newsItem.category == 'World news'
                            ? const Color(0xFFF87900)
                            : widget.newsItem.category == 'Sports news'
                                ? const Color(0xFF0871BD)
                                : Colors.transparent,
                        fontWeight: FontWeight.w400,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                              fontSize: 9,
                              color: Colors.black,
                            ),
                            TextRoboto(
                              text: '1hr ago  30 shares',
                              fontSize: 8,
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
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(height: 8),
                TextRoboto(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextRoboto(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim et, convallis in gravida ultricies at feugiat. Lectus ullamcorper id amet scelerisque. Pharetra id pellentesque amet nibh. Porta pharetra porttitor ullamcorper venenatis nullam tellus sem. Cras nisi nullam praesent turpis adipiscing amet dui. Mattis in in orci adipiscing vitae, facilisi suspendisse. Sagittis duis lectus elementum mauris urna, mattis at sed. Sem tellus sit at orci gravida phasellus. Condimentum nisi mattis ullamcorper pulvinar nulla eget risus lacinia. Nibh in faucibus posuere arcu, leo a. In dolor arcu quisque habitasse curabitur neque. At viverra sagittis morbi sagittis ac sit aliquam.',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 4,
                ),
                // TextRoboto(
                //   text:
                //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim et, convallis in gravida ultricies at feugiat. Lectus ullamcorper id amet scelerisque. Pharetra id pellentesque amet nibh. Porta pharetra porttitor ullamcorper venenatis nullam tellus sem. Cras nisi nullam praesent turpis adipiscing amet dui. Mattis in in orci adipiscing vitae, facilisi suspendisse. Sagittis duis lectus elementum mauris urna, mattis at sed. Sem tellus sit at orci gravida phasellus. Condimentum nisi mattis ullamcorper pulvinar nulla eget risus lacinia. Nibh in faucibus posuere arcu, leo a. In dolor arcu quisque habitasse curabitur neque. At viverra sagittis morbi sagittis ac sit aliquam.',
                //   fontSize: 11,
                //   fontWeight: FontWeight.w400,
                //   color: Colors.black,
                // ),
              ],
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Constants.accentColor,
                  onPressed: () {},
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
            top: -24,
            right: 32,
            left: 32,
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   Future.delayed(const Duration(milliseconds: 100), () {
  //     if (_showBottomSheet) {
  //       showCupertinoModalBottomSheet(
  //         expand: false,
  //         enableDrag: false,
  //         useRootNavigator: true,
  //         barrierColor: Colors.transparent,
  //         elevation: 0.0,
  //         context: context,
  //         topRadius: const Radius.circular(32),
  //         backgroundColor: Colors.white,
  //         builder: (context) => Container(
  //           height: 256,
  //           padding: const EdgeInsets.all(10),
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(24),
  //               topRight: Radius.circular(24),
  //             ),
  //           ),
  //           child: Scaffold(
  //             body: Stack(
  //               clipBehavior: Clip.none,
  //               children: [
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.all(10),
  //                       color: widget.newsItem.category == 'World news'
  //                           ? const Color(0x8FFFAF66)
  //                           : widget.newsItem.category == 'Sports news'
  //                               ? const Color(0x330871BD)
  //                               : Colors.transparent,
  //                       child: TextRopa(
  //                         fontSize: 12,
  //                         text: widget.newsItem.category,
  //                         color: widget.newsItem.category == 'World news'
  //                             ? const Color(0xFFF87900)
  //                             : widget.newsItem.category == 'Sports news'
  //                                 ? const Color(0xFF0871BD)
  //                                 : Colors.transparent,
  //                       ),
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.all(10),
  //                       width: MediaQuery.of(context).size.width * 0.6,
  //                       child: TextRoboto(
  //                         text: widget.newsItem.title,
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w700,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             ClipOval(
  //                               child: FadeInImage.assetNetwork(
  //                                 placeholder: 'assets/images/placeholder.png',
  //                                 image:
  //                                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
  //                                 fit: BoxFit.cover,
  //                                 height: 24,
  //                                 width: 24,
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               width: 16.0,
  //                             ),
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 TextRoboto(
  //                                   text: 'John Doe',
  //                                   fontSize: 8,
  //                                   color: Colors.black,
  //                                 ),
  //                                 TextRoboto(
  //                                   text: '1hr ago  30 shares',
  //                                   fontSize: 7,
  //                                   color: const Color(0xFFB6B6B6),
  //                                 ),
  //                               ],
  //                             )
  //                           ],
  //                         ),
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: const Icon(
  //                             Icons.bookmark_outline,
  //                             color: Colors.black,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     const Divider(
  //                       thickness: 1.0,
  //                     )
  //                   ],
  //                 ),
  //                 Positioned(
  //                   child: FloatingActionButton(
  //                     backgroundColor: const Color(0xFF0094FF),
  //                     onPressed: () {},
  //                     child: const Icon(
  //                       Icons.share,
  //                       color: Colors.white,
  //                       size: 24,
  //                     ),
  //                   ),
  //                   bottom: -50,
  //                   top: -50,
  //                   right: 10,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //       // Get.bottomSheet(

  //       //     barrierColor: Colors.transparent,
  //       //     enableDrag: false,
  //       //     isDismissible: false);
  //     }
  //   });
  //   return Scaffold(
  //     floatingActionButton: FloatingActionButton(
  //       backgroundColor: Colors.transparent,
  //       onPressed: () {
  //         Navigator.pop(context);
  //       },
  //       child: SvgPicture.asset('assets/images/back_circular.svg'),
  //     ),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
  //     body: SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.75,
  //       width: double.infinity,
  //       child: FadeInImage.assetNetwork(
  //         placeholder: 'assets/images/placeholder.png',
  //         image: widget.newsItem.image!,
  //       ),
  //     ),
  //   );
  // }
}
