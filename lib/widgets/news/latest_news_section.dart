import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/ads/ads_model.dart';
import 'package:niger_delta_unity_app/model/news/news_model.dart';
import 'package:niger_delta_unity_app/screens/news/components/news_card.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/banner/banner_slide.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots2.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

class LatestNewsSection extends StatefulWidget {
  final PreferenceManager manager;
  LatestNewsSection({Key? key, required this.manager,}) : super(key: key);

  @override
  State<LatestNewsSection> createState() => _LatestNewsSectionState();
}

class _LatestNewsSectionState extends State<LatestNewsSection> with TickerProviderStateMixin {

  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  AnimationController? _animationController;

  var _newsStream;
  var _adStream;

  @override
  void initState() {
    super.initState();
    _newsStream = FirebaseFirestore.instance
        .collection('news')
        .limit(10)
        .withConverter(
          fromFirestore: (snapshot, _) => NewsModel.fromJson(snapshot.data()!), 
          toFirestore: (NewsModel prod, _) => prod.toJson());

    _adStream = FirebaseFirestore.instance
        .collection('ads')
        .where("status", isEqualTo: "Pending")
        .where("placement", isEqualTo: "Home page")
        .limit(5)
        .withConverter(
          fromFirestore: (snapshot, _) => AdsModel.fromJson(snapshot.data()!), 
          toFirestore: (AdsModel prod, _) => prod.toJson());
          
     Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController!.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<NewsModel>>(
      stream: _newsStream.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(children: [for (var k = 0; k < 3; k++) _newsShimmer()]);
        }

        if (snapshot.data!.docs.length < 1) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_outlined,
                  size: 48,
                ),
                TextRoboto(
                  text: 'No data found',
                  fontSize: 16,
                ),
              ],
            ),
          );
        }

        final data = snapshot.requireData;

        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.size + 1,
          itemBuilder: (context, i) {
            if (i == 2) { 
              return StreamBuilder<QuerySnapshot<AdsModel>>(
                stream: _adStream.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(children: [for (var k = 0; k < 3; k++) _newsShimmer()]);
                  } 
                  
                  if (snapshot.data!.docs.length < 1) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset("assets/images/placeholder.png", fit: BoxFit.cover,),
                    );
                  }

                  final adsData = snapshot.requireData;
                  
                  return SizedBox(
                    height: 210,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PageView.builder(
                          itemCount: adsData.size,
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, i) => BannerSlide(model: adsData.docs[i].data()),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 24,
                          child: Row(
                            children: <Widget>[
                              for (int i = 0;
                                  i < adsData.size;
                                  i++)
                                if (i == _currentPage)
                                  const SlideDots2(
                                    isActive: true,
                                  )
                                else
                                  const SlideDots2(
                                    isActive: false,
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
            }
            return NewsCard(manager: widget.manager, news: data.docs[i].data(),);
          }
        );
      },
    );
  }

  Widget _newsShimmer() {
    return SizedBox(
      width: double.infinity,
      height: 156,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 24,
                      width: 56,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 18,
                      width: 108,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 18,
                      width: 108,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 18,
                      width: 108,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 18,
                      width: 108,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 16,
                      width: 72,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: true,
                child: SizedBox(
                  height: 156,
                  width: MediaQuery.of(context).size.width * 0.33,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
