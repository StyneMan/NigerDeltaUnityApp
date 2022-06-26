import 'package:flutter/material.dart';

import 'package:niger_delta_unity_app/model/categories/categories.dart';

class CategoryItem extends StatelessWidget {
  final CategoriesModel model;
  const CategoryItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10,
        bottom: 6,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[ 
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: "${model.url ?? ""}",
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.21,
                  fit: BoxFit.cover,
                );
              },
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.275,
              repeat: ImageRepeat.noRepeat,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 21.0),
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
                child: Text(
                  "${model.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
