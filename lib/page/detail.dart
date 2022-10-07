import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:premierleague/PremierLeagueModel.dart';
import 'package:premierleague/favDB.dart';
import 'package:premierleague/favModel.dart';
import 'package:url_launcher/url_launcher.dart';

class detail extends StatefulWidget {
  detail({Key? key, this.teams}) : super(key: key);
  Teams? teams;

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  bool checkExist = false;
  Color colorChecked = Colors.grey;

  Future<void> _launchInBrowser(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception("Error");
    }
  }

  Future read() async {
    checkExist = await FavDatabase.instance.read(widget.teams!.strTeam);
    setState(() {});
  }

  Future addData() async {
    var fav;
    fav = FavoriteModel(
        image: widget.teams!.strTeamBadge.toString(),
        name: widget.teams!.strTeam.toString(),
        julukan: widget.teams!.strKeywords.toString(),
        since: widget.teams!.intFormedYear.toString());
    await FavDatabase.instance.create(fav);
    setState(() {
      checkExist = true;
    });
    // Navigator.pop(context);
  }

  Future deleteData() async {
    await FavDatabase.instance.delete(widget.teams!.strTeam);
    setState(() {
      checkExist = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.teams!.strFacebook);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              Container(
                child: Container(
                    height: 250,
                    color: Colors.amber,
                    child: Image(
                        image: NetworkImage(
                            "${widget.teams!.strTeamFanart3.toString()}"),
                        fit: BoxFit.cover)),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.transparent,
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Color(0xFFF9F9F9),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 24),
                                  width: 50,
                                  height: 50,
                                  child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/greyepllogo.png',
                                      image:
                                          "${widget.teams!.strTeamBadge.toString()}"),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.teams!.strTeam.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF37003C)),
                                      ),
                                      Text(
                                        widget.teams!.strKeywords.toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                    icon: Icon(Icons.favorite, size: 30),
                                    color:
                                        checkExist ? Colors.red : colorChecked,
                                    onPressed: () {
                                      checkExist ? deleteData() : addData();
                                    }),
                                // FavoriteButton(
                                //   valueChanged: (_) {
                                //     addData();
                                //   },
                                //   iconSize: 45,
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24, left: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "History",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            margin: EdgeInsets.only(top: 8, left: 5),
                            child: Text(
                              widget.teams!.strDescriptionEN.toString(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, left: 5),
                            child: Text(
                              "Stadium",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8, bottom: 16),
                                width: 200,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(
                                        "${widget.teams!.strStadiumThumb.toString()}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 16, 0, 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 125,
                                      child: Text(
                                        widget.teams!.strStadium.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      width: 125,
                                      margin:
                                          EdgeInsets.only(top: 16, bottom: 8),
                                      child: Text(
                                        "Location : " +
                                            widget.teams!.strStadiumLocation
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      "Capacity : " +
                                          widget.teams!.intStadiumCapacity
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "description : ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            margin: EdgeInsets.only(top: 8, left: 5),
                            child: Text(
                              widget.teams!.strStadiumDescription.toString(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5, top: 8),
                            child: Text(
                              "Follow Our Social Media",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var myUrl = "https://" +
                                        widget.teams!.strFacebook.toString();
                                    _launchInBrowser(myUrl);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 30,
                                    height: 30,
                                    child: Image(
                                        image:
                                            AssetImage("assets/facebook.png")),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    var myUrl = "https://" +
                                        widget.teams!.strInstagram.toString();
                                    _launchInBrowser(myUrl);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    width: 30,
                                    height: 30,
                                    child: Image(
                                        image:
                                            AssetImage("assets/instagram.png")),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    var myUrl = "https://" +
                                        widget.teams!.strTwitter.toString();
                                    _launchInBrowser(myUrl);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    width: 30,
                                    height: 30,
                                    child: Image(
                                        image:
                                            AssetImage("assets/twitter.png")),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    var myUrl = "https://" +
                                        widget.teams!.strYoutube.toString();
                                    _launchInBrowser(myUrl);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    width: 30,
                                    height: 30,
                                    child: Image(
                                        image:
                                            AssetImage("assets/youtube.png")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

launch(String url) {}

canLaunch(String url) {}
