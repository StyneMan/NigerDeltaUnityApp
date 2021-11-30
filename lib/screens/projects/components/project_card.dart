import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/temp/projects_model.dart';

class ProjectCard extends StatelessWidget {
  final List<Projects> list;
  final int index;
  const ProjectCard({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10,
        bottom: 12,
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
              image: list[index].image!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.25,
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
                  list[index].title!,
                  textAlign: TextAlign.start,
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
