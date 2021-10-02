import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'model/product.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState()=>_SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool pet = false;
  bool nokiz = false;
  bool free = false;

  DateTime selectedDate = DateTime.now().toLocal();
  DateTime date = DateTime.now().toLocal();

  String dateFormat = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now().toLocal());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
         child: Text('Search'),
        ),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ExpansionTile(
                          title: Text("Filter"),
                          subtitle: Text("select filter"),
                          children: <Widget>[
                            CheckboxListTile(
                              title: Text('No Kids Zone'),
                              value: nokiz,
                              onChanged: (val) {
                                setState(() {
                                  nokiz = val;
                                });
                                },
                            ),
                            CheckboxListTile(
                              title: Text('Pet-Friendly'),
                              value: pet,
                              onChanged: (val) {
                                setState(() {
                                  pet = val;
                                });
                                },
                            ),
                            CheckboxListTile(
                              title: Text('Free Breakfast'),
                              value: free,
                              onChanged: (val2) {
                                setState(() {
                                  free = val2;
                                });
                                },
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 18,
                        ),
                        Text('  Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                              textAlign: TextAlign.start,
                        ),
                       Container(
                         padding :  EdgeInsets.fromLTRB(20, 10, 10, 10),
                         child :Row(
                           children: <Widget>[
                             Column(
                               children: <Widget>[
                                 Row(
                                   children: [
                                     Icon(Icons.calendar_today,
                                       color: Colors.red,
                                     ),
                                     Text('check - in'),
                                   ],
                                 ),
                                 Text(
                                   DateFormat('yyyy.MM.dd.(EEE)').format(selectedDate),
                                 ),
                                 Text(
                                     DateFormat('hh:mm').format(selectedDate),
                                 )
                               ],
                             ),
                             Flexible(
                               flex: 7,
                               child: SizedBox(
                                 width: 150.0,
                               ),
                             ),
                             RaisedButton(
                               onPressed: () =>buildMaterialDatePicker(context) ,
                               child: Text("Select date"),
                             )

                           ],
                         ),
                       ),
                      ],
                    ),
                  );
                },
              ),

              RaisedButton(
                onPressed: () => _showMyDialog(),
                child: Text("SEARCH"),
              )

            ],
          )),
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _showMyDialog() async {
    String want="";
    if (nokiz == true){

        want = want +"No Kids Zone/";
    }
    if(pet == true){

        want = want +"Pet-Friendly/";

    }
    if(free == true){
        want = want +"Free Breakfast/";
    }
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Please Check \nyour choice :)',
              style: TextStyle(color: Colors.white),),
            color: Colors.blue,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Column(

                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_sharp,
                          color: Colors.blue,
                        ),
                        Expanded(
                            child:Text(
                              want,
                              maxLines: 2,
                              //overflow: TextOverflow.fade,
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.blue,
                        ),
                        Text(
                          "IN ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child:Text(
                              DateFormat('yyyy.MM.dd.(EEE)').format(selectedDate),
                              maxLines: 2,
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children : [


                          RaisedButton(
                            //padding: EdgeInsets.fromLTRB(0, 0, 100.0, 0),
                            child: Text('Search'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.blue,
                          ),



                          FlatButton(
                            //padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),

                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),

        );
      },
    );
  }


}



