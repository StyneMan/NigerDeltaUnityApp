import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/model/history/history_model.dart';
import "./components/history_card.dart";
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';


class History extends StatefulWidget {
  final PreferenceManager manager;
  History({Key? key, required this.manager,}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();

}

class _HistoryState extends State<History> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _mStream;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mStream = FirebaseFirestore.instance
        .collection('history')
        .withConverter(
          fromFirestore: (snapshot, _) => HistoryModel.fromJson(snapshot.data()!) , 
          toFirestore: (HistoryModel prod, _) => prod.toJson());
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
          "History",
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
      endDrawer: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomDrawer(prefManager: widget.manager),
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
                child: StreamBuilder<QuerySnapshot<HistoryModel>>(
                  stream: _mStream.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading. Please wait...");
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
                        crossAxisCount: 2,
                      ),
                      itemCount: data.size,
                      itemBuilder: (context, i) {
                        return HistoryCard(
                          history: data.docs[i].data(),
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
}
