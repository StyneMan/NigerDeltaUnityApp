import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:niger_delta_unity_app/model/vendor/catalog_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class CatalogCard extends StatelessWidget {
  final CatalogModel catalog;
  CatalogCard({ Key? key, required this.catalog, }) : super(key: key);

  bool _hasCallSupport = false;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: "${catalog.image ?? ""}",
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/placeholder.png'),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRaleway(
                          text: "${catalog.name ?? ""}",
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              color: Color(0xFF979797),
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            TextRaleway(
                              text: "${catalog.vendorName}",
                              fontSize: 11,
                              color: const Color(0xFF979797),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF979797),
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            TextRaleway(
                              text: "${catalog.vendorAddress}".length > 21
                                  ? "${catalog.vendorAddress}".substring(0, 18) +
                                      "..."
                                  : "${catalog.vendorAddress}",
                              fontSize: 11,
                              color: const Color(0xFF979797),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney("${catalog.price}")}', 
                                  style: TextStyle(
                                    fontSize: 12,
                                  )
                                ),
                                Text(
                                  "${catalog.vendorName}".toLowerCase().contains("hotel") ? " per night" : "",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                )
                                // TextRaleway(
                                //   text: "${catalog.}",
                                //   fontSize: 9,
                                //   color: Colors.black,
                                //   fontWeight: FontWeight.w500,
                                // ),
                                // const SizedBox(width: 2),
                                // ClipOval(
                                //   child: Container(
                                //     padding: const EdgeInsets.all(2),
                                //     color: Colors.black,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // FloatingActionButton.small(
                        //   onPressed: () {},
                        //   elevation: 0,
                        //   backgroundColor: Constants.secondaryColor,
                        //   child: const Icon(
                        //     Icons.favorite_outline,
                        //     size: 16,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        TextButton(
                          onPressed: () {
                            if (_hasCallSupport) {
                              _makePhoneCall("${catalog.vendorPhone}");
                            }
                          },
                          child: Container(
                            color: const Color(0x6B08B3CB),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: TextRaleway(
                              text: 'Contact',
                              fontSize: 10,
                              align: TextAlign.center,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 21),
                      ],
                    ),
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