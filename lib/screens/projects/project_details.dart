
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/model/projects/projects_model.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import "package:intl/intl.dart";
import 'package:share_plus/share_plus.dart';
import 'package:flutter_html/flutter_html.dart';

class ProjectDetail extends StatefulWidget {
  ProjectModel project;
  ProjectDetail({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {

  @override
  void initState() {
    super.initState();
  }

  void _onShare(BuildContext context) async {
    await Share.share(
      'Project',
      subject: "ACCESSPRO Access Code",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.61,
          minHeight: MediaQuery.of(context).size.height * 0.61,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: true,
          parallaxOffset: .5,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image:"${widget.project.image}",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton.small(
                  elevation: 0.0,
                  backgroundColor: Color(0x46707070),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                FloatingActionButton.small(
                  onPressed: () {
                    _onShare(context);
                  },
                  backgroundColor: Color(0x46707070),
                  child:  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4),),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  elevation: 0.0,
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
    Timestamp t = widget.project.updatedAt;
    DateTime d = t.toDate();

    print(d.toString()); //2019-12-28 18:48:48.364

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
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextRoboto(
                    text: "${widget.project.title}",
                    fontSize: 17,
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
                        text: "${widget.project.state}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                      ),
                    ),
                    TextRopa(
                      text: "${DateFormat.yMMMd().add_jm().format(d)}",
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
                Html(
                  data: "${widget.project.description}"
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
