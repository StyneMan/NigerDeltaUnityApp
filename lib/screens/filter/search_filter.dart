import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/filter/filter_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * 0.64,
            minHeight: MediaQuery.of(context).size.height * 0.64,
            parallaxEnabled: true,
            defaultPanelState: PanelState.OPEN,
            renderPanelSheet: true,
            parallaxOffset: .5,
            body: Container(
              color: Constants.primaryColor,
              width: double.infinity,
              height: double.infinity,
            ),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            
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
          )
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: const FilterSheet(),
    );
  }
}

