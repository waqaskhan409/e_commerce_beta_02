import 'dart:collection';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/productmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/myproducts/allproduct.dart';
import 'package:e_commerce_beta/ui/myproducts/myproducts.dart';
import 'package:e_commerce_beta/ui/order/order.dart';
import 'package:e_commerce_beta/ui/productdetail/productdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Home({Key key, this.title, this.filter}) : super(key: key);

  String title;
  String filter;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;

  String email = "example@gmail.com";
  List<Product> productList = new List();
  List<Product> cart = new List();
  List<Product> prevList = new List();
  IconData iconList = Icons.list;




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
  String uid;
  double _value = 0.0;

  @override
  Future<void> initState()  {
    // TODO: implement initState

    inputData();
    readDataFromFireStore();

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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (_) => AddProductItem(
                    title: "Add",
                  ),
                ));
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
        key: _drawerKey,
        drawer: returnDrawer(),
        drawerEdgeDragWidth: 0,
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          decoration: BoxDecoration(),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(

                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                          child: IconButton(
                            onPressed: (){
                              _drawerKey.currentState.openDrawer();
                            },
                            icon: Icon(Icons.dehaze, color: Colors.white, size: 30.0,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 0.0),
                        child: Text(
                          "HOME",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Spacer(),
                      /*GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 30.0, 0.0),
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
                        ),
                      )*/
                    ],
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: TextFormField(
                        onChanged: (text){
                          searchProducts(text);
                        },
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        decoration: new InputDecoration(
                          hintText: 'Find a product',
                          border: InputBorder.none,
                          suffix: Image.asset("assets/images/search.png"),
                          icon: Icon(Icons.search)
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 10.0),
                        child: Image.asset("assets/images/doubleclick.png"),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                        child: Text(
                          widget.filter,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => {changeToList()},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 10.0),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                if(iconList == Icons.list){
                                  iconList = Icons.grid_on;
                                }else{
                                  iconList = Icons.list;
                                }
                              });
                            },
                            icon: Icon(iconList, color: Colors.white,),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              productList.length != 0 ?
              Expanded(
                child: iconList == Icons.list
                    ? GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(productList.length, (index) {
                          return GestureDetector(
                              onDoubleTap: () => {doubleTap(index)},
                              child: Container(
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
                                      EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 8.0),
                                  child: CarouselSlider.builder(
                                      enlargeCenterPage: true,
                                      aspectRatio: 3 / 2,
                                      viewportFraction: 1.0,
                                      itemCount: 2,
                                      itemBuilder: (BuildContext context,
                                              int itemIndex) =>
                                          itemIndex == 0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                          builder: (_) =>
                                                              ProductDetail(
                                                            title:
                                                                "Product Detail page",
                                                                productDetail: productList[index],
                                                          ),
                                                        ));
                                                  },
                                                  child: Container(
                                                    child: Image.network(
                                                      productList[index].thumbnail,
                                                      width: 180,
                                                      height: 180,
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                          builder: (_) =>
                                                              ProductDetail(
                                                            title:
                                                                "Product Detail page",
                                                          ),
                                                        ));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0.0, 20.0, 0.0, 0.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          productList[index].product,
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        Text(
                                                          "Rs. " + productList[index].price,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10.0,
                                                                  .0, 0.0, 0.0),
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  20.0,
                                                                  20.0,
                                                                  25.0,
                                                                  0.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons
                                                                    .call,
                                                                color: Colors
                                                                    .blue,
                                                              ),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      FlatButton(
                                                                    onPressed:
                                                                        () {
//                                                                      cart.add(productList[index]);
//                                                                      sendDataToCart(productList[index]);
//                                                                        print(checkDuplication().length);

                                                                          launch("tel:"+ productList[index].owner_number);

                                                                        },
                                                                    child: Text(
                                                                      "Call him",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          color: Colors
                                                                              .black,
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
                                                ))));
                        }))
                    : ListView.builder(
                        itemCount: productList.length,
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
                                onDoubleTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (_) => ProductDetail(
                                          title: "Product Detail page",
                                          productDetail: productList[i],
                                        ),
                                      ));
                                },
                                child: ExpansionTile(
                                  title: Row(
                                    children: <Widget>[
                                      Image.network(productList[i].thumbnail, width: 40, height: 40,),
                                      Container(
                                        width: 190.0,
                                        margin: EdgeInsets.fromLTRB(
                                            30.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          productList[i].product,
                                        ),
                                      )
                                    ],
                                  ),
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(),
                                      margin: EdgeInsets.fromLTRB(
                                          30.0, 0.0, 0.0, 0.0),
                                      child: ListTile(
                                        title: Text(
                                          "Rs. " + productList[i].price,
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
                                                color: Colors.blue),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.call,
                                                color: Colors.blue,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 10.0, 0.0),
                                                  child: FlatButton(
                                                    onPressed: (){
//                                                      cart.add(productList[i]);
//                                                      print(checkDuplication());
//                                                      sendDataToCart(productList[i]);
                                                      launch("tel:"+ productList[i].owner_number);
                                                    },
                                                    child: Text(
                                                      "Call him",
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
                              ));
                        },
                      ),
              ):Center(

                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, MediaQuery.of(context).size.height/3, 0.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: Icon(FontAwesomeIcons.sadTear, size: 50,color: Colors.red,),
                      ),
                  Text("No item Available yet!", style: TextStyle(
                      color: Colors.black
                  ))
                    ],
                  ),
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
  List<Product> checkDuplication(){
    cart = cart.toSet().toList();
    return cart;
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
                Navigator.pop(context);
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
         /* Container(
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
                        title: "My Products",
                      ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ),email == "dukaan@gmail.com" ?
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
          /*Container(
            color: Colors.white,
            child: ListTile(
              title: Text('My Orders'),
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
                          Order(
                            title: "My Orders",
                          ),
                    ));
//                Navigator.pop(context);
              },
            ),
          ),*/
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

  void searchProducts(String text){
    if(text == ""){
      readDataFromFireStore();
      return;
    }
    List<Product> searchList = new List();
    productList = prevList;

    for(int i = 0 ; i < productList.length ; i++){
      print(productList[i].product);
      if(productList[i].product.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].price.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].product_id.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].province.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].city.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].prduct_category.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].short_desc.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].long_desc.toLowerCase().contains(text.toLowerCase()) ||
          productList[i].is_negotiable.toLowerCase().contains(text.toLowerCase())
      ){
        searchList.add(productList[i]);
        print(searchList);
      }
    }
    setState(() {
      productList = searchList;
    });
  }



  void readDataFromFireStore () {
    if(widget.filter.toLowerCase() == "all"){
      List<Product> isFeaturedList = new List();
      List<Product> isNotFeaturedList = new List();
      db.collection("products").where("is_feature", isEqualTo: false).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            isNotFeaturedList.add(Product(
                f.data["owner"],
                f.data["owner_number"],
                f.data["prduct_category"],
                f.data["product"],
                f.data["price"],
                f.data["province"],
                f.data["shot_desc"],
                f.data["long_desc"],
                f.data["is_negotiable"],
                f.data["image_1"],
                f.data["image_2"],
                f.documentID,
                f.data["thumbnail"],
                f.data["image_3"],
                f.data["city"],
                f.data["current_date"],
                f.data["expire_date"],
                f.data["is_feature"],
                f.data["quantity"]

            ));
          });
          print("sixe: " + productList.length.toString());
        });

        setState(() {
          isFeaturedList.sort((a, b){
            return b.current_date.compareTo(a.current_date);
          });
          productList = isFeaturedList + isNotFeaturedList;
          prevList = productList;
          print(productList.length);
        });
        for(int i = 0; i< productList.length; i++){
          print(productList[i].current_date.millisecondsSinceEpoch.toString()  + productList[i].is_feature.toString() + productList[i].product_id);
        }
      });

      db.collection("products").where("is_feature", isEqualTo: true).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
