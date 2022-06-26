
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/model/ads/ads_model.dart';
import 'package:niger_delta_unity_app/model/news/news_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/banner/banner_slide.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots2.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

import 'components/news_card.dart';

class News extends StatefulWidget {
  final PreferenceManager prefManager;
  const News({Key? key, required this.prefManager}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  var _newsStream;

  @override
  void initState() {
    super.initState();
    _newsStream = FirebaseFirestore.instance
        .collection('news')
        .limit(10)
        .withConverter(
          fromFirestore: (snapshot, _) => NewsModel.fromJson(snapshot.data()!), 
          toFirestore: (NewsModel prod, _) => prod.toJson());
     
  }

  @override
  void dispose() {
    super.dispose();
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
                  padding: const EdgeInsets.all(3.0),
                  color: Colors.red,
                ),
              ),
              right: 18,
              top: 10,
            ),
          ],
        ),
        title: const Text(
          'News',
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
          prefManager: widget.prefManager,
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
                    const SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(4.0),
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
                          child: TextField(
                            controller: _searchController,
                            // focusNode: fieldFocusNode,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Search",
                              focusColor:  Color(0xA3BEBDBD),
                              fillColor: Colors.transparent,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: Icon(Icons.search),
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StreamBuilder<QuerySnapshot<NewsModel>>(
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
                              itemCount: data.size,
                              itemBuilder: (context, i) {
                                
                                return NewsCard(manager: widget.prefManager, news: data.docs[i].data(),);
                              }
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
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
