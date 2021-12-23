import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/model/temp/news_model.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:intl/intl.dart";

class ProjectDetail extends StatefulWidget {
  var projectItem;
  int index;
  ProjectDetail({Key? key, required this.index, required this.projectItem})
      : super(key: key);

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.60,
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
              image: widget.projectItem[widget.index]["image"],
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
            // print('on panel kj...');
          },
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 256),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Color(0x41034141),
                  Colors.transparent,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0, 0.6, 1],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/images/back_circular.svg'),
                ),
              ],
            ),
          ),
          top: 36,
          left: 0,
          right: 0,
        ),
      ],
    );
  }

  Widget _panel(ScrollController sc) {
    Timestamp t = widget.projectItem[widget.index]["updatedAt"];
    DateTime d = t.toDate();

    // print(d.toString()); //2019-12-28 18:48:48.364

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(21),
            width: double.infinity,
            child: ListView(
              children: [
                const SizedBox(
                  height: 21,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextRoboto(
                    text: widget.projectItem[widget.index]["title"],
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: TextRopa(
                        text: widget.projectItem[widget.index]["state"],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                      ),
                    ),
                    TextRopa(
                      text: DateFormat.yMMMd().add_jm().format(d),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(height: 8),
                TextRoboto(
                  text: widget.projectItem[widget.index]["description"],
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
