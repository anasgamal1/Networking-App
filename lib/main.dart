import 'package:flutter/material.dart';
import 'package:networking_app/models/NewsResponse.dart';
import 'package:networking_app/services/new_services-api.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Find inserting article and news',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<List<Article>>(
                  future: NewsApiServices().fetchNewsArticle(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(7),
                            child: ListTile(
                              onTap: () async {
                                await canLaunch(snapshot.data[index].url)
                                    ? await launch(snapshot.data[index].url)
                                    : throw 'Could not launch ${snapshot.data[index].url}';
                              },
                              title: Text(
                                snapshot.data[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                snapshot.data[index].description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: snapshot.data[index].urlToImage != null
                                  ? Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].urlToImage),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        },
                      );
                    } //else
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
