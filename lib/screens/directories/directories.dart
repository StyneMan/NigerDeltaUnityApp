import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/model/temp/directories_model.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

import 'directory_category.dart';

class Directories extends StatefulWidget {
  const Directories({Key? key}) : super(key: key);

  @override
  _DirectoriesState createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Stream<QuerySnapshot> _directoryStream = FirebaseFirestore.instance
      .collection('directories-categories')
      .snapshots();

  Widget _directoryShimmer() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) => Container(
        // width: double.infinity,
        // height: MediaQuery.of(context).size.height * 0.24,
        margin: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: const ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              height: 48,
            ),
          ),
        ),
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _directoryStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  children: [for (var k = 0; k < 3; k++) _directoryShimmer()]);
            }

            return StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) => Container(
                // width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.24,
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: DirectoryCategory(
                          category: snapshot.data!.docs[index]["name"],
                        ),
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.png',
                          image: snapshot.data!.docs[index]["image"],
                          // width: double.infinity,
                          // height: MediaQuery.of(context).size.height * 0.24,
                          fit: BoxFit.cover,
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
                              snapshot.data!.docs[index]["name"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
            // return Column(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data()! as Map<String, dynamic>;
            //     return _newsItemCard(data);
            //   }).toList(),
            // );
          },
        ),
        // child: ListView.builder(
        //   padding: const EdgeInsets.all(18),
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     if (index == 0) {
        //       return Container(
        //         width: double.infinity,
        //         height: MediaQuery.of(context).size.height * 0.33,
        //         margin: const EdgeInsets.all(8.0),
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.all(Radius.circular(12)),
        //           child: InkWell(
        //             onTap: () {
        //               Get.to(const DirectoryCategory());
        //             },
        //             child: Stack(
        //               fit: StackFit.expand,
        //               clipBehavior: Clip.none,
        //               children: [
        //                 FadeInImage.assetNetwork(
        //                   placeholder: 'assets/images/placeholder.png',
        //                   image: directoriesList[index].image,
        //                   width: double.infinity,
        //                   height: MediaQuery.of(context).size.height * 0.33,
        //                   fit: BoxFit.cover,
        //                   repeat: ImageRepeat.noRepeat,
        //                 ),
        //                 Positioned(
        //                   bottom: 0,
        //                   left: 0,
        //                   right: 0,
        //                   child: Container(
        //                     padding: const EdgeInsets.all(10.0),
        //                     decoration: const BoxDecoration(
        //                       gradient: LinearGradient(
        //                         colors: [Color(0x290c0c0c), Color(0x900c0c0c)],
        //                       ),
        //                     ),
        //                     child: Text(
        //                       directoriesList[index].category,
        //                       textAlign: TextAlign.center,
        //                       style: const TextStyle(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     } else if (index % 2 != 0) {
        //       return Container(
        //         width: double.infinity,
        //         height: MediaQuery.of(context).size.height * 0.24,
        //         margin: const EdgeInsets.all(8.0),
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.all(Radius.circular(12)),
        //           child: InkWell(
        //             onTap: () {
        //               Get.to(const DirectoryCategory());
        //             },
        //             child: Stack(
        //               fit: StackFit.expand,
        //               clipBehavior: Clip.none,
        //               children: [
        //                 FadeInImage.assetNetwork(
        //                   placeholder: 'assets/images/placeholder.png',
        //                   image: directoriesList[index].image,
        //                   width: double.infinity,
        //                   height: MediaQuery.of(context).size.height * 0.24,
        //                   fit: BoxFit.cover,
        //                   repeat: ImageRepeat.noRepeat,
        //                 ),
        //                 Positioned(
        //                   bottom: 0,
        //                   left: 0,
        //                   right: 0,
        //                   child: Container(
        //                     padding: const EdgeInsets.all(10.0),
        //                     decoration: const BoxDecoration(
        //                       gradient: LinearGradient(
        //                         colors: [Color(0x290c0c0c), Color(0x900c0c0c)],
        //                       ),
        //                     ),
        //                     child: Text(
        //                       directoriesList[index].category,
        //                       textAlign: TextAlign.center,
        //                       style: const TextStyle(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     } else {
        //       return Container(
        //         width: double.infinity,
        //         height: MediaQuery.of(context).size.height * 0.28,
        //         margin: const EdgeInsets.all(8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.all(Radius.circular(12)),
        //                 child: InkWell(
        //                   onTap: () {
        //                     Get.to(const DirectoryCategory());
        //                   },
        //                   child: Stack(
        //                     fit: StackFit.expand,
        //                     clipBehavior: Clip.none,
        //                     children: [
        //                       FadeInImage.assetNetwork(
        //                         placeholder: 'assets/images/placeholder.png',
        //                         image: directoriesList[index].image,
        //                         width: double.infinity,
        //                         height:
        //                             MediaQuery.of(context).size.height * 0.28,
        //                         fit: BoxFit.cover,
        //                         repeat: ImageRepeat.noRepeat,
        //                       ),
        //                       Positioned(
        //                         bottom: 0,
        //                         left: 0,
        //                         right: 0,
        //                         child: Container(
        //                           padding: const EdgeInsets.all(10.0),
        //                           decoration: const BoxDecoration(
        //                             gradient: LinearGradient(
        //                               colors: [
        //                                 Color(0x290c0c0c),
        //                                 Color(0x900c0c0c)
        //                               ],
        //                             ),
        //                           ),
        //                           child: Text(
        //                             directoriesList[index].category,
        //                             textAlign: TextAlign.center,
        //                             style: const TextStyle(
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               width: 16.0,
        //             ),
        //             Expanded(
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.all(Radius.circular(12)),
        //                 child: InkWell(
        //                   onTap: () {
        //                     Get.to(const DirectoryCategory());
        //                   },
        //                   child: Stack(
        //                     fit: StackFit.expand,
        //                     clipBehavior: Clip.none,
        //                     children: [
        //                       FadeInImage.assetNetwork(
        //                         placeholder: 'assets/images/placeholder.png',
        //                         image: directoriesList[index].image,
        //                         width: double.infinity,
        //                         height:
        //                             MediaQuery.of(context).size.height * 0.24,
        //                         fit: BoxFit.cover,
        //                         repeat: ImageRepeat.noRepeat,
        //                       ),
        //                       Positioned(
        //                         bottom: 0,
        //                         left: 0,
        //                         right: 0,
        //                         child: Container(
        //                           padding: const EdgeInsets.all(10.0),
        //                           decoration: const BoxDecoration(
        //                             gradient: LinearGradient(
        //                               colors: [
        //                                 Color(0x290c0c0c),
        //                                 Color(0x900c0c0c)
        //                               ],
        //                             ),
        //                           ),
        //                           child: Text(
        //                             directoriesList[index].category,
        //                             textAlign: TextAlign.center,
        //                             style: const TextStyle(
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //   },
        //   itemCount: directoriesList.length,
        // ),
      ),
    );
  }
}
