import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi/detail.dart';
import 'package:newsapi/newsmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Newsapi> getdata() async {
    final response = await http.get(
        Uri.parse(
            "https://bing-news-search1.p.rapidapi.com/news?params={safeSearch: 'Off', textFormat: 'Raw'}"),
        headers: {
          "x-rapidapi-host": "bing-news-search1.p.rapidapi.com",
          "x-rapidapi-key": "f82794c2b6mshab245fc2cc1c39ap11bb76jsncde860427989"
        });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Newsapi.fromJson(data);
    } else {
      return Newsapi.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "News",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<Newsapi>(
                  future: getdata(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return ListView.builder(
                          itemCount: snapshots.data!.value!.length,
                          itemBuilder: (constext, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detailpage(
                                            data: snapshots
                                                .data!.value![index])));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 400,
                                    // width: 600,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            // fit: BoxFit.cover,
                                            image: NetworkImage(snapshots
                                                .data!
                                                .value![index]
                                                .image!
                                                .thumbnail!
                                                .contentUrl
                                                .toString()))),
                                  ),
                                  ListTile(
                                    title: Text(snapshots
                                        .data!.value![index].name
                                        .toString()),
                                    subtitle: Text(snapshots
                                        .data!.value![index].datePublished
                                        .toString()),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
