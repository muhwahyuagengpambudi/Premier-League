import 'package:flutter/material.dart';
import 'package:flutter_application_6/PremierLeagueModel.dart';
import 'package:flutter_application_6/listAllFootball.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:readmore/readmore.dart';
import 'dart:async';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.teams}) : super(key: key);
  Teams teams;

  @override
  State<Detail> createState() => _DetailState();
}

Widget textView(String name) {
  return Container(
    child: Text(
      name,
      style: TextStyle(color: Colors.black),
    ),
  );
}

class _DetailState extends State<Detail> {
  String dropdownvalue = 'English';
  String? description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    description = widget.teams.strDescriptionEN;
  }

  // List of items in our dropdown menu
  var items = [
    'English',
    'Rusia',
    'Francis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 233, 233),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 235, 233, 233),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 20, 70, 206),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: Text(
            widget.teams.strTeam.toString(),
            style: TextStyle(color: Color.fromARGB(255, 20, 70, 206)),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: "Image/Loading.gif",
                    image: widget.teams.strTeamBanner.toString(),
                    width: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder: "Image/Loading.gif",
                                  image: widget.teams.strTeamBadge.toString(),
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.teams.strTeam.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            SizedBox(height: 3),
                                            Text(widget.teams.strTeamShort
                                                .toString()),
                                            SizedBox(height: 3),
                                            Text("IdTeam : " +
                                                widget.teams.idTeam.toString()),
                                            SizedBox(height: 3),
                                            Text("Country : " +
                                                widget.teams.strCountry
                                                    .toString()),
                                            SizedBox(height: 3),
                                            Text("Year Formed : " +
                                                widget.teams.intFormedYear
                                                    .toString())
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 3),
                              child: Row(
                                children: [
                                  Text(
                                    "Description : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton(
                                    value: dropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        // Changing the value of dropdown
                                        dropdownvalue = newValue!;
                                        if (dropdownvalue == "English") {
                                          description = widget
                                                  .teams.strDescriptionEN ??
                                              "No description for this language";
                                        } else if (dropdownvalue == "Rusia") {
                                          description = widget
                                                  .teams.strDescriptionRU ??
                                              "No description for this language";
                                        } else if (dropdownvalue == "Francis") {
                                          description = widget
                                                  .teams.strDescriptionFR ??
                                              "No description for this language";
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 300,
                                child: ReadMoreText(
                                  description.toString(),
                                  trimLines: 2,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                  lessStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            placeholder: "Image/Loading.gif",
                            image: widget.teams.strStadiumThumb.toString(),
                            width: 400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.teams.strStadium.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Location : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 235,
                                    child: Text(widget.teams.strStadiumLocation
                                        .toString()),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Capacity : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(widget.teams.intStadiumCapacity
                                      .toString())
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Description : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                  width: 300,
                                  child: ReadMoreText(
                                    widget.teams.strStadiumDescription
                                        .toString(),
                                    trimLines: 2,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                    lessStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sosial Media : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse("https://" +
                                      widget.teams.strTwitter.toString()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      image:
                                          AssetImage("Image/Logo/twitter.png")),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse("https://" +
                                      widget.teams.strYoutube.toString()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                    image: AssetImage("Image/Logo/YT.png"),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse("https://" +
                                      widget.teams.strInstagram.toString()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      image: AssetImage(
                                          "Image/Logo/instagram.png")),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse("https://" +
                                      widget.teams.strFacebook.toString()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                    image:
                                        AssetImage("Image/Logo/facebook.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
