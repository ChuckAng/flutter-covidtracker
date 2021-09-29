import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:malaysia_covid_tracker/stats_grid/stats_grid_MYSG.dart';
import 'package:malaysia_covid_tracker/symptoms.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map malaysiaData;
  Map singaporeData;

  final formatter = new DateFormat('dd-MM-yyyy');

  fetchMalaysiaData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries/Malaysia');
    setState(() {
      malaysiaData = json.decode(response.body);
    });
  }

  fetchSingaporeData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/countries/Singapore');
    setState(() {
      singaporeData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    await Future.delayed(Duration(seconds: 3));
    fetchMalaysiaData();
    fetchSingaporeData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
         
         fetchMalaysiaData();
         fetchSingaporeData();
         
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        strokeWidth: 3.5,
        displacement: 100,
      child: _buildHomeContent(screenHeight, context)
      ),
      
    );
  }


  Widget _buildHomeContent(double screenHeight, BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          ClipPath(
            clipper: Myclipper(),
            child: _buildTopBg(screenHeight, context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Case Update',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Synemono',
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatter.format(new DateTime.now()),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Synemono',
                          fontWeight: FontWeight.bold),
                    ),
                    OutlineButton(
                      highlightElevation: 5,
                      borderSide: BorderSide(color: Colors.black54),
                      highlightedBorderColor: Colors.blue,
                      child: Text('Symptoms',
                          style: TextStyle(
                            fontFamily: 'Synemono',
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Symptoms()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          malaysiaData == null
            ? CircularProgressIndicator(
              backgroundColor: Colors.blue[200],
              valueColor: AlwaysStoppedAnimation(Colors.red[200]),
              
            )
            : StatsGridMYSG(
                malaysiaData: malaysiaData,
                singaporeData: singaporeData,
                swap: true,
              ),
          
      
        ],
      ),
    );
  }
}

Widget _buildTopBg(double height, BuildContext context) {
  return Container(
    height: height * .4,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ]),
    ),
    child: Stack(
      children: [
        Image(
          image: ExactAssetImage('assets/virus.png'),
          color: Colors.white,
        ),
        Positioned(
          right: -10,
          left: 170,
          top: 20,
          bottom: 50,
          child: Image(
            image: ExactAssetImage('assets/nursepng.png'),
            height: 250,
          ),
        ),
        Positioned(
          top: 155,
          left: 50,
          child: Text(
            'All you need \nis stay at home.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Synemono'),
          ),
        )
      ],
    ),
  );
}

class Myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
