import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/forms/login/login_form.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = Get.find<StateManager>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlayPro(
        isLoading: _controller.isLoading.value,
        child: Stack(
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
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
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
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
                  ],
                ),
              ),
              panelBuilder: (sc) => _panel(sc),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
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
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: const LoginForm(),
    );
  }
}
