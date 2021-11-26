import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/filter/filter_sheet.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  bool _shouldShowSheet = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Constants.primaryColor,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          child: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Constants.primaryColor,
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
    );
  }
}

// SlidingUpPanel(
//           backdropColor: Colors.transparent,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//           parallaxEnabled: true,
//           body: const FilterSheet(),
//         ),