//        setState(() {
          isFeaturedList.add(Product(
              f.data["owner"],
              f.data["owner_number"],
              f.data["prduct_category"],
              f.data["product"],
              f.data["price"],
              f.data["province"],
              f.data["shot_desc"],
              f.data["long_desc"],
              f.data["is_negotiable"],
              f.data["image_1"],
              f.data["image_2"],
              f.documentID,
              f.data["thumbnail"],
              f.data["image_3"],
              f.data["city"],
              f.data["current_date"],
              f.data["expire_date"],
              f.data["is_feature"],
              f.data["quantity"]

          ));
//        });
          print("sixe: " + productList.length.toString());
        });

        setState(() {
          isNotFeaturedList.sort((a, b){
            return b.current_date.compareTo(a.current_date);
          });
          productList = isFeaturedList + isNotFeaturedList;
          prevList = productList;

          print(productList.length);
        });
        for(int i = 0; i< productList.length; i++){
          print(productList[i].current_date.millisecondsSinceEpoch.toString()  + productList[i].is_feature.toString());
        }

      });

    }else if(widget.filter == uid){

      List<Product> isFeaturedList = new List();
      List<Product> isNotFeaturedList = new List();
      db.collection("products").where("uid", isEqualTo: widget.filter).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            isNotFeaturedList.add(Product(
                f.data["owner"],
                f.data["owner_number"],
                f.data["prduct_category"],
                f.data["product"],
                f.data["price"],
                f.data["province"],
                f.data["shot_desc"],
                f.data["long_desc"],
                f.data["is_negotiable"],
                f.data["image_1"],
                f.data["image_2"],
                f.documentID,
                f.data["thumbnail"],
                f.data["image_3"],
                f.data["city"],
                f.data["current_date"],
                f.data["expire_date"],
                f.data["is_feature"],
                f.data["quantity"]

            ));
          });
        });

        setState(() {
          isFeaturedList.sort((a, b){
            return b.current_date.millisecondsSinceEpoch.compareTo(a.current_date.millisecondsSinceEpoch);
          });
          productList = isFeaturedList + isNotFeaturedList;
          prevList = productList;
          print(productList.length);
        });
      });
    } else{
      List<Product> isFeaturedList = new List();
      List<Product> isNotFeaturedList = new List();
      db.collection("products").where("prduct_category", isEqualTo: widget.filter).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            isNotFeaturedList.add(Product(
                f.data["owner"],
                f.data["owner_number"],
                f.data["prduct_category"],
                f.data["product"],
                f.data["price"],
                f.data["province"],
                f.data["shot_desc"],
                f.data["long_desc"],
                f.data["is_negotiable"],
                f.data["image_1"],
                f.data["image_2"],
                f.documentID,
                f.data["thumbnail"],
                f.data["image_3"],
                f.data["city"],
                f.data["current_date"],
                f.data["expire_date"],
                f.data["is_feature"],
                f.data["quantity"]

            ));
          });
        });

        setState(() {
          isFeaturedList.sort((a, b){
            return b.current_date.millisecondsSinceEpoch.compareTo(a.current_date.millisecondsSinceEpoch);
          });
          productList = isFeaturedList + isNotFeaturedList;
          prevList = productList;
          print(productList.length);
        });
      });

    }



  }

  Future<void> sendDataToCart(Product cartData) async {



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
