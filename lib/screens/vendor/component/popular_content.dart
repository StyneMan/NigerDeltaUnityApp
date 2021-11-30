import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/temp/directory_sub_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class PopularContent extends StatefulWidget {
  const PopularContent({Key? key}) : super(key: key);

  @override
  _PopularContentState createState() => _PopularContentState();
}

class _PopularContentState extends State<PopularContent> {
  Widget _cardItem(int index) => Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2.0,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: vendorsTabbedList[index].image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
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
                            text: vendorsTabbedList[index].title,
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
                                text: vendorsTabbedList[index].name,
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
                                text: vendorsTabbedList[index].address,
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
                              Container(
                                padding: const EdgeInsets.all(1),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1),
                                  ),
                                  color: Color(0xFFF25E22),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 11,
                                      color: Colors.white,
                                    ),
                                    TextRaleway(
                                      text:
                                          '${vendorsTabbedList[index].rating}',
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextRaleway(
                                    text: vendorsTabbedList[index].time,
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(width: 2),
                                  ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  TextRaleway(
                                    text: vendorsTabbedList[index].delivery,
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                          FloatingActionButton.small(
                            onPressed: () {},
                            elevation: 0,
                            backgroundColor: Constants.secondaryColor,
                            child: const Icon(
                              Icons.favorite_outline,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              color: const Color(0x6B08B3CB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: TextRaleway(
                                text: 'Add to cart',
                                fontSize: 10,
                                align: TextAlign.center,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 21),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: vendorsTabbedList.length,
      itemBuilder: (context, i) => _cardItem(i),
    );
  }
}
