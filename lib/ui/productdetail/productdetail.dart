import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.title}) : super(key: key);
  String title;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _current = 0;
  Map map;
  final List<String> entries = <String>[
    "assets/images/bigmobile.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/home.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          drawerEdgeDragWidth: 0,
          // THIS WAY IT WILL NOT OPEN
          key: _drawerKey,
          drawer: returnDrawer(),
          backgroundColor: Colors.transparent,
          body: Container(
              margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                              child:
                                  Image.asset("assets/images/drawerlines.png"),
                            ),
                            onTap: () {
                              _drawerKey.currentState.openDrawer();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                            child: Text(
                              "PRODUCT DETAIL",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {Navigator.push(context, new MaterialPageRoute(
                                builder: (_) => Cart(title: "Cart page",),
                              ));},
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 45.0, 30.0, 0.0),
                                child: Image.asset("assets/images/cart.png"),
                              ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
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
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CarouselSlider.builder(
                                  itemCount: entries.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return Container(
                                      child: Image.asset(
                                        entries[itemIndex],
                                      ),
                                    );
                                  }),
//                              Row(
//                                children: <Widget>[
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 2 -
                                          70,
                                      0.0,
                                      0.0,
                                      0.0),
                                  height: 30.0,
                                  child: ListView.builder(
                                      itemCount: entries.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _current == i
                                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                                  : Color.fromRGBO(
                                                      0, 0, 0, 0.4)),
                                        );
                                      })),
//                                ],
//                              )
                            ]),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                margin:
                                    EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
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
                                      Icons.shopping_cart,
                                      color: Colors.orangeAccent,
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: FlatButton(
                                          color: Colors.white,
                                          child: Text(
                                            "Add to cart",
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
                                            "Rs. 1000000",
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
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        width: double.infinity,
                        height: 1.0,
                        child: Divider(),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                        child: Text(
                          "iPhone 11 128GB Just the right amount of everything.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        width: double.infinity,
                        child: Divider(),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                        child: Text(
                          "A new dual‑camera system captures more of what you see and love. The fastest chip ever in a smartphone and all‑day battery life let you do more and charge less. And the highest‑quality video in a smartphone, so your memories look better than ever.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        )
      ],
    );
  }

  Drawer returnDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
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
                Navigator.push(context, new MaterialPageRoute(
                  builder: (_) => Home(title: "Home page",),
                ));
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
                  builder: (_) => AddProductItem(title: "Compose new product",),
                ));
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
