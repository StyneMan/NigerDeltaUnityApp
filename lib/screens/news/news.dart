import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:niger_delta_unity_app/model/temp/adverts_model.dart';
import 'package:niger_delta_unity_app/model/temp/categories.dart';
import 'package:niger_delta_unity_app/model/temp/news_model.dart';
import 'package:niger_delta_unity_app/screens/account/account.dart';
import 'package:niger_delta_unity_app/screens/news/news_detail.dart';
import 'package:niger_delta_unity_app/widgets/drawer/custom_drawer.dart';
import 'package:niger_delta_unity_app/widgets/slide_dot/slide_dots.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

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
                image: categoriesList[i].image!,
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
                    categoriesList[i].title!,
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

  Widget _newsItemCard(int index) {
    return SizedBox(
      width: double.infinity,
      height: 156,
      child: Card(
        margin: const EdgeInsets.only(bottom: 18.0, left: 4, right: 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: InkWell(
          onTap: () {
            // print(newsList[index].title);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetail(newsItem: newsList[index]),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: newsList[index].category == 'World news'
                            ? const Color(0x8FFFAF66)
                            : newsList[index].category == 'Sports news'
                                ? const Color(0x330871BD)
                                : Colors.transparent,
                      ),
                      child: TextRopa(
                        fontSize: 7,
                        text: newsList[index].category,
                        color: newsList[index].category == 'World news'
                            ? const Color(0xFFF87900)
                            : newsList[index].category == 'Sports news'
                                ? const Color(0xFF0871BD)
                                : Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextAriel(
                      text: newsList[index].title,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    TextAriel(
                      text: newsList[index].body,
                      softWrap: true,
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextRopa(
                      text: 'Read more',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0871BD),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: newsList[index].image!,
                  height: 156,
                  width: MediaQuery.of(context).size.width * 0.33,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        elevation: 4.0,
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
          'News',
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
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoriesList.length,
                        itemBuilder: (context, i) => _categoryItemCard(i),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Search here...'),
                              SvgPicture.asset('assets/images/search_icon.svg'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Latest News',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFF94B14),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0; i < newsList.length; i++)
                              _newsItemCard(i)
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
