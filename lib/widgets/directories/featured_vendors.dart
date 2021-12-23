import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/screens/vendor/vendor.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FeaturedVendors extends StatefulWidget {
  final Map<String, dynamic> data;
  const FeaturedVendors({Key? key, required this.data}) : super(key: key);

  @override
  _FeaturedVendorsState createState() => _FeaturedVendorsState();
}

class _FeaturedVendorsState extends State<FeaturedVendors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          pushNewScreen(
            context,
            screen: Vendor(
              data: widget.data,
            ),
          );
          // Get.to(
          //   Vendor(
          //     model: vendorsList[index],
          //   ),
          // );
          // print("Date: " + DateTime.now().hour.toString());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.png',
                          image: widget.data["logo"],
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                    TextRaleway(
                      text: widget.data["name"],
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.black87,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: widget.data["image"],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.225,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextRaleway(
                  text: widget.data["description"].length > 24
                      ? widget.data["description"].substring(0, 23) + "..."
                      : widget.data["description"],
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextRaleway(
                      text: widget.data["address"].length > 21
                          ? widget.data["address"].substring(0, 18) + "..."
                          : widget.data["address"],
                      fontSize: 12,
                      color: const Color(0xFF828282),
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          widget.data["is24Hours"]
                              ? Icons.lock_open_sharp
                              : Icons.lock,
                          color: const Color(0xFFF25E22),
                        ),
                        TextRaleway(
                          text: widget.data["is24Hours"] ? 'OPEN' : 'CLOSED',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF25E22),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.all(2),
                //       decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(3),
                //         ),
                //         color: Color(0xFFF25E22),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           const Icon(
                //             Icons.star,
                //             size: 16,
                //             color: Colors.white,
                //           ),
                //           TextRaleway(
                //             text: "4.2",
                //             color: Colors.white,
                //             fontSize: 11,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     TextRaleway(
                //       text: vendorsList[index].time,
                //       fontSize: 11,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w600,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     ClipOval(
                //       child: Container(
                //         color: Colors.black,
                //         padding: const EdgeInsets.all(2),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     TextRaleway(
                //       text: vendorsList[index].delivery,
                //       fontSize: 11,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ],
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
