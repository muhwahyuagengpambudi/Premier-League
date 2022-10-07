import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/Detail.dart';
import 'package:flutter_application_6/Favorite.dart';
import 'package:flutter_application_6/PremierLeagueModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ListAllFootbal extends StatefulWidget {
  const ListAllFootbal({Key? key}) : super(key: key);

  @override
  State<ListAllFootbal> createState() => _ListAllFootbalState();
}

class _ListAllFootbalState extends State<ListAllFootbal> {
  PremierLeagueModel? premiereLeagueModel;
  bool isloaded = true;

  void getAllListPL() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"),
    );
    print("status code " + res.statusCode.toString());
    premiereLeagueModel =
        PremierLeagueModel.fromJson(json.decode(res.body.toString()));
    print("team 0 : " + premiereLeagueModel!.teams![0].strTeam.toString());
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListPL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 70, 206),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //memanggil fungsi diatas
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePremier(),
                    ));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
        ],
        centerTitle: true,
        title: Text(
          'Premier League',
        ),
        backgroundColor: Color.fromARGB(255, 20, 70, 206),
        elevation: 0,
      ),
      body: isloaded
          ? Container(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    SizedBox(
                      child: ImageSlideshow(
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: "Image/Loading.gif",
                            image:
                                ('https://media.contentapi.ea.com/content/www-easports/en_US/fifa/club-packs/_jcr_content/par/mediablockgrid/mediaBlocks/imageabove/image.img.jpg'),
                            fit: BoxFit.fitWidth,
                          ),
                          FadeInImage.assetNetwork(
                            placeholder: "Image/Loading.gif",
                            image:
                                ('https://media.contentapi.ea.com/content/www-easports/en_US/fifa/club-packs/_jcr_content/par/mediablockgrid/mediaBlocks/imageabove_copy/image.img.jpg'),
                            fit: BoxFit.fitWidth,
                          ),
                          FadeInImage.assetNetwork(
                            placeholder: "Image/Loading.gif",
                            image:
                                ('https://media.contentapi.ea.com/content/www-easports/en_US/fifa/club-packs/_jcr_content/par/mediablockgrid/mediaBlocks/imageabove_1851301445/image.img.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                        autoPlayInterval: 5000,
                        isLoop: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Flexible(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: premiereLeagueModel!.teams!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                  teams: premiereLeagueModel!
                                                      .teams![index],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 3),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                width: 50,
                                                height: 50,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "Image/Loading.gif",
                                                  image: premiereLeagueModel!
                                                      .teams![index]
                                                      .strTeamBadge
                                                      .toString(),
                                                )),
                                            SizedBox(
                                              width: 190,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(premiereLeagueModel!
                                                      .teams![index].strTeam
                                                      .toString()),
                                                  Text(premiereLeagueModel!
                                                      .teams![index].strLeague
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                            Image.asset(
                                              'Image/RatingBintang.png',
                                              width: 60,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
