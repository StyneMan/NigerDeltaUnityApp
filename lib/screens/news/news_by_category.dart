import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/news/news_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

import 'components/news_card.dart';
import 'news_detail.dart';

class NewsByCategory extends StatefulWidget {
  final String category;
  final PreferenceManager manager;
  const NewsByCategory({Key? key, required this.category, required this.manager,}) : super(key: key);

  @override
  _NewsByCategoryState createState() => _NewsByCategoryState();
}

class _NewsByCategoryState extends State<NewsByCategory> {
  // Stream<QuerySnapshot>? _newsStream;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _mStream;

  @override
  void initState() {
    super.initState();
     _mStream = FirebaseFirestore.instance
        .collection('news')
        .where('category', isEqualTo: widget.category)
        .withConverter(
          fromFirestore: (snapshot, _) => NewsModel.fromJson(snapshot.data()!) , 
          toFirestore: (NewsModel prod, _) => prod.toJson());
  }

  @override
  Widget build(BuildContext context) {
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
          widget.category + ' News',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        // centerTitle: true,
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
        child: const CustomDrawer(prefManager: null,),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot<NewsModel>>(
            stream: _mStream.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(children: [for (var k = 0; k < 3; k++) _newsShimmer()]);
              }
              if (snapshot.data!.docs.length < 1) {
                return Container(
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
                      )
                    ],
                  ),
                );
              }

              final data = snapshot.requireData;

              // return GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 8.0,
              //       crossAxisSpacing: 10.0,
              //       childAspectRatio: (itemWidth / itemHeight),
              //     ),
              //     itemCount: data.size,
              //     itemBuilder: (BuildContext context, int index) {
              //       return InkWell(
              //         onTap: () {
              //           pushNewScreen(
              //             context,
              //             screen: ProductDetail(
              //               product: data.docs[index].data(),
              //               manager: widget.manager!,
              //             ),
              //           );
              //         },
              //         child: ProductCard(product: data.docs[index].data()),
              //       );
              //     }
              // );
              // }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                    ),
                    child: TextRopa(
                      text: widget.category,
                      fontSize: 21,
                      align: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, i) {
                        return NewsCard(news: data.docs[i].data(), manager: widget.manager,);
                      },
                      itemCount: data.size,
                    ),
                  ),
                ],
              );
              // return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _newsShimmer() {
    return SizedBox(
      width: double.infinity,
      height: 156,
      child: Card(
        margin: const EdgeInsets.only(bottom: 18.0, left: 4, right: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
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
        elevation: 4.0,
      ),
    );
  }

  // Widget _newsItemCard(data) {
   
  // }
}
