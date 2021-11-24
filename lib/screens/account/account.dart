import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/account/personal.dart';
import 'package:niger_delta_unity_app/widgets/account/security.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with TickerProviderStateMixin {
  AnimationController? _animationController;

  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: TextRopa(
          text: 'Accout',
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        centerTitle: true,
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
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                    ),
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      onPressed: () {},
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
    );
  }
}
