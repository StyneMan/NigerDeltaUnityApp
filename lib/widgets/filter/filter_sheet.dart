import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool _isNearest = false;
  // bool _isCostHigh = false;
  // bool _isCostLow = false;
  bool _isMostPopular = false;

  bool _isOpenNow = true;
  // bool _isFreeDelivery = false;
  // bool _isPayOnDelivery = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 512,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 36),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFDADADA),
            child: Center(
              child: TextRoboto(
                text: 'Sort by',
                fontSize: 21,
                color: Colors.black,
                align: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isNearest = !_isNearest;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextRoboto(
                        text: 'Nearest to me',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      _isNearest ? const Icon(Icons.check) : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isMostPopular = !_isMostPopular;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextRoboto(
                        text: 'Most popular',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      _isMostPopular
                          ? const Icon(Icons.check)
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFDADADA),
            child: Center(
              child: TextRoboto(
                text: 'Filter by',
                fontSize: 21,
                color: Colors.black,
                align: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isOpenNow = !_isOpenNow;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextRoboto(
                        text: 'Open now',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      _isOpenNow ? const Icon(Icons.check) : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Container(
                  width: double.infinity,
                  color: Constants.primaryColor,
                  child: TextButton(
                    onPressed: () {},
                    child: TextRoboto(
                      text: 'Apply',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
