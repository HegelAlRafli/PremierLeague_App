import 'package:flutter/material.dart';
import 'package:premierleague/PremierLeagueModel.dart';
import 'package:premierleague/page/detail.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.teams}) : super(key: key);
  Teams teams;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _launchInBrowser(String url) async {
    if (!await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(widget.teams.strDescriptionEN.toString()),
                InkWell(
                    onTap: () {
                      var myUrl =
                          "https://" + widget.teams.strYoutube.toString();
                      _launchInBrowser(myUrl);
                    },
                    child: Icon(Icons.play_arrow))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
