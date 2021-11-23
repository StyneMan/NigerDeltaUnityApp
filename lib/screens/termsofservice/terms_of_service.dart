import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:niger_delta_unity_app/widgets/text/text_widgets.dart';

class TermsOfService extends StatelessWidget {
  TermsOfService({Key? key}) : super(key: key);

  String dummyContent =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et in sed ullamcorper at aliquam eu euismod maecenas. Ut quam enim vestibulum neque. Et sit duis purus, sed lorem. Amet risus aliquam posuere mauris sit quis facilisi nisl suscipit. Dictum eu phasellus sagittis semper aliquam ac. Cursus mauris quis mi augue odio malesuada. Quam urna non vel, eget. Placerat habitant nullam suspendisse varius turpis. Luctus nunc, enim, ac semper. Placerat viverra mi, tristique rhoncus tristique duis ultricies non. Sed aenean dui adipiscing vitae mauris sed nisl. Etiam semper pretium amet, dolor varius. Congue tincidunt odio euismod enim donec in eleifend. Semper mauris sit sed vitae suspendisse cras vulputate. Egestas proin malesuada at aliquet laoreet purus, ut nulla. Id cras neque massa eleifend. Condimentum vel ultrices augue auctor semper. Mauris ipsum risus, consectetur sed. Sit tristique sit vehicula nec pretium enim malesuada facilisis. Mauris a in id et mattis id. Odio ultrices lectus at aliquam, adipiscing aliquam tempus sit mattis. Amet, imperdiet dictum vulputate varius sed ut viverra pellentesque. Nisl molestie dictum suspendisse neque nunc leo imperdiet et. Interdum molestie dui mauris, arcu. Quam suspendisse nisi at egestas auctor. Sagittis a aliquam vitae semper enim id diam velit, imperdiet. At placerat ut adipiscing lacus ac a. Etiam in leo auctor augue sit urna. Ornare rhoncus eget quisque amet. Feugiat sit rutrum neque sapien egestas elit maecenas neque. Id habitasse sed tristique elementum cursus quam lobortis amet tellus. Dui pharetra nunc morbi sed sodales fermentum, faucibus. Enim id turpis sit arcu eleifend suscipit. Viverra elementum pellentesque vitae phasellus gravida vel integer dolor sed. Ornare lectus ante velit rhoncus massa aliquet. Posuere massa integer tempus massa elit, id.";
  String dummyContent2 =
      "Integer et, commodo eleifend mattis feugiat. Vitae, lectus condimentum fringilla varius. Quis sit arcu duis iaculis dictum. Pharetra congue tempor eu porttitor malesuada. Mi aliquam erat luctus eget ornare integer vel. Viverra malesuada consequat scelerisque nisl sollicitudin mauris turpis est. Gravida rutrum lorem massa id aliquam nisi. Vulputate vestibulum praesent pretium id nulla. Aenean id etiam quis varius orci sit ultrices montes, sem. Porta nullam et nulla eget. Aliquam in augue feugiat nibh. Vitae quis volutpat quam dignissim. Elementum velit proin commodo viverra enim etiam eu massa. Ullamcorper tellus aenean vitae nisi, ante arcu, accumsan habitant quisque. Dignissim orci turpis dui lorem velit. Accumsan praesent consectetur nunc magna odio nisl, lacinia est volutpat. Lacinia leo, massa amet blandit morbi quam nibh dui. Orci pretium posuere turpis est turpis lorem in. Commodo nullam nulla blandit fusce gravida leo vel. A, eu convallis maecenas neque augue. Quisque tellus gravida feugiat ut porttitor sit in pellentesque. Justo, massa consequat adipiscing nec enim diam et. Neque dolor sapien nec massa lobortis quisque accumsan. Cras et arcu, sem turpis ut. Viverra.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: MediaQuery.of(context).size.height * 0.33,
      //   elevation: 0,

      //   automaticallyImplyLeading: false,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(24.0),
      //       bottomRight: Radius.circular(24.0),
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/terms_of_service.jpeg',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                  ),
                  Container(
                    color: const Color(0xA60C0C77),
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                  ),
                  Positioned(
                    child: ClipOval(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/images/back_circular.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    top: 48,
                    left: 24,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 48),
                      child: TextRoboto(
                        text: 'Terms of service',
                        fontSize: 24,
                        align: TextAlign.center,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextRoboto(
                text: '$dummyContent$dummyContent2',
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                align: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
