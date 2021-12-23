import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/temp/directory_sub_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularContent extends StatefulWidget {
  final int vendorId;
  const PopularContent({Key? key, required this.vendorId}) : super(key: key);

  @override
  _PopularContentState createState() => _PopularContentState();
}

class _PopularContentState extends State<PopularContent> {
  late Stream<QuerySnapshot> _productStream;
  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    _productStream = FirebaseFirestore.instance
        .collection('products')
        .where("vendorID", isEqualTo: widget.vendorId)
        .snapshots();

    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _shimmer();
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Expanded(child: Center(child: Text('No data found')));
        }

        return ListView(
          padding: const EdgeInsets.all(8.0),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()!;
            return _cardItem(data);
          }).toList(),
        );
      },
    );
  }

  Widget _shimmer() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var k = 0; k < 2; k++)
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 128,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
        ],
      );

  Widget _cardItem(data) => Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2.0,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png',
                    image: data["image"],
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset('assets/images/placeholder.png'),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRaleway(
                            text: data["name"],
                            fontSize: 15,
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
                              const SizedBox(width: 2),
                              TextRaleway(
                                text: data["vendorName"],
                                fontSize: 11,
                                color: const Color(0xFF979797),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color(0xFF979797),
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              TextRaleway(
                                text: data["vendorAddress"].length > 21
                                    ? data["vendorAddress"].substring(0, 18) +
                                        "..."
                                    : data["vendorAddress"],
                                fontSize: 11,
                                color: const Color(0xFF979797),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(1),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1),
                                  ),
                                  color: Color(0xFFF25E22),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 11,
                                      color: Colors.white,
                                    ),
                                    TextRaleway(
                                      text: '${4.2}',
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextRaleway(
                                    text: data["vendorPhone"],
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(width: 2),
                                  ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  TextRaleway(
                                    text: data["delivery"],
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton.small(
                            onPressed: () {},
                            elevation: 0,
                            backgroundColor: Constants.secondaryColor,
                            child: const Icon(
                              Icons.favorite_outline,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_hasCallSupport) {
                                _makePhoneCall(data["vendorPhone"]);
                              }
                            },
                            child: Container(
                              color: const Color(0x6B08B3CB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: TextRaleway(
                                text: 'Contact',
                                fontSize: 10,
                                align: TextAlign.center,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 21),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
