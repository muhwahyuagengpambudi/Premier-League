import 'package:flutter/material.dart';
import 'PremierLeagueModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Detail.dart';

class FavoritePremier extends StatefulWidget {
  FavoritePremier({Key? key}) : super(key: key);

  @override
  State<FavoritePremier> createState() => _FavoritePremierState();
}

class _FavoritePremierState extends State<FavoritePremier> {
  var database;

  List<Teams> teamfav = <Teams>[];

  Future initDb() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'teams_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE teams(idTeam TEXT, strTeam TEXT, Logo TEXT , League TEXT , Banner TEXT , Stadium TEXT , Stadium1 TEXT , Rusia TEXT , English TEXT , Francis TEXT , TeamShort TEXT , Country TEXT , intFormedYear TEXT , StadiumLocation TEXT, StadiumCapacit TEXT , StadiumDescription TEXT)',
        );
      },
      version: 1,
    );

    getTeamfav().then((value) {
      setState(() {
        teamfav = value;
      });
    });
  }

  Future<List<Teams>> getTeamfav() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('teams');

    return List.generate(maps.length, (i) {
      return Teams(
          idTeam: maps[i]['idTeam'],
          strTeamBadge: maps[i]['Logo'],
          strTeam: maps[i]['strTeam'],
          strLeague: maps[i]['League'],
          strTeamBanner: maps[i]['Banner'],
          strStadium: maps[i]['Stadium'],
          strStadiumThumb: maps[i]['Stadium1'],
          strDescriptionEN: maps[i]['English'],
          strDescriptionFR: maps[i]['Francis'],
          strDescriptionRU: maps[i]['Rusia'],
          strTeamShort: maps[i]['TeamShort'],
          strCountry: maps[i]['Country'],
          intFormedYear: maps[i]['intFormedYear'],
          strStadiumLocation: maps[i]['StadiumLocation'],
          intStadiumCapacity: maps[i]['StadiumCapacit'],
          strStadiumDescription: maps[i]['StadiumDescription']);
    });
  }

  Future<void> deleteteams(String? idTeam) async {
    final db = await database;
    await db.delete(
      'teams',
      where: 'idTeam = ?',
      whereArgs: [idTeam],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite',
        ),
        backgroundColor: Color.fromARGB(255, 20, 70, 206),
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
                          teams: teamfav[index],
                        )),
              ).then((value) => initDb());
              ;
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 50,
                              height: 50,
                              child: FadeInImage.assetNetwork(
                                placeholder: "Image/Loading.gif",
                                image: teamfav[index].strTeamBadge.toString(),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      teamfav[index].strTeam.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    teamfav[index].strLeague.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 80),
                            child: InkWell(
                              onTap: () {
                                deleteteams(teamfav[index].idTeam)
                                    .then((value) {
                                  getTeamfav().then((value) {
                                    setState(() {
                                      teamfav = value;
                                    });
                                  });
                                });
                              },
                              child: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: teamfav.length,
      ),
    );
  }
}
