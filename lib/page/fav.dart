import 'dart:math';
import 'package:flutter/material.dart';
import 'package:premierleague/PremierLeagueModel.dart';
import 'package:premierleague/favDB.dart';
import 'package:premierleague/favModel.dart';

class favPage extends StatefulWidget {
  favPage({Key? key}) : super(key: key);

  @override
  State<favPage> createState() => _favPageState();
}

class _favPageState extends State<favPage> {
  List<FavoriteModel> dataListFavorite = [];
  bool isLoading = false;
  Future read() async {
    setState(() {
      isLoading = true;
    });
    dataListFavorite = await FavDatabase.instance.readAll();
    print("Length List " + dataListFavorite.length.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  showDeleteDialog(BuildContext context, String? name) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = TextButton(
        child: Text("Hapus"),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await FavDatabase.instance.delete(name);
          read();
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Apakah anda yakin ingin menghapus?"),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Favorite Teams"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 25, right: 25, top: 10),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : dataListFavorite.length == 0
                  ? Center(
                      child: Text("Kamu tidak memiliki tim Favorit"),
                    )
                  : ListView.builder(
                      itemCount: dataListFavorite.length,
                      itemBuilder: (c, index) {
                        final item = dataListFavorite[index];
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(30),
                          width: 315,
                          height: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  offset: Offset(0.0, 4.0), //(x,y)
                                  blurRadius: 4.0,
                                ),
                              ]),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 45,
                                height: 50,
                                margin: EdgeInsets.only(right: 30),
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/greyepllogo.png',
                                    image: item.image),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    width: 150,
                                    child: Text(
                                      item.julukan,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Text(
                                      "Since : " + item.since,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  showDeleteDialog(context, item.name);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
