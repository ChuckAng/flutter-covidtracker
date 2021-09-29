import 'package:flutter/material.dart';
import 'dart:math' as math;

class Symptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: _buildContent(height),
    );
  }

  Widget _buildContent(double height) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          ClipPath(
            clipper: Myclipper(),
            child: _buildHeader(height: height),
          ),
          Column(
            children: [
              Text(
                'Symptoms',
                style: TextStyle(
                    fontFamily: 'Synemono',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSymptomsCard('assets/cough.png', 'Cough'),
                  _buildSymptomsCard('assets/fever.png', 'Fever'),
                  _buildSymptomsCard('assets/headache.png', 'Headache'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Prevention Tips',
                style: TextStyle(
                    fontFamily: 'Synemono',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildTipsCard(
                imgPath: 'assets/distance.png',
                title: 'Social distancing',
                desc:
                    'stay at least 6 feet from other people \nwho are not from your household.',
              ),
              _buildTipsCard(
                imgPath: 'assets/wash_hands.png',
                title: 'Wash hands',
                desc:
                    'Wash your hands with soap and water\n for at least 20 seconds.',
              ),
              _buildTipsCard(
                imgPath: 'assets/mask.png',
                title: 'Wear mask',
                desc:
                    'Masks are a simple barrier to help \nprevent your respiratory droplets \nfrom reaching others.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsCard(String img, String txt) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(0, 8), blurRadius: 10, spreadRadius: -15),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(img),
          Text(
            txt,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _buildTipsCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String desc;
  const _buildTipsCard({
    Key key,
    this.imgPath,
    this.title,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTipsInfo(context);
  }

  SizedBox _buildTipsInfo(BuildContext context) {
    return SizedBox(
      height: 156,
      child: Stack(
        children: [
          Container(
            height: 136,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5), blurRadius: 25, spreadRadius: -15)
                ]),
          ),
          Image.asset(
            imgPath,
            height: 120,
          ),
          Positioned(
            left: 100,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              height: 136,
              width: MediaQuery.of(context).size.width - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      desc,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildHeader extends StatelessWidget {
  const _buildHeader({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return _buildHeaderBG();
  }

  Widget _buildHeaderBG() {
    return Container(
      height: height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[900], Colors.purple[700]]),
      ),
      child: Stack(
        children: [
          Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.rotationY(math.pi),
            child: Image(
              image: ExactAssetImage('assets/virus.png'),
              color: Colors.white,
            ),
          ),
          Positioned(
            right: -40,
            top: 20,
            bottom: 50,
            child: Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.rotationY(math.pi),
              child: Image(
                image: ExactAssetImage('assets/femaleNurse.png'),
                height: 250,
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: 60,
            bottom: 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Things to know \nabout covid-19\npandemic.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Synemono'),
              ),
            ),
          )
        ],
      ),
    );
  }
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
