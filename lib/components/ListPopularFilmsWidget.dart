import 'dart:convert';
import 'package:final_proj/components/colors.dart';
import 'package:final_proj/components/MovieDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPopularFilms extends StatefulWidget {
  ListPopularFilmState createState() => new ListPopularFilmState();
}

class ListPopularFilmState extends State<ListPopularFilms> {
  var data;
  void getData() async {
    try {
      var response = await http
          .get(
              Uri.parse(
                  'https://api.themoviedb.org/3/discover/movie?api_key=247d5dd1748fd1a506f5d0143cb6bd07&?sort_by=popularity.desc&language=en'),
              headers: {
                'Content-Type': 'application/json'
              })
          .timeout(new Duration(seconds: 10),
              onTimeout: () =>
                  http.Response(json.encode({'Error': 'Network error'}), 401))
          .catchError(
              (e) => http.Response(json.encode({'Error': e.toString()}), 401));
      setState(() {
        data = json.decode(response.body)['results'];
      });
    } on Exception catch (e) {
      print(e);

      data = [];
    }
  }

  Widget getImage(index) {
    try {
      DecorationImage image = new DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500' + data[index]['poster_path']));
      if (image != null)
        return Container(
          height: 200,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            image: image,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        );
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    } catch (e) {
      print(e);
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) => GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 280,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  color: backgroundCard,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    getImage(index),
                    ListTile(
                      title: Text(
                        data[index]['title'],
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => new MovieDialog(
                        date: data[index]['release_date'],
                        description: data[index]['overview'],
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    data[index]['poster_path'])),
                        rate: data[index]['vote_average'].toString(),
                        title: data[index]['title'],
                      )),
            ),
          );
  }
}
