import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niger_delta_unity_app/model/projects/projects_model.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

import 'components/project_card.dart';

class ProjectByState extends StatefulWidget {

  final PreferenceManager manager;
  final String state;
  const ProjectByState({ Key? key, required this.manager, required this.state}) : super(key: key);

  @override
  State<ProjectByState> createState() => _ProjectByStateState();
}

class _ProjectByStateState extends State<ProjectByState> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _statesName;
  var _mStream;
  final _searchController = TextEditingController();
  // final Stream<QuerySnapshot> _projectsStream = FirebaseFirestore.instance.collection('states').snapshots();

  @override
  void initState() {
    super.initState();
    _mStream = FirebaseFirestore.instance
        .collection('projects')
        .where('state', isEqualTo: widget.state)
        .withConverter(
          fromFirestore: (snapshot, _) => ProjectModel.fromJson(snapshot.data()!) , 
          toFirestore: (ProjectModel prod, _) => prod.toJson());
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
          '${widget.state}',
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
          prefManager: widget.manager,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
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
              const SizedBox(height: 16.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot<ProjectModel>>(
                  stream: _mStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(children: [for (var k = 0; k < 3; k++) _projectShimmer()]);
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
                    print("GHD: $data");
              
                    return GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 3,
                      ),
                      itemCount: data.size,
                      itemBuilder: (context, i) {
                        
                        return ProjectCard(
                          manager: widget.manager,
                          project: data.docs[i].data(),
                        );
                      }
                    );

                    
              
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