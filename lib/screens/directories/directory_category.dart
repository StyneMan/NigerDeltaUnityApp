import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/model/ads/ads_model.dart';
// import 'package:niger_delta_unity_app/model/temp/directory_sub_model.dart';
import 'package:niger_delta_unity_app/model/vendor/vendor_model.dart';
import 'package:niger_delta_unity_app/screens/filter/search_filter.dart';
import 'package:niger_delta_unity_app/screens/vendor/vendor.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/banner/banner_slide.dart';
import 'package:niger_delta_unity_app/widgets/directories/featured_vendors.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots2.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import './components/category_vendors.dart';

class DirectoryCategory extends StatefulWidget {
  final String category;
  const DirectoryCategory({Key? key, required this.category}) : super(key: key);

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
  var _vendorsStream;
  var _adStream;

  @override
  void initState() {
    super.initState();

    _vendorsStream = FirebaseFirestore.instance
        .collection('directories-vendors')
        .where('category', isEqualTo: widget.category)
        .where('blocked', isEqualTo: false)
        .limit(10)
        .withConverter(
          fromFirestore: (snapshot, _) => VendorModel.fromJson(snapshot.data()!), 
          toFirestore: (VendorModel prod, _) => prod.toJson());

    _adStream = FirebaseFirestore.instance
        .collection('ads')
        .where("status", isEqualTo: "Pending")
        .where("placement", isEqualTo: "Directories")
        .limit(5)
        .withConverter(
          fromFirestore: (snapshot, _) => AdsModel.fromJson(snapshot.data()!), 
          toFirestore: (AdsModel prod, _) => prod.toJson());

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

  @override
  void dispose() {
    _animationController?.dispose();
    _pageController?.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 18) / 2.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "" + widget.category,
          style: const TextStyle(
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
      // endDrawer: SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   child: const CustomDrawer(),
      // ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
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
                          Get.to(const SearchFilter());
                        },
                        child: SvgPicture.asset('assets/images/filter.svg'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<QuerySnapshot<AdsModel>>(
                  stream: _adStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(children: [for (var k = 0; k < 1; k++) const Text('Loading please wait...')]);
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
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextRaleway(
                        text: 'Featured ${widget.category}',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(CategoryVendors(category: widget.category));
                        },
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
                  child: StreamBuilder<QuerySnapshot<VendorModel>>(
                    stream: _vendorsStream.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Column(children: [
                          for (var k = 0; k < 2; k++) _vendorsShimmer()
                        ]);
                      }

                      final data = snapshot.requireData;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        // controller: ,
                        itemCount: data.size,
                        itemBuilder: (BuildContext context, int index) {
                          return FeaturedVendors(vendor: data.docs[index].data());
                        }
                      );
                      
                    }),
                  // child: ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: vendorsList.length,
                  //   itemBuilder: (context, i) => _featuredVendors(i),
                  // ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _vendorsShimmer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.25,
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
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
            ),
          ),
        ),
      ),
    );
  }
}
