import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/productmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/categories/categories.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/myproducts/myproducts.dart';
import 'package:e_commerce_beta/ui/productdetail/productdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Order extends StatefulWidget {
  Order({Key key, this.title}) : super(key: key);
  String title;
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;
  List<Product> prevList = new List();
  List<Product> productList = new List();
  String email = "example@gmail.com";

  String uid;

  @override
  void initState() {
    // TODO: implement initState
    inputData();
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
                              _drawerKey.currentState.openDrawer();
                            },
                            icon: Icon(Icons.dehaze, color: Colors.white, size: 30.0,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                        child: Text(
                          "My Orders",
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
                      margin: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 10.0),
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
                        margin: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0),
                        child: Image.asset("assets/images/doubleclick.png"),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                        child: Text(
                          "It is my orders",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),

                    ],
                  ),
                ],
              ),
              productList.length != 0 ?
              Expanded(
                child:  ListView.builder(
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
                                              color: Colors.orangeAccent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.add_shopping_cart,
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
                        child: Icon(FontAwesomeIcons.store, size: 50,color: Colors.red,),
                      ),
                      Text("You didn't have any orders yet!", style: TextStyle(
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
                          builder: (_) => MyProducts(
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
                Navigator.pop(context);
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
//              Container(
//                color: Colors.white,
//                child: ListTile(
//                  title: Text('Cart'),
//                  trailing: Icon(
//                    Icons.shopping_cart,
//                    color: Colors.red,
//                  ),
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                          builder: (_) => Cart(
//                            title: "Cart page",
//                          ),
//                        ));
////                Navigator.pop(context);
//                  },
//                ),
//              ),
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
      readDataFromFireStore();
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
    print(uid);

      db.collection("orders").where("uid", isEqualTo: uid).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            productList.add(Product(
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
          productList.sort((a, b){
            return b.current_date.compareTo(a.current_date);
          });
          productList = productList;
        });
        for(int i = 0; i< productList.length; i++){
          print(productList[i].current_date.toString()  + productList[i].is_feature.toString() + productList[i].product_id);
        }
      });



  }


}
