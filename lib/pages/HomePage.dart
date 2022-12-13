import 'package:flutter/material.dart';
import '../components/DarkPainter.dart';
import '../components/ListPopularFilmsWidget.dart';
import '../components/MovieDialog.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0XFF121212),
        body: CustomPaint(
            painter: DarkPainter(),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Text('Movies',
                        style: new TextStyle(
                            fontFamily: 'Comfortaa',
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
                Center(
                  child: Text('Gemini',
                      style: new TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 30,
                          fontWeight: FontWeight.w300)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Go to...'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  title: Text('Popular',
                      style: new TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Colors.white,
                        fontSize: 25,
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                new Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  child: ListPopularFilms(),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            )));
  }
}
