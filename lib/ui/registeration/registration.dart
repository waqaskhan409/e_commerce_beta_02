import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterationStless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E - Commerce Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Registration(title: 'Registration Page'),
    );
  }
}

class Registration extends StatefulWidget {
  Registration({Key key, this.title}) : super(key: key);
  String title;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = new FacebookLogin();



  ProgressDialog pr;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: "Please signing in ...");
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/login.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: _splashBody(),
        ),
      ],
    );
  }

  Widget _splashBody() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    )),
                Container(
                    width: 150.0,
                    child: Text(
                      "Create a new account to start ordering",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Please put the email";
                        } else if (!isEmail(text)) {
                          return "Please put the proper email";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration: new InputDecoration.collapsed(
                          hintText: 'Email@email.com'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Please put the passsword";
                        } else if (text.length < 8) {
                          return "Your password length should greater than 8";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration: new InputDecoration.collapsed(
                          hintText: '************'),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 10.0),
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              pr.show();
                              handleSignUp(emailController.text, passwordController.text);
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Some thing went wrong')));
                            }
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0, 140.0, 0.0, 0.0),
                    width: 160.0,
                    child: Text("Sign in with Google or Facebook"),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          googleSignIn();
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 0.0),
                          child: IconButton(
                              onPressed: () {
                                googleSignIn();
                              },
                              icon: Icon(
                                FontAwesomeIcons.google,
                                size: 35,
                                color: Colors.red,
                              )),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
                          child: IconButton(
                              onPressed: (){
                                facebookSignIn();

                              },
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: 45,
                                color: Colors.blue,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (_) => Login(
                            title: "Login page",
                          ),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(230.0, 15.0, 20.0, 40.0),
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  bool isEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  Future<FirebaseUser> handleSignUp(email, password) async {

    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);
      pr.dismiss();
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (_) => Home(
              title: "Home page",
              filter: "All",
            ),
          ));
      return user;

    }catch(e){
      pr.dismiss();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Something went wrong')));

      return null;
    }

  }
  Future<void> facebookSignIn() async {
    try {
      final FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(
          ['email', 'public_profile']);
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      FirebaseUser fbUser;
      fbUser = (await auth.signInWithCredential(authCredential)).user;
      assert(fbUser != null);
      assert(await fbUser.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(fbUser.uid == currentUser.uid);
      print('signInEmail succeeded: ' + currentUser.uid);
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (_) => Home(
              title: "Home page",
            ),
          ));
      return;
    }catch(e){
      print(e);
      return;
    }

  }Future<void> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
      final googleAuth = await googleSignInAccount.authentication;
      final googleAuthCred = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      FirebaseUser gUser;
      gUser = (await auth.signInWithCredential(googleAuthCred)).user;
      assert(gUser != null);
      assert(await gUser.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(gUser.uid == currentUser.uid);
      print('signInEmail succeeded: ' + currentUser.uid);
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (_) => Home(
              title: "Home page",
            ),
          ));
      return;
    }catch(e){
      print(e);
      return;
    }

  }
  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }


}
