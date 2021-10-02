import 'package:flutter/material.dart';

import 'my-globals.dart' as globals;

class FavoritePage extends StatefulWidget {

  FavoritePage({Key key,}) : super(key: key);
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //final  saved = Set<String>();


  @override
  Widget build(BuildContext context) {

    final tiles = globals.saved.map(
          (String pair) {
        return ListTile(
          title: Text(
            pair,
            style: _biggerFont,
          ),
        );
      },
    );
    List x = globals.saved.toList();
    List xx = globals.product.toList();



      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'back',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text('Favorite Hotels'),
          ),
        ),
        body:  ListView.builder(
          itemCount: globals.saved.length,
          itemBuilder: (context, index) {
            final item = x[index];
            final itemS = xx[index];


            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  x.removeAt(index);
                  globals.saved.remove(item);
                  globals.product.remove(itemS);

                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      );

  }
}