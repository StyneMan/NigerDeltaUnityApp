import 'dart:js';

import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AccountSuspended extends StatelessWidget {
  const AccountSuspended({Key? key}) : super(key: key);

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
          body: Container(
              color: Constants.primaryColor,
              width: double.infinity,
              height: double.infinity,
              child: Stack(fit: StackFit.expand, children: [
                Image.asset(
                  'assets/images/pattern.png',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo_white.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Text(
                                'Niger Delta Unity App',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                )
              ])),
          panelBuilder: (sc) => _panel(context, sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
      ],
    );
  }

  Widget _panel(BuildContext context, ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Center(
        child: TextRaleway(
          text: 'Account Suspended',
          fontSize: 48,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
