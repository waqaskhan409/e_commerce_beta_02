import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/productmodel.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/productdetail/productdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addproduct.dart';

class SuccesfullAddProduct extends StatefulWidget {
  SuccesfullAddProduct({Key key, this.title, this.documentId, this.productName})
      : super(key: key);

  String title;
  String documentId;
  String productName;

  @override
  _SuccesfullAddProductState createState() => _SuccesfullAddProductState();
}

class _SuccesfullAddProductState extends State<SuccesfullAddProduct> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Product product;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState

    getData();

    super.initState();
  }
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
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
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
                              child:
                                  Image.asset("assets/images/drawerlines.png"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                            child: Text(
                              "HOME",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
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
                              "Please note your product id",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                        child: Text(
                          "Success!",
                          style: TextStyle(color: Colors.white, fontSize: 35.0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
                    width: 200,
                    child: Text(
                      "Your order has been placed. Your product id is " +
                          widget.documentId,
                      style: TextStyle(color: Colors.black87, fontSize: 14.0),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                      child: Divider()),
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                    width: 200,
                    child: Text(
                      "For queries email us support@dukaan.com",
                      style: TextStyle(color: Colors.black87, fontSize: 14.0),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(.0, .0, .0, 0.0),
                        margin: EdgeInsets.fromLTRB(40.0, 100.0, 0.0, 0.0),
                        decoration: BoxDecoration(

                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (_) => ProductDetail(
                                            title: "Home page",
                                            productDetail: product,
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )),

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(10.0, 100.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (_) => Home(
                                            title: "Home page",
                                            filter: "All",
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Back to catalog",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )),

                          ],
                        ),
                      ),

                    ],
                  )

                ],
              ),
            ),
          ))
    ]);
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
                        title: "Home page",
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
//                Navigator.push(context, new MaterialPageRoute(
//                  builder: (_) => AddProductItem(title: "Add",),
//                ));
                Navigator.pop(context);
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => Categories(
                        title: "Category page",
                      ),
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) => Cart(
                        title: "Cart page",
                      ),
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

  void getData() async {
    db.collection("products").document(widget.documentId).get().then((product){
      this.product = Product(
          product["owner"],
          product["owner_number"],
          product["prduct_category"],
          product["product"],
          product["price"],
          product["province"],
          product["shot_desc"],
          product["long_desc"],
          product["is_negotiable"],
          product["image_1"],
          product["image_2"],
          widget.documentId,
          product["thumbnail"],
          product["image_3"],
          product["city"],
          product["current_date"],
          product["expire_date"],
          product["is_feature"],
          product["quantity"]

      );
    });
  }
}
