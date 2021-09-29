import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

class StatsGridMYSG extends StatefulWidget {
  final Map malaysiaData;
  final Map singaporeData;
  final bool swap;

  const StatsGridMYSG({
    Key key,
    this.malaysiaData,
    this.singaporeData,
    this.swap,
  }) : super(key: key);

  @override
  _StatsGridMYSGState createState() => _StatsGridMYSGState();
}

class _StatsGridMYSGState extends State<StatsGridMYSG> {
  bool _swap;

  @override
  void initState() {
    _swap = widget.swap;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String todayCases;
    String confirmed;
    String recovered;
    String active;
    String deaths;

    if (_swap) {
      todayCases = widget.malaysiaData['todayCases'].toString();
      confirmed = widget.malaysiaData['cases'].toString();
      recovered = widget.malaysiaData['recovered'].toString();
      active = widget.malaysiaData['active'].toString();
      deaths = widget.malaysiaData['deaths'].toString();
    } else {
      todayCases = widget.singaporeData['todayCases'].toString();
      confirmed = widget.singaporeData['cases'].toString();
      recovered = widget.singaporeData['recovered'].toString();
      active = widget.singaporeData['active'].toString();
      deaths = widget.singaporeData['deaths'].toString();
    }

    var screenHeight = MediaQuery.of(context).size.height;
    return _buildCasesContent(screenHeight, context, todayCases, confirmed, recovered, active, deaths);
  }

  Widget _buildCasesContent(double screenHeight, BuildContext context, String todayCases, String confirmed, String recovered, String active, String deaths) {
    return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    height: screenHeight * .45,
    width: double.infinity,
    child: Column(
      children: [
        _buildBubbleTab(context),
        SizedBox(height: 10),
        Flexible(
          child: Row(
            children: [
              _buildStatCard('Today Cases', todayCases, Colors.blue[200],
                  Colors.blue[900]),
              _buildStatCard(
                  'Confirmed', confirmed, Colors.grey[400], Colors.grey[800]),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              _buildStatCard('Recovered', recovered, Colors.green[200],
                  Colors.green[800]),
              _buildStatCard(
                  'Active', active, Colors.orange[200], Colors.orange[900]),
              _buildStatCard(
                  'Deaths', deaths, Colors.red[300], Colors.red[50]),
            ],
          ),
        ),
      ],
    ),
  );
  }

  Widget _buildBubbleTab(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          indicator: BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white38,
            indicatorHeight: 40,
          ),
          labelStyle: TextStyle(
              fontFamily: 'Synemono',
              fontSize: 16,
              fontWeight: FontWeight.w600),
          labelColor: Colors.white,
          tabs: [Text('Malaysia'), Text('Singapore')],
          onTap: (index) {
            setState(() {
              if (index == 0) {
                _swap = true;
              } else {
                _swap = false;
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, Color color, Color textcolor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textcolor),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                count,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textcolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
