import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/screens/news/news_detail.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

class LatestNewsSection extends StatefulWidget {
  LatestNewsSection({Key? key}) : super(key: key);

  @override
  State<LatestNewsSection> createState() => _LatestNewsSectionState();
}

class _LatestNewsSectionState extends State<LatestNewsSection> {
  final Stream<QuerySnapshot> _newsStream =
      FirebaseFirestore.instance.collection('news').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _newsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(children: [for (var k = 0; k < 3; k++) _newsShimmer()]);
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return _newsItemCard(data);
          }).toList(),
        );
      },
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

  Widget _newsItemCard(data) {
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
        child: InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: NewsDetail(
                newsItem: data,
              ),
            );
            // Get.to(NewsDetail(newsItem: data));
          },
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
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: data["category"].contains("ports")
                            ? const Color(0x8FFFAF66)
                            : data["category"].contains("news")
                                ? const Color(0x330871BD)
                                : Colors.grey[400]!,
                      ),
                      child: TextRopa(
                        fontSize: 7,
                        text: data["category"],
                        color: data["category"].contains("ports")
                            ? const Color(0xFFF87900)
                            : data["category"].contains("news")
                                ? const Color(0xFF0871BD)
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextAriel(
                      text: data["title"],
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    TextAriel(
                      text: data["body"].toString().length > 100
                          ? data["body"].toString().substring(0, 99) + "..."
                          : data["body"],
                      softWrap: true,
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextRopa(
                      text: 'Read more',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0871BD),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: data["image"],
                  height: 156,
                  width: MediaQuery.of(context).size.width * 0.33,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/placeholder.png');
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        elevation: 4.0,
      ),
    );
  }
}
