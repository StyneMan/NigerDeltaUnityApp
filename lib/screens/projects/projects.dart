import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/others/states.dart';
import 'package:niger_delta_unity_app/model/temp/projects_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:shimmer/shimmer.dart';

import 'components/project_card.dart';

class Projects extends StatefulWidget {
  final PreferenceManager prefManager;
  const Projects({Key? key, required this.prefManager}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _statesName;
  final Stream<QuerySnapshot> _projectsStream =
      FirebaseFirestore.instance.collection('projects').snapshots();

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
          'Projects',
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
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                  hint: Text(
                    _statesName ?? 'Select project state',
                  ),
                  // disabledHint: ,
                  items: nigerDeltaStates.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  value: _statesName,
                  onChanged: (newValue) {
                    setState(() {
                      _statesName = newValue as String?;
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  iconSize: 34,
                  isExpanded: true,
                  underline: const SizedBox(),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _projectsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(children: [
                        for (var k = 0; k < 3; k++) _projectShimmer()
                      ]);
                    }

                    return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 3,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          return ProjectCard(
                            index: i,
                            data: snapshot.data!.docs,
                          );
                        });

                    // Column(
                    //   children:
                    //       snapshot.data!.docs.map((DocumentSnapshot document) {
                    //     Map<String, dynamic> data =
                    //         document.data()! as Map<String, dynamic>;
                    //     return ProjectCard(data: data);
                    //   }).toList(),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectShimmer() {
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
