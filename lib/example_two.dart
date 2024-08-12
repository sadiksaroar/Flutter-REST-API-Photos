import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = []; 

  Future<List<Photos>> getPhotos ()async{
    // Api call head 
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    // response decode 
    var data = jsonDecode(response.body.toString());
    print(data);
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot <List<Photos>> snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle: Text(snapshot.data![index].id.toString()),
                  title: Text('Notes Id:'+snapshot.data![index].title.toString()),
               );
              });
            },),
          ),
          // Expanded(
          //   flex: 2,
          //   child: FutureBuilder(
          //     future: getPhotos(),
          //     builder: (context, snapshot){
          //     return ListView.builder(
          //       itemCount: photosList.length,
          //       itemBuilder: (context, index){
          //       return ListTile(
          //         title: Text("Expanded")
          //      );
          //     });
          //   },),
          // )
        ],
      ),
    );
  }
}

class Photos{
  String title, url;
  int id;

  Photos({
    required this.title,
    required this.url,
    required this.id
  });
}