import 'dart:collection';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/productmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/myproducts/allproduct.dart';
import 'package:e_commerce_beta/ui/myproducts/myproducts.dart';
import 'package:e_commerce_beta/ui/order/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.title, this.productDetail}) : super(key: key);
  String title;
  Product productDetail;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String email = "example@gmail.com";
  String uid ;
  final Firestore db = Firestore.instance;


  int _current = 0;
  Map map;
  final List<String> images = List();

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    images.clear();
    images.add(widget.productDetail.image_1);
    images.add(widget.productDetail.image_2);
    images.add(widget.productDetail.image_3);
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
          body: SingleChildScrollView(
    child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
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
                              IconButton(
                                onPressed: (){
                                  _drawerKey.currentState.openDrawer();
                                },
                                icon: Icon(Icons.dehaze, color: Colors.white, size: 30.0,),
                              ),
                            ),
                            onTap: () {
                              _drawerKey.currentState.openDrawer();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                            child: Text(
                              widget.productDetail.product,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          Spacer(),
                          /*GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 45.0, 30.0, 0.0),
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (_) => Cart(
                                            title: "Cart page",
                                          ),
                                        ));
                                  },
                                  icon: Icon(Icons.shopping_cart, color: Colors.white,),
                                ),
                              ))*/
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
                                  itemCount: images.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return images[itemIndex] == "image"
                                        ? Container(
                                            child: Icon(
                                              Icons.image,
                                              size: 80.0,
                                            ),
                                          )
                                        : Container(
                                            child: Image.network(
                                              images[itemIndex],
                                            ),
                                          );
                                  }),
//                              Row(
//                                children: <Widget>[
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 2 -
                                          50,
                                      0.0,
                                      0.0,
                                      0.0),
                                  height: 30.0,
                                  child: ListView.builder(
                                      itemCount: 3,
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
                                      Icons.call,
                                      color: Colors.blue,
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 0.0, 20.0, 0.0),
                                        child: FlatButton(
                                          onPressed: (){
//                                            sendDataToCart(widget.productDetail);
                                            launch("tel:"+ widget.productDetail.owner_number);

                                          },
                                          color: Colors.white,
                                          child: Text(
                                            "Call me",
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 20.0),
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
                                            "Rs. " + widget.productDetail.price,
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
                     SingleChildScrollView(
                       child: Column(
                         children: <Widget>[
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                             child: Text(
                               widget.productDetail.short_desc,
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
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                             child: Text(
                               widget.productDetail.long_desc,
                               style: TextStyle(
                                   fontSize: 18, fontWeight: FontWeight.normal),
                             ),
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Owner: "+widget.productDetail.owner,
                                   style: TextStyle(
                                       fontSize: 20, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Owner mobile: "+widget.productDetail.owner_number,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.normal),
                                 ),
                               )
                             ],
                           ),
                           Row(
                             children: <Widget>[

                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                                 child: IconButton(
                                   onPressed: (){
                                     launch("sms:"+ widget.productDetail.owner_number);

                                   },
                                   icon: Icon(Icons.message, color: Colors.yellow,),
                                 ),
                               ), Container(
                                 margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                                 child: IconButton(
                                   onPressed: (){
                                     ClipboardManager.copyToClipBoard(widget.productDetail.owner_number).then((result) {
                                       final snackBar = SnackBar(
                                         content: Text('Copied to Clipboard'),
                                       );
                                       _drawerKey.currentState.showSnackBar(snackBar);
                                     });

                                   },
                                   icon: Icon(FontAwesomeIcons.copy, color: Colors.black,),
                                 ),
                               ),
                               Container(
                                 margin: EdgeInsets.fromLTRB(10.0, 10.0,0.0, 10.0),
                                 child: IconButton(
                                   onPressed: (){
//                                     launch("tel:"+ widget.productDetail.owner_number);
//                                     print("Called");
                                     Share.share(widget.productDetail.owner_number);
                                   },
                                   icon: Icon(Icons.share, color: Colors.red,),
                                 ),
                               ),
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Province: "+widget.productDetail.province,
                                   style: TextStyle(
                                       fontSize: 20, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "City : "+widget.productDetail.city,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.normal),
                                 ),
                               )
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Quanity: "+widget.productDetail.quantity,
                                   style: TextStyle(
                                       fontSize: 20, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                             width: double.infinity,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Category : "+widget.productDetail.prduct_category,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.normal),
                                 ),
                               )
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(

                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 width: MediaQuery.of(context).size.width/2 + 100,
                                 child: Text(

                                   "Expiry Date: " + widget.productDetail.expiry_date,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                       fontSize: 20, fontWeight: FontWeight.bold),
                                 ),
                               ),
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             child: Divider(),
                           ),
                           Row(
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                 child: Text(
                                   "Is negotiable? "+widget.productDetail.is_negotiable,
                                   style: TextStyle(
                                       fontSize: 18, fontWeight: FontWeight.normal),
                                 ),
                               )
                             ],
                           ),
                           Container(
                             margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                             width: double.infinity,
                             height: 1.0,
                             child: Divider(),
                           ),
                         ],
                       ),
                     )


                    ],
                  )
                ],
              )
          ),
        ))
      ],
    );
  }

  Drawer returnDrawer() {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.

        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
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
                  child: Text(email),
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
                        filter: "All",
                      ),
                    ));
              },
            ),
          ),
        /*  Container(
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
                        title: "Add",

                      ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ),*/
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('My Products'),
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
                      builder: (_) => MyProducts(
                        title: "My products",
                      ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ),
         email == "dukaan@gmail.com" ?
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text('All Product'),
              trailing: Icon(
                Icons.bookmark_border,
                color: Colors.red,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (_) =>
                          AllProduct(
                            title: "All Products",
                          ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ):Container(),
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
//          Container(
//            color: Colors.white,
//            child: ListTile(
//              title: Text('Cart'),
//              trailing: Icon(
//                Icons.shopping_cart,
//                color: Colors.red,
//              ),
//              onTap: () {
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                      builder: (_) => Cart(
//                        title: "Cart page",
//                      ),
//                    ));
////                Navigator.pop(context);
//              },
//            ),
//          ),
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
    ));
  }


  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    if (uid != null) {
      setState(() {
        email = user.email;
      });
    }

    // here you write the codes to input the data into firestore
  }
  Future<void> sendDataToCart(Product cartData) async {

    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    Map<String, Object> product = new HashMap();
    product['owner'] = cartData.owner;
    product['owner_number'] = cartData.owner_number;
    product['product'] = cartData.product;
    product['prduct_category'] = cartData.prduct_category;
    product['shot_desc'] = cartData.short_desc;
    product['long_desc'] = cartData.long_desc;
    product['price'] = cartData.price;
    product['quantity'] = cartData.quantity;
    product['is_negotiable'] = cartData.is_negotiable;
    product['city'] = cartData.city;
    product['province'] = cartData.province;
    product['is_feature'] = cartData.is_feature;
    product['expire_date'] = cartData.expiry_date;
    product['current_date'] = cartData.current_date;
    product['image_1'] = cartData.image_1;
    product['image_2'] = cartData.image_2;
    product['image_3'] = cartData.image_3;
    product['thumbnail'] = cartData.thumbnail;
    product['uid'] = uid;
    db.collection("cart").document(cartData.product_id).setData(product);
  }
}
