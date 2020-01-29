import 'package:e_commerce_beta/model/categoriesmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/addproduct.dart';
import 'package:e_commerce_beta/ui/cart/cart.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/login/login.dart';
import 'package:e_commerce_beta/ui/myproducts/allproduct.dart';
import 'package:e_commerce_beta/ui/myproducts/myproducts.dart';
import 'package:e_commerce_beta/ui/order/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({Key key, this.title}) : super(key: key);
  String title;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoriesModel> list = new List();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String email = "example@gmail.com";

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String uid;


  @override
  void initState() {
    // TODO: implement initState
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    list.add(new CategoriesModel("assets/images/pets.png", "Pets"));
    list.add(
        new CategoriesModel("assets/images/appliances.png", "Home appliances"));
    list.add(new CategoriesModel("assets/images/furniture.png", "Furniture"));
    list.add(new CategoriesModel("assets/images/wardrobe.png", "Wardrobe"));
    list.add(new CategoriesModel(
        "assets/images/mobiles.png", "Mobiles and accessories"));
    list.add(new CategoriesModel("assets/images/kitchen.png", "Kitchen"));
    list.add(new CategoriesModel("assets/images/garden.png", "Garden"));
    list.add(new CategoriesModel("assets/images/vehicles.png", "Showroom"));
    list.add(new CategoriesModel(
        "assets/images/miscellaneous.png", "miscellaneous"));
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/union.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.transparent,
        drawer: returnDrawer(),
        drawerEdgeDragWidth: 0,
        body: Container(
            margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
              Column(children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                          child:IconButton(
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
                          "CATEGORIES",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ]),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (_) => Home(
                                  title: "Home page",
                                  filter: list[i].name,
                                ),
                              ));
                        },
                        child: Container(
                          height: 60.0,
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
                          margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 8.0),
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(list[i].images),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  list[i].name,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ]),
            ]))),
      )
    ]);
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
          /*Container(
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
                            title: "My list",
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
                Navigator.pop(context);

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
}
