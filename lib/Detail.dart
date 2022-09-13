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
  bool isEnglish = true;
  bool isRusia = true;
  bool isFrancis = true;

  bool isEnglishdesc = true;
  bool isRusiadesc = true;
  bool isFrancisdesc = true;

  // Initial Selected Value
  String dropdownvalue = 'English';

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
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                        child: Column(
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
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    widget.teams.strTeam
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(widget.teams.strTeamShort
                                                    .toString()),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, bottom: 3),
                                              child: Row(
                                                children: [
                                                  Text("IdTeam : " +
                                                      widget.teams.idTeam
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("Country : " +
                                                    widget.teams.strCountry
                                                        .toString()),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 3),
                                              child: Row(
                                                children: [
                                                  Text("Year Formed : " +
                                                      widget.teams.intFormedYear
                                                          .toString()),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "Description : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        // Changing the value of dropdown
                                        dropdownvalue = newValue!;
                                        if (dropdownvalue == "English") {
                                          isEnglishdesc = true;
                                          isRusiadesc = false;
                                          isFrancisdesc = false;
                                        } else if (dropdownvalue == "Rusia") {
                                          isEnglishdesc = false;
                                          isRusiadesc = true;
                                          isFrancisdesc = false;
                                        } else if (dropdownvalue == "Francis") {
                                          isFrancisdesc = true;
                                          isEnglishdesc = false;
                                          isRusiadesc = false;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                isEnglish
                                    ? Container(
                                        width: 300,
                                        child: ReadMoreText(
                                          isEnglishdesc
                                              ? widget.teams.strDescriptionEN
                                                  .toString()
                                              : isRusiadesc
                                                  ? widget
                                                      .teams.strDescriptionRU
                                                      .toString()
                                                  : isFrancis
                                                      ? widget.teams
                                                          .strDescriptionFR
                                                          .toString()
                                                      : "",
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
                                    : Container()
                              ],
                            )
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
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Location : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 235,
                                      child: Text(widget
                                          .teams.strStadiumLocation
                                          .toString()),
                                    )
                                  ],
                                ),
                              ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Description : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
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
                              )
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
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sosial Media : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
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
