import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/model/categories/categories.dart';
import 'package:niger_delta_unity_app/model/temp/adverts_model.dart';
import 'package:niger_delta_unity_app/model/temp/categories.dart';
import 'package:niger_delta_unity_app/model/temp/news_model.dart';
import 'package:niger_delta_unity_app/screens/news/news_detail.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/home/latest_news_section.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  AnimationController? _animationController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Stream<QuerySnapshot> _categoriesStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
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

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              ),
            ),
            Positioned(
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.red,
                ),
              ),
              right: 18,
              top: 10,
            ),
          ],
        ),
        title: const Text(
          'Directories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (!scaffoldKey.currentState!.isEndDrawerOpen) {
                scaffoldKey.currentState!.openEndDrawer();
              }
            },
            icon: Image.asset('assets/images/menu_icon.png'),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
        ),
      ),
      endDrawer: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const CustomDrawer(),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Search here...'),
                        SvgPicture.asset('assets/images/search_icon.svg'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _categoriesStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Row(children: [
                              for (var k = 0; k < 3; k++) _categoryShimmer()
                            ]);
                          }

                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return _categoryItemCard(data);
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Latest News',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFF94B14),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        LatestNewsSection(),
                        const SizedBox(
                          height: 8.0,
                        ),
                        _advertContainer()
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryShimmer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
          padding: const EdgeInsets.only(
            right: 10,
            bottom: 12,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryItemCard(data) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(
          right: 10,
          bottom: 12,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: data["url"],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.25,
                repeat: ImageRepeat.noRepeat,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x290c0c0c), Color(0x900c0c0c)],
                    ),
                  ),
                  child: Text(
                    data["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _advertContainer() => Column(
        children: [
          SizedBox(
            height: 128,
            width: MediaQuery.of(context).size.width * 0.75,
            child: PageView.builder(
              itemBuilder: (ctx, i) => ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => _launchInBrowser(adsList[i].url!),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image: adsList[i].image!,
                      height: 128,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.75,
                    ),
                  )),
              itemCount: adsList.length,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: _onPageChanged,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < adsList.length; i++)
                if (i == _currentPage)
                  SlideDots(
                    isActive: true,
                  )
                else
                  SlideDots(
                    isActive: false,
                  )
            ],
          )
        ],
      );
}
