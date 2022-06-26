import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:niger_delta_unity_app/model/temp/adverts_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/news/latest_news_section.dart';
import 'package:niger_delta_unity_app/widgets/news/news_category_section.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final PreferenceManager? prefManager;
  const Home({Key? key, this.prefManager}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  AnimationController? _animationController;
  PreferenceManager? _manager;
  final _controller = Get.find<StateManager>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _manager = PreferenceManager(context);
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
        vsync: this, duration: const Duration(milliseconds: 450),
      );
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
    print((widget.prefManager ?? _manager)!.getUser().firstname);
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
          'Home',
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
        child: CustomDrawer(
          prefManager: widget.prefManager ?? _manager,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: NewsCategorySection(manager: widget.prefManager!),
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
                              onTap: () {
                                _controller.jumpTo(1);
                              },
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
                          height: 10.0,
                        ),
                        LatestNewsSection(manager: widget.prefManager!),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // _advertContainer()
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
