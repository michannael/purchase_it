import 'package:flutter/material.dart';

bool _isChecked = true;
final TextEditingController _emailcont = TextEditingController();
String _email = "";
final TextEditingController _passcont = TextEditingController();
String _pass = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              scale: 3,
            ),
            TextField(
                controller: _emailcont,
                decoration: InputDecoration(
                  labelText: 'Email',
                )),
            TextField(
              controller: _passcont,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
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
            Text(
              'Remember Me', style: TextStyle(
                fontSize: 16,)
                ),
          ],
        ),
        SizedBox(
          height: 10,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
              minWidth:250,
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
              Text('Register New Account'),
              SizedBox(
                height: 10,
                ),
      Text('Forgot Password')
          ],
      ),
    ),
    );
  }

void _onPress() {
  print(_emailcont.text);
  print(_passcont.text);
}

void _onChange(bool value) {
  setState(() {
    _isChecked = value;
    print('Check value $value');
  });
}
}
