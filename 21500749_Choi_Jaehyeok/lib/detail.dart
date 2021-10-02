import 'package:flutter/material.dart';
import 'model/product.dart';
import 'my-globals.dart' as globals;
import 'mypage.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final ValueChanged<int> update;
  DetailPage({Key key, @required this.product, @required this.update}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //final Set<String> saved = Set<String>();

  //_DetailPageState({Key key, @required this.product}) : super(Product: product);

  //DetailPage({Key key, @required this.product}) : super(key: key);

  List<Icon>_starsForRatings(Product product) {
    List<Icon> stars = [];
    for(int i = 0; i < product.star; i++){
      stars.add(Icon(Icons.star,
        size: 32.0,
        color: Colors.yellow,
      ));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context){

    final ThemeData theme = Theme.of(context);
    final alreadySaved = globals.saved.contains(widget.product.name);
    return  Scaffold(
      appBar: AppBar(
        leading:
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              semanticLabel: 'Go back',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
       title: Center(
         child: Text('Detail' , textAlign: TextAlign.center)
       ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
          child: ListView(

            children: <Widget>[
              Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.product.assetName,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  body: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: Hero(
                                      tag : widget.product.assetName,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          child: Image.asset(
                                              widget.product.assetName,
                                              scale: 1.0,
                                              fit: BoxFit.fitWidth,

                                          ),
                                          onTap: (){
                                            Navigator.pop(context);
                                          }
                                      ),
                                      ),

                                    )
                                  ),
                                );
                              }
                          ),
                          );
                        },
                        onDoubleTap:() {
                          setState((){
                            //ColorDefinition.of(context);
                            if(alreadySaved){
                              globals.saved.remove(widget.product.name);
                              globals.product.remove(widget.product);
                              widget.update(1);
                            }
                            else{
                              globals.saved.add(widget.product.name);
                              globals.product.add(widget.product);
                              widget.update(1);
                            }
                          }
                          );
                          //print(globals.saved);
                        },



                          child : Image.asset(
                            widget.product.assetName,
                            scale: 1.0,
                            fit: BoxFit.fitWidth,
                          ),

                      ),
                    ),
                  ),
                  new Positioned(
                    right: 10.0,
                    top: 10.0,
                    child: new Icon(Icons.favorite,
                    color: alreadySaved ? Colors.red : Colors.white),
                  ),
                ],
              ),


              Row(
                children: _starsForRatings(widget.product),
              ),
              Text(widget.product.name,
              textAlign:  TextAlign.start,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
              Row(

                children: [
                  Icon(Icons.location_on),
                  Text(
                    widget.product.location,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  Text(
                    widget.product.phone,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Text(
                widget.product.explain,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
      ),
    );
  }


}