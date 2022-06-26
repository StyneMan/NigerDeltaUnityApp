import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/categories/categories.dart';
import 'package:niger_delta_unity_app/screens/news/news_by_category.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/news/components/category_item.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

class NewsCategorySection extends StatelessWidget {
  final PreferenceManager manager;
  NewsCategorySection({Key? key, required this.manager,}) : super(key: key);

  // final Stream<QuerySnapshot> _categoriesStream =
  //     FirebaseFirestore.instance.collection('categories').snapshots();

  final categoryQuery =
      FirebaseFirestore.instance.collection('categories')
      .withConverter(
        fromFirestore: (snapshot, _) => CategoriesModel.fromJson(snapshot.data()!) , 
        toFirestore: (CategoriesModel mod, _) => mod.toJson());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<CategoriesModel>>(
      stream: categoryQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [for (var k = 0; k < 3; k++) _categoryShimmer(context)],
          );
        }
        if (!snapshot.hasData) {
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text("No Data Found..."),
            ),
          );
        }
        final data = snapshot.requireData;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.size,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: NewsByCategory(
                    category: "${data.docs[index].data().title}",
                    manager: manager,
                  ),
                );
              },
              child: CategoryItem(model: data.docs[index].data()));
          }
        );
      }
    );
  }

  Widget _categoryShimmer(BuildContext context) {
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
