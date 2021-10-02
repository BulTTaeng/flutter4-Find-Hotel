import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'detail.dart';
import 'favorite_Hotel.dart';

import 'package:url_launcher/url_launcher.dart';

//import 'dart:html' as html;

const _url = 'https://www.handong.edu/';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: Add a variable for Category (104)
  List<Product> products = ProductsRepository.loadProducts();
  int _x=0;
  void _update(int x) {
    setState(() => _x = x);
  }

  List<Card> _buildGridCards(BuildContext context) {
    //List<Product> products = ProductsRepository.loadProducts();

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {

      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
          child : Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 15.5 / 8.5,
              child: Image.asset(
                product.assetName,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)

                  children: <Widget>[
                    Row(
                      children: _starsForRatings(product),
                    ),
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16.0),
                      maxLines: 1,
                      //textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.0 ),
                        Text(
                          product.location,
                          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
                          maxLines: 2,
                        ),

                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                        child: Text('More'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPage(product: product, update : _update))
                          );
                          //print(product.name);
                        },
                        height: 5.0,
                        minWidth: 5.0,
                      ),
                    ],
                    ),
                  ],
                ),

            ),
          ],
        ),

      );
    }).toList();
  }

  List<Icon>_starsForRatings(Product product) {
    List<Icon> stars = [];
    for(int i = 0; i < product.star; i++){
      stars.add(Icon(Icons.star,
        size: 14.0,
        color: Colors.yellow,
      ));
    }
    return stars;
  }

  List<Card> _bbuildGridCards(BuildContext context) {
    //List<Product> products = ProductsRepository.loadProducts();

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return Card(

      child: ListTile(
          leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 128,
            minHeight: 300,
            maxWidth: 160,
            maxHeight: 400,
          ),
          child: Image.asset(
            product.assetName,
            scale: 10.0,
            fit: BoxFit.fitWidth,
          ),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: _starsForRatings(product),
            ),
            Text(
              product.name,
              style: theme.textTheme.headline6,
              maxLines: 1,

            ),
          ],
        ),

        subtitle: Container(
        child : Column(
        children : [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //Icon(Icons.location_on_outlined),
              Text(
                product.location,
                style: theme.textTheme.subtitle2,
                //textAlign: TextAlign.end,
                ),
              FlatButton(
                child: Text('More'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailPage(product: product , update: _update,))
                  );
                },
                height: 10.0,
                minWidth: 10.0,
              ),
              ],
            ),

          ],
          ),
        ),
        ),
      );
    }).toList();
  }


  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    final isSelected = <bool>[false, false];

    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: Text('HOME' , textAlign: TextAlign.center),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'HGU site',
            ),
            onPressed: () {
              _launchURL();
              //html.window.open(_url, '');
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(

              child: Container(
                child: Text('Pages',
                    style: TextStyle(color: Colors.white, fontSize: 26 ),
                    textAlign: TextAlign.justify),
                alignment: Alignment.bottomLeft,
                      ),
              decoration: BoxDecoration(
                color: Colors.blue,

              ),

            ),
            ListTile(
              leading: Icon(Icons.home , color: Colors.blue),
              title: Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.blue),
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city, color: Colors.blue),
              title: Text('Favorite Hotel'),
              onTap: () {
                Navigator.pushNamed(context, '/favorite');
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('My Page'),
              onTap: () {
                Navigator.pushNamed(context, '/mypage');
              },
            ),
          ],
        ),// Populate the Drawer in the next step.
      ),

      body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children : <Widget> [
          new Flexible(
            child: ToggleButtons(
              color: Colors.black,
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.blue,
              fillColor: Colors.blue,
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              hoverColor: Colors.blue,
              borderRadius: BorderRadius.circular(4.0),
              constraints: BoxConstraints(minHeight: 60.0, minWidth: 60.0),
              isSelected: isSelected,
              onPressed: (index) {
                setState(() {
                  if(index ==0){
                    //isSelected[0] = true;
                    //isSelected[1] = false;
                    isGridView = false;
                  }
                  else if(index == 1){
                    //isSelected[1] = true;
                    //isSelected[0] = false;
                    isGridView = true;
                  }
                });
              },
              children: [
                Icon(Icons.format_list_bulleted),
                Icon(Icons.grid_view),
              ],
            ),
          ),
          new Expanded(

            flex: 11,
            child: isGridView ? OrientationBuilder(
              builder: (context, orientation){
                return GridView.count(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  padding: EdgeInsets.all(1.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: _buildGridCards(context),
                );
              },
            ): ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index){
                  return new Column(
                    children: _bbuildGridCards(context),
                  );
                },
          ),
          ),


        ],

      )


        ),
        resizeToAvoidBottomInset: false,
      );

  }


}

void _launchURL() async =>
    await launch(_url) ? await launch(_url) : throw 'Could not launch $_url';



