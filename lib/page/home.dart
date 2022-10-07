import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:premierleague/PremierLeagueModel.dart';
import 'package:premierleague/page/detail.dart';
import 'package:premierleague/page/fav.dart';
import 'package:premierleague/page/splashscreen.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  PremierLeagueModel? premierLeagueModel;
  bool loadingbgproses = true;

  void getAllistPL() async {
    setState(() {
      loadingbgproses = false;
    });
    final res = await http.get(Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"));
    print("status code " + res.statusCode.toString());
    premierLeagueModel =
        PremierLeagueModel.fromJson(json.decode(res.body.toString()));
    print("team 0 : " + premierLeagueModel!.teams![0].strTeam.toString());
    setState(() {
      loadingbgproses = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllistPL();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: loadingbgproses
            ? Scaffold(
                body: SingleChildScrollView(
                  child: Center(
                      child: Container(
                    color: Color(0xFF37003C),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 270,
                          child: Stack(
                            children: [
                              Image(
                                image:
                                    AssetImage("assets/premierleaguethumb.png"),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: double.infinity,
                                color: Color(0xFF37003C).withOpacity(0.2),
                              ),
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "2022/2023",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "This Is Premier League",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Color(0xFFF9F9F9),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "2022/2023 EPL Teams",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFCF2970),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => favPage(),
                                          )),
                                      child: Container(
                                        child: Icon(
                                          Icons.bookmarks_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                      height: 510,
                                      width: double.infinity,
                                      child: loadingbgproses
                                          ? ListView.builder(
                                              itemCount: premierLeagueModel!
                                                  .teams!.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return detail(
                                                            teams:
                                                                premierLeagueModel!
                                                                        .teams![
                                                                    index],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        padding:
                                                            EdgeInsets.all(30),
                                                        width: 315,
                                                        height: 110,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.04),
                                                                offset: Offset(
                                                                    0.0,
                                                                    4.0), //(x,y)
                                                                blurRadius: 4.0,
                                                              )
                                                            ]),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: 45,
                                                              height: 50,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          30),
                                                              child: FadeInImage
                                                                  .assetNetwork(
                                                                      placeholder:
                                                                          'assets/greyepllogo.png',
                                                                      image:
                                                                          "${premierLeagueModel!.teams![index].strTeamBadge.toString()}"),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  premierLeagueModel!
                                                                      .teams![
                                                                          index]
                                                                      .strTeam
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  width: 150,
                                                                  child: Text(
                                                                    premierLeagueModel!
                                                                        .teams![
                                                                            index]
                                                                        .strKeywords
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    "Since : " +
                                                                        premierLeagueModel!
                                                                            .teams![index]
                                                                            .intFormedYear
                                                                            .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            Transform.rotate(
                                                              angle: 180 *
                                                                  pi /
                                                                  180,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_back_ios_new_rounded,
                                                                size: 17,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Container(
                                                child: Text(
                                                  "Loading...",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              )
            : splashscreen());
  }
}
