import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:niger_delta_unity_app/model/temp/directory_sub_model.dart';
import 'package:niger_delta_unity_app/screens/filter/search_filter.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots2.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectoryCategory extends StatefulWidget {
  const DirectoryCategory({Key? key}) : super(key: key);

  @override
  _DirectoryCategoryState createState() => _DirectoryCategoryState();
}

class _DirectoryCategoryState extends State<DirectoryCategory>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  AnimationController? _animationController;

  bool _isLiked = false;

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
      headers: <String, String>{'m_header_key': 'm_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget _bannerSlide(int index) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: directoryBannerList[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRaleway(
                    fontSize: 16,
                    text: directoryBannerList[index].title,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  TextRaleway(
                    fontSize: 8,
                    text: directoryBannerList[index].address,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          color: Color(0xFFF25E22),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            ),
                            TextRaleway(
                              text: '${directoryBannerList[index].rating}',
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextRaleway(
                        text: directoryBannerList[index].time,
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _featuredVendors(int index) => Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.only(right: 16),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/placeholder.png',
                            image: vendorsList[index].photo,
                            fit: BoxFit.cover,
                            width: 36,
                            height: 36,
                          ),
                        ),
                      ),
                      TextRaleway(
                        text: vendorsList[index].name,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png',
                    image: vendorsList[index].image,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.225,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextRaleway(
                    text: vendorsList[index].title,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextRaleway(
                        text: vendorsList[index].address,
                        fontSize: 12,
                        color: const Color(0xFF828282),
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            vendorsList[index].isOpen
                                ? Icons.lock_open_sharp
                                : Icons.lock,
                            color: const Color(0xFFF25E22),
                          ),
                          TextRaleway(
                            text: vendorsList[index].isOpen ? 'OPEN' : 'CLOSED',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF25E22),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          color: Color(0xFFF25E22),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            ),
                            TextRaleway(
                              text: '${vendorsList[index].rating}',
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextRaleway(
                        text: vendorsList[index].time,
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                        child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.all(2),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextRaleway(
                        text: vendorsList[index].delivery,
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget _bestPick() => Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Card(
                  elevation: 1.0,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png',
                    image:
                        'https://media.istockphoto.com/photos/hamburger-with-fries-picture-id617364554?b=1&k=20&m=617364554&s=170667a&w=0&h=joRNTh0DPeZUsd9DQT2Gf_00EIqtOV00MZ5FFx4Ctig=',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.21,
                    height: MediaQuery.of(context).size.width * 0.21,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRaleway(
                    text: 'Decker Hamburger',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Color(0xFF979797),
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextRaleway(text: 'Buns & Barter', fontSize: 11)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF979797),
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextRaleway(text: 'GRA Phase 2', fontSize: 11),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                          color: Color(0xFFF25E22),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            ),
                            TextRaleway(
                              text: '${vendorsList[0].rating}',
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextRaleway(
                        text: vendorsList[0].time,
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                        child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.all(2),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextRaleway(
                        text: vendorsList[0].delivery,
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: TextRaleway(
                        text: 'Add to cart',
                        color: Colors.black,
                        fontSize: 11,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        primary: const Color(0x7000BCEB),
                        onPrimary: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    right: 8,
                    child: FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      backgroundColor:
                          _isLiked ? const Color(0xFFF25E22) : Colors.white,
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Icon(
                        Icons.favorite_outline,
                        color:
                            _isLiked ? Colors.white : const Color(0xFFF25E22),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

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
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search here...',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            labelStyle: const TextStyle(
                              color: Constants.primaryColor,
                            ),
                            suffix: InkWell(
                              onTap: () {
                                print('hj olkij');
                              },
                              child: SvgPicture.asset(
                                'assets/images/search_icon.svg',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          controller: _searchController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        color: const Color(0xFFF25E22),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchFilter(),
                              ),
                            );
                          },
                          child: SvgPicture.asset('assets/images/filter.svg'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 200,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          PageView.builder(
                            itemCount: directoryBannerList.length,
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: _onPageChanged,
                            itemBuilder: (context, i) => _bannerSlide(i),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 24,
                            child: Row(
                              children: <Widget>[
                                for (int i = 0;
                                    i < directoryBannerList.length;
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextRaleway(
                            text: 'Featured Vendors',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextRaleway(
                                  text: 'View all',
                                  fontSize: 14,
                                  color: const Color(0xFFF94B14),
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFFF94B14),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.33 + 96,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: vendorsList.length,
                        itemBuilder: (context, i) => _featuredVendors(i),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextRaleway(
                            text: 'Best pick',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextRaleway(
                                  text: 'View all',
                                  fontSize: 14,
                                  color: const Color(0xFFF94B14),
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFFF94B14),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(1),
                      child: _bestPick(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}