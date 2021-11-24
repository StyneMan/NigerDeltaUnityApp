import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:niger_delta_unity_app/model/temp/directories_model.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

import 'directory_category.dart';

class Directories extends StatefulWidget {
  const Directories({Key? key}) : super(key: key);

  @override
  _DirectoriesState createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _categoryItemCard(int i) {
    return InkWell(
      onTap: () {},
      child: Container(
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
                image: directoriesList[i].image,
                fit: BoxFit.cover,
                // width: MediaQuery.of(context).size.width * 0.3,
                // height: MediaQuery.of(context).size.height * 0.25,
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
                    directoriesList[i].category,
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
      ),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(18),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.33,
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DirectoryCategory(),
                        ),
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.png',
                          image: directoriesList[index].image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.33,
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
                              directoriesList[index].category,
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
                ),
              );
            } else if (index % 2 == 0) {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.28,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/images/placeholder.png',
                              image: directoriesList[index].image,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.28,
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
                                    colors: [
                                      Color(0x290c0c0c),
                                      Color(0x900c0c0c)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  directoriesList[index].category,
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
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/images/placeholder.png',
                              image: directoriesList[index].image,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.24,
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
                                    colors: [
                                      Color(0x290c0c0c),
                                      Color(0x900c0c0c)
                                    ],
                                  ),
                                ),
                                child: Text(
                                  directoriesList[index].category,
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
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.24,
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: directoriesList[index].image,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.24,
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
                            directoriesList[index].category,
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
          },
          itemCount: directoriesList.length,
        ),
      ),
    );
  }
}
