import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/productdetail/productdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      home: Home(title: 'Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;


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
  String swiptDouble = "Swipe for details";
  int listGrid = 0;
  final List<int> colorCodes = <int>[600, 500, 500, 500, 200, 300];

    double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/home.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        key: _drawerKey,
        drawer: returnDrawer(),
        drawerEdgeDragWidth: 0,
        backgroundColor: Colors.transparent,
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
                          "HOME",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (_) => Cart(title: "Cart page",),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(200.0, 45.0, 30.0, 0.0),
                          child: Image.asset("assets/images/cart.png"),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 10.0),
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: new InputDecoration(
                          hintText: 'Find a product',
                          border: InputBorder.none,
                          suffix: Image.asset("assets/images/search.png"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
                        child: Image.asset("assets/images/doubleclick.png"),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
                        child: Text(
                          swiptDouble,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => {changeToList()},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 15.0, 40.0, 0.0),
                          child: Image.asset(image),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: image == "assets/images/list.png"
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(list.length, (index) {
                          return GestureDetector(
                              onDoubleTap: () => {doubleTap(index)},
                              child:  Container(
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
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                        ),
                                        margin:
                                        EdgeInsets.fromLTRB(7.0, 8.0, 7.0, 8.0),
                                        child: CarouselSlider.builder(
                                          enlargeCenterPage: true,
                                            aspectRatio: 3/2,
                                            viewportFraction: 1.0,
                                          itemCount: 2,
                                          itemBuilder: (BuildContext context, int itemIndex) =>
                                          itemIndex == 0 ? GestureDetector(
                                            onTap:(){
                                              Navigator.push(context, new MaterialPageRoute(
                                                builder: (_) => ProductDetail(title: "Product Detail page",),
                                              ));
                                            },
                                            child: Container(
                                              child: Image.asset(
                                                entries[index],
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                          ): GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, new MaterialPageRoute(
                                                builder: (_) => ProductDetail(title: "Product Detail page",),
                                              ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text("iPhone 11", style: TextStyle(
                                                      fontSize: 17
                                                  ),),
                                                  Text("Rs. 100,000", style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        10.0, .0, 0.0, 0.0),
                                                    margin: EdgeInsets.fromLTRB(
                                                        20.0, 60.0, 25.0, 0.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.orangeAccent
                                                      ),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(8)),
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
                                                              onPressed: (){

                                                              },
                                                              child: Text(
                                                                "Add to cart",
                                                                style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                    FontWeight.w300),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                ));
                        }))
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, i) {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 8.0),
                            padding: EdgeInsets.fromLTRB(20.0, 8.0, 5.0, 8.0),
                            child: GestureDetector(
                              onDoubleTap: (){
                                Navigator.push(context, new MaterialPageRoute(
                                  builder: (_) => ProductDetail(title: "Product Detail page",),
                                ));
                              },
                              child: ExpansionTile(
                                title: Row(
                                  children: <Widget>[
                                    Image.asset(list[i]),
                                    Container(
                                      width: 190.0,
                                      margin: EdgeInsets.fromLTRB(
                                          30.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        listText[i],
                                      ),
                                    )
                                  ],
                                ),
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(),
                                    margin:
                                    EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                                    child: ListTile(
                                      title: Text(
                                        "Rs. 10,0000",
                                        style: TextStyle(fontSize: 23),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0.0),
                                            margin: EdgeInsets.fromLTRB(
                                                35.0, 0.0, 0.0, 20.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.orangeAccent),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
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
                                                      child: Text(
                                                        "Add to cart",
                                                        style: TextStyle(
                                                            fontSize: 17.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.w300),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            )
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget doubleTap(int index) {
    showCuperDialog<String>(
      context: context,
      child: CupertinoAlertDialog(
        title: const Text('Agree?'),
        content: const Text('xxxxxxxxxxxxxxxxxxxxx'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Donot Allow'),
            onPressed: () {
              Navigator.pop(context, 'Disallow');
            },
          ),
          CupertinoDialogAction(
            child: const Text('Allow'),
            onPressed: () {
              Navigator.pop(context, 'Allow');
            },
          ),
        ],
      ),
    );
    return Text("asd");

  }

  void showCuperDialog<T>({BuildContext context, Widget child}) {
    showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((T value) {
      if (value != null) {}
    });
  }

  changeToList() {
    if (listGrid % 2 == 0) {
      setState(() {
        this.image = "assets/images/grid.png";
        this.swiptDouble = "Double tap for details";

      });
      listGrid++;
    } else {
      setState(() {
        this.image = "assets/images/list.png";
        this.swiptDouble = "Swipe for details";


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
                Navigator.pop(context);
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
                Navigator.push(context, new MaterialPageRoute(
                  builder: (_) => AddProductItem(title: "Add",),
                ));
//                Navigator.pop(context);
              },
            ),
          ),Container(
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
                Navigator.push(context, new MaterialPageRoute(
                  builder: (_) => Home(title: "My list",),
                ));
//                Navigator.pop(context);

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
                Navigator.push(context, new MaterialPageRoute(
                  builder: (_) => Categories(title: "Category page",),
                ));
//                Navigator.pop(context);

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
                Navigator.push(context, new MaterialPageRoute(
                    builder: (_) => Cart(title: "Cart page",),
                ));
//                Navigator.pop(context);

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
                auth.signOut();
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
