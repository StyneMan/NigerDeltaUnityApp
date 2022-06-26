import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/model/vendor/vendor_model.dart';
import 'package:niger_delta_unity_app/widgets/directories/featured_vendors.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryVendors extends StatefulWidget {
  final String category;
  const CategoryVendors({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryVendorsState createState() => _CategoryVendorsState();
}

class _CategoryVendorsState extends State<CategoryVendors> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _vendorsStream;

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
      body: SafeArea(
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
            
          },
        ),
      )
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