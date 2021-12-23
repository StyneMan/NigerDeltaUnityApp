import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/screens/vendor/component/popular_content.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'component/fastfood_content.dart';
import 'component/pickup_content.dart';

class Vendor extends StatefulWidget {
  final Map<String, dynamic> data;
  const Vendor({Key? key, required this.data}) : super(key: key);

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> with TickerProviderStateMixin {
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
              image: widget.data["image"],
              fit: BoxFit.cover,
              width: double.infinity,
              imageErrorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/images/placeholder.png'),
              height: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          onPanelSlide: (double pos) {
            // print('on panel slided...');
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
              text: widget.data["name"],
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
                          _currentPage = 0;
                        });

                        _pageController!.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _currentPage == 0
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
                        primary: _currentPage == 0
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
                          _currentPage = 1;
                        });
                        _pageController!.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _currentPage == 1
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
                        primary: _currentPage == 1
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
                          _currentPage = 2;
                        });

                        _pageController!.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: _currentPage == 2
                                ? Container(
                                    padding: const EdgeInsets.all(3),
                                    color: const Color(0xFF037585),
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 4),
                          TextRaleway(
                            text: 'Free delivery',
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
                        primary: _currentPage == 2
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
                          ? PopularContent(
                              vendorId: widget.data["id"],
                            )
                          : _currentPage == 1
                              ? PickupContent(
                                  vendorId: widget.data["id"],
                                  delivery: "Pick up",
                                )
                              : FastfoodContent(
                                  vendorId: widget.data["id"],
                                  delivery: "Free delivery",
                                ),
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
                        image: widget.data["logo"],
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/placeholder.png'),
                        width: MediaQuery.of(context).size.width * 0.275,
                        height: MediaQuery.of(context).size.width * 0.275,
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
                                TextRoboto(
                                  text: widget.data["phone"],
                                  fontSize: 14,
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
                              ],
                            ),
                            const SizedBox(width: 4),
                            TextRoboto(
                              text: widget.data["website"],
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                const SizedBox(width: 2),
                                TextRoboto(
                                  text: widget.data["address"].length > 32
                                      ? widget.data["address"]
                                              .substring(0, 30) +
                                          "..."
                                      : widget.data["address"],
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            top: -64,
            right: 1,
            left: 24,
          )
        ],
      ),
    );
  }
}
