import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/productmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/myproducts/myproducts.dart';
import 'package:e_commerce_beta/ui/order/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _quanityKey = GlobalKey();
  String email = "example@gmail.com";
  final Firestore db = Firestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Product> cart = new List();
  String uid;

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
  static final  validCharacters = RegExp(r'^[0-9]+$');

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
  void initState() {
    // TODO: implement initState
    inputData();
    gettingCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/home.png",
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawerEdgeDragWidth: 0,
        drawer: returnDrawer(),
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
                          margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                          child: IconButton(
                            onPressed: (){
                              _scaffoldKey.currentState.openDrawer();
                            },
                            icon: Icon(Icons.dehaze, color: Colors.white, size: 30.0,),
                          ),
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
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 30.0, 0.0),
                          child: IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (_) =>
                                        Home(
                                          title: "Home page",
                                          filter: "All",
                                        ),
                                  ));
                            },
                            icon: Icon(Icons.home, color: Colors.white,),
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
              cart.length != 0 ? Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
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
                            Image.network(
                              cart[i].thumbnail,
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
                                    text: cart[i].product),
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
                              child: Form(
                                child: TextFormField(

                                  onChanged: (text){
                                    print(text);
                                    try{
                                      int count = int.parse(text);
                                      if(!validCharacters.hasMatch(text)){
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(content: Text("Please type number only")));

                                      }else if(int.parse(cart[i].quantity) < count){
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(content: Text("Not enough quantity")));

                                      }else{

                                        setState(() {
                                          cart[i].buyQuantity = count;
                                          totalMoney();
                                        });
                                      }
                                    }catch(e){
                                      print(e);
                                      if(!text.isEmpty){
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(content: Text("Please type number only")));
                                      }
                                    }

                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  initialValue: "1",
                                ),
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
                                cart[i].price,
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
                                          Icons.remove_shopping_cart,
                                          color: Colors.orangeAccent,
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: FlatButton(
                                              onPressed: () {
                                                print(_current);
                                                setState(() {

                                                  removeCart(i);

                                                  cart.removeAt(i);

                                                  totalMoney();

                                                });
                                              },
                                              child: Text(
                                                "Remove from cart",
                                                style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight
                                                        .w300),
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
              ):Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, MediaQuery.of(context).size.height/4, 0.0, 0.0),
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
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                              padding:
                              EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                                          "Rs. " + (_totalMoney).toString(),
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

  void totalMoney() {
    _totalMoney = 0;
    for (int i = 0; i < cart.length; i++) {
      _totalMoney = (_totalMoney + int.parse(cart[i].price)) * cart[i].buyQuantity;
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
        child: Container(
          color: Colors.white,
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
                    // Then close the drawer
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (_) =>
                              Home(
                                title: "Home page",
                                filter: "All",
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
                          builder: (_) =>
                              AddProductItem(
                                title: "Add",
                              ),
                        ));
//                Navigator.pop(context);
                  },
                ),
              ),
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
                          builder: (_) =>
                              MyProducts(
                                title: "My products",
                              ),
                        ));
//                Navigator.pop(context);
                  },
                ),
              ),
              Container(
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
                          builder: (_) =>
                              Categories(
                                title: "Categories",
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
                    auth.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              Login(
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

  Future<void> gettingCartList() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    print(uid);
    db.collection("cart").where("uid", isEqualTo: uid).getDocuments().then((
        QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        setState(() {
          cart.add(Product(
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
              f.data["quantity"],
              f.data["call_count"],
              f.data["views_count"],
              f.data["uid"],
              f.data["likes_count"]


          ));
        });
      });
      for(int i =0; i < cart.length; i++){
        cart[i].buyQuantity = 1;
        print(cart[i].buyQuantity);
      }
      totalMoney();
    });
    print(cart.length);


  }

  void removeCart(int i) {
    db.collection("cart").document(cart[i].product_id).delete();
  }
}