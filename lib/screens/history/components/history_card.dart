import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/history/history_model.dart';


class HistoryCard extends StatelessWidget {
  final HistoryModel history;
  const HistoryCard({ Key? key, required this.history }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      height: 256,
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            image: "${history.image ?? ""}",
            fit: BoxFit.cover,
            imageErrorBuilder: (context, stack, erro) {
              return Image.asset(
                "assets/images/placeholder.png", 
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
                height: MediaQuery.of(context).size.height * 0.1,
              );
            },
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            repeat: ImageRepeat.noRepeat,
          ),
          const SizedBox(height: 10.0),
          Text(
            "${history.title ?? "" }", 
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10.0),
          Text("${history.summary}".length > 48 ? "${history.summary}".substring(0, 50) + "..." : "${history.summary}"),
        ],
      ),
    );
  }
}