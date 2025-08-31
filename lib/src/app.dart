// import flutter helper library
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import './models/image_model.dart';
import './widgets/image_list.dart';

// Create a class that will be custom widget
// this class must extend the stateless widget base class
class App extends StatefulWidget {
  final Client client;

  const App({super.key, required this.client});
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}


class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
   counter++;
   var result = await widget.client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter')
    );

    var imageModel = ImageModel.fromJson(json.decode(result.body));

    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue.shade900,
          onPrimary: Colors.blueAccent.shade100,
          secondary: Colors.lightBlueAccent,
          onSecondary: Colors.blueGrey,
          error: Colors.red,
          onError: Colors.redAccent.shade100,
          surface: Colors.teal.shade100,
          onSurface: Colors.black,
        ),
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          clipBehavior: Clip.antiAlias,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Let\'s see some images!'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ImageList(images: images),
      ),
    );
  }
}

// must define a 'build' method that returns
// the widgets *this* widget will show
