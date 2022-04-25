import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Detailpage extends StatefulWidget {
  final data;

  const Detailpage({Key? key, required this.data}) : super(key: key);
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Webpage",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget
                          .data.image!.thumbnail!.contentUrl
                          .toString()))),
            ),
            Text(widget.data.description)
          ],
        ));
  }
}
