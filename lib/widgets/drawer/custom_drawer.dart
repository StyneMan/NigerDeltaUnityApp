import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/screens/account/account.dart';
import 'package:niger_delta_unity_app/screens/education/education.dart';
import 'package:niger_delta_unity_app/screens/history/history.dart';
import 'package:niger_delta_unity_app/screens/home/home.dart';
import 'package:niger_delta_unity_app/screens/news/news.dart';
import 'package:niger_delta_unity_app/screens/projects/projects.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDJzEaxLN-jGRYYUO65pWu7Q9GXoNt4LUSSA&usqp=CAU',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.21,
                      height: MediaQuery.of(context).size.width * 0.21,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRoboto(
                        text: 'Obinna Gregg',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      TextRoboto(
                        text: 'user@email.com',
                        fontSize: 12,
                        color: const Color(0xFFB6B6B6),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(const Home());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/drawer_home_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'Home',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const News());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/drawer_news_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'News',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const Projects());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/drawer_projects_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'Projects',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const Projects());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/drawer_dir_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'Directories',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const History());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/drawer_history_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'History',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const Education());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/drawer_education_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'Education',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const Account());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/drawer_account_icon.svg'),
                        const SizedBox(width: 8.0),
                        TextRoboto(
                          text: 'My account',
                          fontSize: 15,
                          color: const Color(0xFF1D1D20),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
