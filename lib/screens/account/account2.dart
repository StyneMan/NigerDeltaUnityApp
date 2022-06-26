import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:niger_delta_unity_app/screens/others/account_anonymous.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/utility/preference_manager.dart';
import 'package:niger_delta_unity_app/widgets/account/personal.dart';
import 'package:niger_delta_unity_app/widgets/account/security.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Account2 extends StatefulWidget {
  const Account2({ Key? key }) : super(key: key);

  @override
  State<Account2> createState() => _Account2State();
}

class _Account2State extends State<Account2> {
  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      height: MediaQuery.of(context).size.width * 0.48,
                      color: const Color(0x1A9A031E),
                      child: Center(
                        child: SvgPicture.asset("assets/images/user_avtr.svg"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                          child: const Text(
                            'Personal',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: _currentPage == 0
                                  ? Colors.white
                                  : const Color(0xFFD0D0D0),
                            onSurface: _currentPage == 0
                                ? Constants.primaryColor
                                : const Color(0xFF686868),
                            primary: _currentPage == 0
                              ? Constants.primaryColor
                              : const Color(0xFF686868),
                            padding: const EdgeInsets.all(14.0),
                            elevation: 0.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                          child: const Text(
                            'Security',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: _currentPage == 1
                                  ? Colors.white
                                  : const Color(0xFFD0D0D0),
                            onSurface: _currentPage == 1
                                ? Constants.primaryColor
                                : const Color(0xFF686868),
                            primary: _currentPage == 1
                                  ? Constants.primaryColor
                                  : const Color(0xFF686868),
                            padding: const EdgeInsets.all(14.0),
                            elevation: 0.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: _onPageChanged,
                  controller: _pageController,
                  children: [
                    PersonalProfile(
                      manager: widget.manager,
                    ),
                    Security(manager: widget.manager,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}