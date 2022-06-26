import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/ads/ads_model.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class BannerSlide extends StatelessWidget {
  final AdsModel model;
  const BannerSlide({ Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: "${model.banner ?? ""}",
              fit: BoxFit.cover,
              imageErrorBuilder: (context, stack, error) => Image.asset("assets/images/placeholder.png", fit: BoxFit.cover,),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRoboto(
                    fontSize: 16,
                    text: model.name,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  TextRoboto(
                    fontSize: 10,
                    text: model.address,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}