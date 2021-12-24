import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/screens/others/account_anonymous.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/account/personal.dart';
import 'package:niger_delta_unity_app/widgets/account/security.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Account extends StatefulWidget {
  final PreferenceManager prefManager;
  const Account({Key? key, required this.prefManager}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with TickerProviderStateMixin {
  AnimationController? _animationController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ImagePicker _picker = ImagePicker();
  bool _inProcess = false;
  bool _shouldUpload = false;
  String? _retrieveDataError;
  File? _imageFile = null;

  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);
  var userId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  _onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    setState(() {
      _inProcess = true;
    });
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        File? _croppedFile = (await ImageCropper.cropImage(
            sourcePath: pickedFile.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            compressQuality: 100,
            compressFormat: ImageCompressFormat.png,
            androidUiSettings:
                const AndroidUiSettings(toolbarColor: Constants.primaryColor)));

        setState(() {
          _imageFile = _croppedFile;
        });

        if (_croppedFile != null) {
          setState(() {
            _inProcess = false;
          });
          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              _shouldUpload = true;
            });

            _uploadFile(_croppedFile);
          });
        }
      } else {
        setState(() {
          _inProcess = false;
        });
      }
    } catch (e) {
      print("Image err: " + e.toString());
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file as File?;
          // _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _uploadFile(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('users/' + userId + '/avatar')
          .putFile(file)
          .then(
        (p0) {
          String downloadURL = p0.ref.getDownloadURL() as String;
          users.doc(userId).update({'photo': downloadURL}).then((value) {
            setState(() {
              _shouldUpload = false;
            });
            Fluttertoast.showToast(
              msg: 'Profile updated successfully',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey[800],
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }).catchError((error) {
            setState(() {
              _shouldUpload = false;
            });
            Fluttertoast.showToast(
              msg: 'Failed to update profile $error',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey[800],
              textColor: Colors.white,
              fontSize: 16.0,
            );
          });
        },
      );
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("EER: " + e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.prefManager.getIsLoggedIn()) {
      return const AccountAnonymous();
    }

    return LoadingOverlayPro(
      isLoading: _inProcess,
      child: Scaffold(
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
            'Account',
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
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: _imageFile == null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/placeholder.png',
                              image:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/placeholder.png'),
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.width * 0.30,
                            )
                          : Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                Image.file(
                                  File(_imageFile!.path),
                                  width:
                                      MediaQuery.of(context).size.height * 0.24,
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
                                  fit: BoxFit.cover,
                                ),
                                _shouldUpload
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                    ),
                    Positioned(
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _shouldUpload = false;
                          });
                          showBarModalBottomSheet(
                            expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.camera_alt_outlined),
                                  title: const Text(
                                    'Camera',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _onImageButtonPressed(
                                      ImageSource.camera,
                                      context: context,
                                    );
                                  },
                                ),
                                const Divider(
                                  thickness: 1.0,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _onImageButtonPressed(
                                      ImageSource.gallery,
                                      context: context,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                              ],
                            ),
                          );
                        },
                        mini: true,
                        elevation: 1.0,
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      bottom: 2,
                      right: -16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: _currentPage == 0
                              ? Colors.white
                              : const Color(0xFFF6F6F6),
                          padding: const EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = 0;
                              });
                              _pageController!.animateToPage(
                                _currentPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            child: TextRoboto(
                              text: 'Personal',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _currentPage == 0
                                  ? Constants.primaryColor
                                  : const Color(0xFFBDBDBD),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: _currentPage == 1
                              ? Colors.white
                              : const Color(0xFFF6F6F6),
                          padding: const EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = 1;
                              });
                              _pageController!.animateToPage(
                                _currentPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            child: TextRoboto(
                              text: 'Security',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _currentPage == 1
                                  ? Constants.primaryColor
                                  : const Color(0xFFBDBDBD),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: _onPageChanged,
                    controller: _pageController,
                    children: const [
                      Personal(),
                      Security(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
