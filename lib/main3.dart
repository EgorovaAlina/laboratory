import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: new MyApp(),
));

class MyApp extends StatelessWidget {
  String _name;
  String _email;
  String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Имя"),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _name = val,
                    ),
                    width: 300.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _email = val,
                      validator: (val) =>
                      !val.contains("@") ? 'Неверный Email.' : null,
                    ),
                    width: 300.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Пароль"),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) =>
                      val.length < 6 ? 'Пароль слишком короткий.' : null,
                      onSaved: (val) => _password = val,
                      style: _sizeTextBlack,
                    ),
                    width: 300.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submit,
                      color:  Color(0xFF594D9E),
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Войти",
                        style: _sizeTextWhite,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new SecondScreen(_name, _email, _password)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class SecondScreen extends StatelessWidget {
  String _name;

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);

  SecondScreen(String name, String email, String password) {
    _name = name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Приветствие"),
          textTheme: TextTheme(
              headline6:TextStyle (fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(
                  0xFFFFFFFF) )
          ),
          backgroundColor:  Color(0xFF594D9E),
        ),
        body: new Center(
          child: new Text(
            "Добро пожаловать, $_name",
            style: _sizeTextBlack,
          ),
        )
    );
  }
}