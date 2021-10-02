import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _textController = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
                child :
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  controller: _textController,

                  decoration: new InputDecoration(
                      border: new UnderlineInputBorder(
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Username'
                  ),
                ),

              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child :
                TextFormField(
                  controller: _textController1,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                      border: new UnderlineInputBorder(
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Password'
                  ),
                ),

              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child :
                TextFormField(
                  controller: _textController2,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Confirm Password';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                      border: new UnderlineInputBorder(
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Confirm Password',

                  ),

                ),

              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child :
                TextFormField(

                  controller: _textController3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email Address';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    border: new UnderlineInputBorder(
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Email Address',
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                alignment: Alignment.bottomRight,
                child :RaisedButton(
                  child: Text('SIGN UP'),

                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }

                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
