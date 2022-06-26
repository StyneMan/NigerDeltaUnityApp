import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/screens/projects/project_state.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StateCard extends StatelessWidget {
  var data;
  int index;
  final PreferenceManager manager;
  StateCard({Key? key, required this.data, required this.index, required this.manager,})
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
        child: InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: ProjectByState(
                manager: manager,
                state: data[index]["name"],
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: data[index]["image"],
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
                    data[index]["name"],
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
