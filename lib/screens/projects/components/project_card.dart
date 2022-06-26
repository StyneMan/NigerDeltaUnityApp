import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/projects/projects_model.dart';
import 'package:niger_delta_unity_app/screens/projects/project_details.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final PreferenceManager manager;
  ProjectCard({Key? key, required this.project, required this.manager,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("DEMOI:: ${project.id}");
    return Container(
      padding: const EdgeInsets.only(
        right: 10,
        bottom: 12,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: ProjectDetail(
                project: project,
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: "${project.image ?? ""}",
                fit: BoxFit.cover,
                imageErrorBuilder: (context, stack, erro) {
                  return Image.asset(
                    "assets/images/placeholder.png", 
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.25,
                  );
                },
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
                    "${project.title}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
