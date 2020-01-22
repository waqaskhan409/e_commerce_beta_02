import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:flutter/material.dart';

class Homeless extends StatelessWidget {
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
      home: Cart(title: 'Home Page'),
    );
  }
}

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);

  String title;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _current = 0;
  int _totalMoney = 0;

  final List<String> list = <String>[
    "assets/images/mobilesell.png",
    "assets/images/jacket.png",
    "assets/images/jacket2.png",
    "assets/images/jacket3.png",
    "assets/images/jacket4.png"
  ];
  final List<String> listText = <String>[
    "iPhone 11 128GB Just the right amount of everything.",
    "GMBN Thermal Winter Jacket - Black",
    "ightweight & packable, waterproof Beta AR Jacket Men's",
    "Beta AR Jacket Men's",
    "BIKE JACKET PRIME GTX ACTIVE (Ms), 100% water- and windproof, particularly breathable."
  ];
  final List<String> price = <String>[
    "10000",
    "20000",
    "5000",
    "4999",
    "15999"
  ];
  final List<String> entries = <String>[
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image3.png"
  ];
  String image = "assets/images/list.png";
  int listGrid = 0;
  final List<int> colorCodes = <int>[600, 500, 500, 500, 200, 300];

  @override
  Widget build(BuildContext context) {
    totalMoney();
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/home.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.transparent,
        drawerEdgeDragWidth: 0,
        drawer: returnDrawer(),
        body: Container(
          margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
          decoration: BoxDecoration(),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _drawerKey.currentState.openDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                          child: Image.asset("assets/images/drawerlines.png"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                        child: Text(
                          "CART LIST",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (_) => Home(
                                  title: "Home page",
                                ),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 30.0, 0.0),
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                        child: Image.asset("assets/images/doubleclick.png"),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 45.0, 0.0, 0.0),
                        child: Text(
                          "Change quantity by tapping on quantity count.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(60.0, 30.0, 0.0, 0.0),
                        child: Text(
                          "Items",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 80.0, 0.0),
                        child: Text(
                          "Quantity",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    print(i);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            // has the effect of softening the shadow
                            spreadRadius: 3.0,
                            // has the effect of extending the shadow
                            offset: Offset(
                              2.0, // horizontal, move right 10
                              2.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 8.0),
                      padding: EdgeInsets.fromLTRB(20.0, 8.0, 5.0, 8.0),
                      child: ExpansionTile(
                        onExpansionChanged: (bool) {
                          if (bool) {
                            _current = i;
                            print(_current);
                          }
                        },
                        title: Row(
                          children: <Widget>[
                            Image.asset(
                              entries[i],
                              width: 50.0,
                              height: 50.0,
                            ),
                            Container(
                              width: 120.0,
                              margin: EdgeInsets.fromLTRB(15.0, 0.0, 50.0, 0.0),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: listText[i]),
                              ),
                            ),
                            Container(
                              width: 30.0,
                              height: 40.0,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: "1",
                              ),
                            )
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(),
                            margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                            child: ListTile(
                              title: Text(
                                price[i],
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                          ),
                          Container(
                              child: Row(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                margin:
                                    EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 20.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.orangeAccent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.orangeAccent,
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: FlatButton(
                                          onPressed: () {
                                            print(_current);
                                            setState(() {
                                              list.removeAt(_current);
                                              entries.removeAt(_current);
                                              listText.removeAt(_current);
                                              price.removeAt(_current);
                                              totalMoney();
                                            });
                                          },
                                          child: Text(
                                            "Remove from cart",
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          // has the effect of softening the shadow
                          spreadRadius: 3.0,
                          // has the effect of extending the shadow
                          offset: Offset(
                            2.0, // horizontal, move right 10
                            2.0, // vertical, move down 10
                          ),
                        ),
                      ],
                    ),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                              margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 3.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      2.0, // horizontal, move right 10
                                      2.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label_important,
                                    color: Colors.orangeAccent,
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: FlatButton(
                                        color: Colors.white,
                                        child: Text(
                                          "Checkout",
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 30.0, 20.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(218, 36, 46, 40),
                                border: Border.all(
                                    color: Color.fromRGBO(218, 36, 46, 40)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 3.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      2.0, // horizontal, move right 10
                                      2.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: FlatButton(
                                        color: Colors.white,
                                        child: Text(
                                          "Rs. "+ (_totalMoney).toString(),
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  void totalMoney(){
    _totalMoney = 0;
    for(int i = 0; i< price.length; i++){
      _totalMoney = _totalMoney + int.parse(price[i]);
    }

  }

  Widget doubleTap(int index) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text("iPhone 11 128GB"),
          ),
          Container(
            child: Text("RS 100,000"),
          ),
          GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[],
              ),
            ),
          )
        ],
      ),
    );
  }

  changeToList() {
    if (listGrid % 2 == 0) {
      setState(() {
        this.image = "assets/images/grid.png";
      });
      listGrid++;
    } else {
      setState(() {
        this.image = "assets/images/list.png";
      });
      listGrid++;
    }
  }

  Drawer returnDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/Logo.png",
                  width: 80,
                  height: 80,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text("example@gmail.com"),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Home'),
              trailing: Icon(
                Icons.home,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => Home(
                        title: "My list",
                      ),
                    ));
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Compose new product'),
              trailing: Icon(
                Icons.new_releases,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => AddProductItem(
                        title: "Compose new product",
                      ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('My items'),
              trailing: Icon(
                Icons.list,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => Home(
                        title: "My list",
                      ),
                    ));
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Categories'),
              trailing: Icon(
                Icons.category,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => Categories(
                        title: "Category page",
                      ),
                    ));
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Cart'),
              trailing: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('Logout'),
              trailing: Icon(
                Icons.reply,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Login(
                        title: "Login page",
                      ),
                    ),
                        (e) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
