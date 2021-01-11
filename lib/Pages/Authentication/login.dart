import 'package:flutter/material.dart';
import 'package:votingweb/Pages/Home/homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white30,
        child: Center(
          child: Container(
            width: size.width * .3,
            height: size.height * .62,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * .01),
                    Text(
                      'Login to vote!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * .04),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'UMak Email',
                      ),
                      style: TextStyle(fontSize: 15.0),
                      validator: (val) =>
                          val.isEmpty ? 'Email is required' : null,
                    ),
                    SizedBox(height: size.height * .04),
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: passwordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? Icon(Icons.visibility_off, size: 20)
                                : Icon(Icons.visibility, size: 20)),
                      ),
                      style: TextStyle(fontSize: 15.0),
                      validator: (val) =>
                          val.isEmpty ? 'Password is required' : null,
                    ),
                    SizedBox(height: size.height * .07),
                    Center(
                      child: MaterialButton(
                        height: size.height * .075,
                        minWidth: size.width * 0.2,
                        //color: Color.fromRGBO(86, 43, 167, 1),
                        splashColor: Colors.purple,
                        highlightColor: Colors.purple[100],
                        hoverColor: Colors.purple[50],
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.purple[600], width: 2)),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 7),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (emailController.text == 'admin' &&
                                passwordController.text == 'admin') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
