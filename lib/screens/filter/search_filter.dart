import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
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
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close),
          ),
          top: 48,
          left: 24,
        )
      ],
    );
  }
}
