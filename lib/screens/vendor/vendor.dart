import 'dart:async';

import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/temp/directory_sub_model.dart';
import 'package:niger_delta_unity_app/screens/vendor/component/popular_content.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'component/fastfood_content.dart';
import 'component/pickup_content.dart';

class Vendor extends StatefulWidget {
  final FeaturedVendorsModel model;
  const Vendor({Key? key, required this.model}) : super(key: key);

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> with TickerProviderStateMixin {
  bool _isPopular = true;
  bool _isPickup = false;
  bool _isFastFood = false;

  int _currentPage = 0;
  PageController? _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.70,
          minHeight: 144,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: true,
          parallaxOffset: .5,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: widget.model.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          onPanelSlide: (double pos) {
            print('on panel slided...');
          },
        ),
        Positioned(
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          top: 36,
          left: 10,
        ),
        Positioned(
          child: Center(
            child: TextRaleway(
              text: widget.model.title,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              align: TextAlign.center,
            ),
          ),
          top: 56,
          left: 24,
          right: 24,
        )
      ],
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isPopular = true;
                          _isPickup = false;
                          _isFastFood = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _isPopular
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    color: const Color(0xFF037585))
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 4),
                          TextRaleway(
                            text: 'Popular',
                            fontSize: 11,
                            color: const Color(0xFF037585),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16,
                        ),
                        primary: _isPopular
                            ? const Color(0x6B08B3CB)
                            : const Color(0xFFF2F2F2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isPickup = true;
                          _isPopular = false;
                          _isFastFood = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _isPickup
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    color: const Color(0xFF037585),
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 4),
                          TextRaleway(
                            text: 'Pick up',
                            fontSize: 11,
                            color: const Color(0xFF037585),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16,
                        ),
                        primary: _isPickup
                            ? const Color(0x6B08B3CB)
                            : const Color(0xFFF2F2F2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isFastFood = true;
                          _isPickup = false;
                          _isPopular = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _isFastFood
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    color: const Color(0xFF037585),
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 4),
                          TextRaleway(
                            text: 'Fast food',
                            fontSize: 11,
                            color: const Color(0xFF037585),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16,
                        ),
                        primary: _isFastFood
                            ? const Color(0x6B08B3CB)
                            : const Color(0xFFF2F2F2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (ctx, i) => Container(
                      child: _currentPage == 0
                          ? const PopularContent()
                          : _currentPage == 1
                              ? const PickupContent()
                              : const FastfoodContent(),
                    ),
                    itemCount: 3,
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: _onPageChanged,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(6),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: widget.model.photo,
                        fit: BoxFit.cover,
                        width: 112,
                        height: 112,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(bottom: 21),
                    color: const Color(0x29000000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextRaleway(
                                  text: widget.model.time,
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(width: 4),
                                ClipOval(
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                TextRaleway(
                                  text: widget.model.delivery,
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 2),
                                const SizedBox(width: 4),
                                TextRaleway(
                                  text: widget.model.address,
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                            color: Color(0xFFF25E22),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                              TextRaleway(
                                text: '${widget.model.rating}',
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            top: -64,
            right: 24,
            left: 24,
          )
        ],
      ),
    );
  }
}
