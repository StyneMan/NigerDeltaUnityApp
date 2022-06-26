
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/vendor/vendor_model.dart';
import 'package:niger_delta_unity_app/model/vendor/catalog_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "component/catalog_card.dart";

class Vendor extends StatefulWidget {
  final VendorModel vendor;
  const Vendor({Key? key, required this.vendor}) : super(key: key);

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> with TickerProviderStateMixin {
  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  var _catalogStream;

  @override
  void initState() {
    super.initState();
    _catalogStream = FirebaseFirestore.instance
        .collection('catalogs')
        .where('vendorID', isEqualTo: widget.vendor.id)
        .withConverter(
          fromFirestore: (snapshot, _) => CatalogModel.fromJson(snapshot.data()!), 
          toFirestore: (CatalogModel prod, _) => prod.toJson());
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.70,
          minHeight: MediaQuery.of(context).size.height * 0.70,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: true,
          parallaxOffset: .5,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image:"${widget.vendor.image ?? ""}",
              fit: BoxFit.cover,
              width: double.infinity,
              imageErrorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/images/placeholder.png'),
              height: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          onPanelSlide: (double pos) {
            // print('on panel slided...');
          },
        ),
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.transparent,
                  Color(0x180C0C0C),
                  Color(0x7A0C0C0C),
                ],
                stops: [
                  0.2,
                  0.5,
                  1,
                ],
              ),
            ),
            padding: const EdgeInsets.only(top: 48, bottom: 36, left: 8.0, right: 8.0),
            child: Center(
              child: TextRoboto(
                text: "${widget.vendor.name ?? ""}",
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                align: TextAlign.center,
              ),
            ),
          ),
          right: 0,
          top: 1,
          left: 0,
        ),
        Positioned(
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          top: 33,
          left: 8.0,
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
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: widget.vendor.catalog != null ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 48,
                ),
                StreamBuilder<QuerySnapshot<CatalogModel>>(
                  stream: _catalogStream.snapshots(),
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

                    final data = snapshot.requireData;
                    
                    return Expanded(
                      child: ListView.separated(
                        itemCount: data.size,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CatalogCard(catalog: data.docs[index].data());
                        },
                      ),
                    );
                  }
                ),
              ],
            ) : Center(
              child: Text("No Catalog Found"),
            ),
          ),
          Positioned(
            right: 0,
            top: -24,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.225 + 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0x180C0C0C),
                    Color(0x7A0C0C0C),
                    Colors.transparent,
                  ],
                  stops: [
                    0.2,
                    0.5,
                    1,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Constants.makePhoneCall("tel: ${widget.vendor.phone}");
                        },
                        child: TextRoboto(
                          text: "${widget.vendor.phone}",
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Constants.launchInBrowser("${widget.vendor.website}");
                    },
                    child: TextRoboto(
                      text: "${widget.vendor.website}",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 13,
                      ),
                      const SizedBox(width: 2),
                      InkWell(
                        onTap: () {
                          // Constants.launchMap("${widget.vendor.address}");
                        },
                        child: TextRoboto(
                          text: "${widget.vendor.address}".length > 32
                              ? "${widget.vendor.address}"
                                      .substring(0, 32) +
                                  "..."
                              : "${widget.vendor.address}",
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(6),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: "${widget.vendor.logo}",
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/placeholder.png'),
                        width: MediaQuery.of(context).size.width * 0.225,
                        height: MediaQuery.of(context).size.width * 0.225,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            top: -42,
            left: 18,
          ),
        ],
      ),
    );
  }
}
