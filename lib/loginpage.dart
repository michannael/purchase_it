import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchase_it/registeruser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;
  final TextEditingController _emailcont = TextEditingController();
  String _email = "";
  final TextEditingController _passcont = TextEditingController();
  String _pass = "";

  @override
  void initState() {
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Log In'),
          ),
          resizeToAvoidBottomPadding: false,
          body: new Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                TextField(
                    controller: _emailcont,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email))),
                TextField(
                  controller: _passcont,
                  decoration: InputDecoration(
                      labelText: 'Password', icon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        _onChange(value);
                      },
                    ),
                    Text('Remember Me', style: TextStyle(fontSize: 16))
                  ],
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  minWidth: 250,
                  height: 50,
                  child: Text('Log In'),
                  color: Colors.teal,
                  textColor: Colors.black,
                  elevation: 10,
                  onPressed: _onPress,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: _onRegister,
                    child: Text('Register New Account',
                        style: TextStyle(fontSize: 16))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onForgot,
                    child: Text('Forgot Password',
                        style: TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ));
  }

  void _onPress() {
    print('Log In Button Pressed');
  }

  void _onRegister() {
    print('onRegister');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterUser()));
  }

  void _onForgot() {
    print('Forgot Password');
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      savepref(value);
    });
  }

  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _pass = (prefs.getString('pass'));
    print(_email);
    print(_pass);
    if (_email.length > 1) {
      _emailcont.text = _email;
      _passcont.text = _pass;
      setState(() {
        _isChecked = true;
      });
    } else {
      print('No pref');
      setState(() {
        _isChecked = false;
      });
    }
  }

  void savepref(bool value) async {
    print('Inside savepref');
    _email = _emailcont.text;
    _pass = _passcont.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //true save pref
      if (_isEmailValid(_email) || _pass.length < 5) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _pass);
        print('Save pref $_email');
        print('Save pref $_pass');
        Toast.show("Preferences has been successfully saved", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _isChecked = false;
        });
        Toast.show("Invalid Preferences", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailcont.text = '';
        _passcont.text = '';
        _isChecked = false;
      });
      print('Remove pref');
      Toast.show("Preferences has been removed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
