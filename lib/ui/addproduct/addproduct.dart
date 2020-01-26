import 'dart:collection';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_beta/model/categoriesmodel.dart';
import 'package:e_commerce_beta/ui/addproduct/succesfullyaddproduct.dart';
import 'package:e_commerce_beta/ui/home/home.dart';
import 'package:e_commerce_beta/ui/registeration/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'imagepickerhandler.dart';

class AddProductItem extends StatefulWidget {
  AddProductItem({Key key, this.title}) : super(key: key);
  String title;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProductItem>
    with TickerProviderStateMixin, ImagePickerListener {
  final ownerController = TextEditingController();
  final ownerMobileNumberController = TextEditingController();
  final productController = TextEditingController();
  final catigoryController = TextEditingController();
  final shorDesController = TextEditingController();
  final longDesController = TextEditingController();
  final Controller = TextEditingController();
  final priceController = TextEditingController();
  final isPriceNegotiableController = TextEditingController();
  final cityController = TextEditingController();
  final quantityController = TextEditingController();
  ProgressDialog pr;

//  final Controller = TextEditingController();


  final db = Firestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  List<CategoriesModel> list = new List();
  List<String> provice = new List();

  String _nameProduct = "Add Product";
  String category = "Tap me";
  String province = "Tap me";
  String dateString = "Tap me";
  bool isFeature = false;
  int _current = 0;
  File imageProduct;
  List<File> images = new List();
  int imageIndex;
  AnimationController _controller;
  int sliderIndex = 0;
  ImagePickerHandler imagePicker;
  String printValue = "";
  IconData icon = Icons.camera;
  String uid ;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    pr = new ProgressDialog(context);
    pr.style(message: "Adding product ...");
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;

    // here you write the codes to input the data into firestore
  }
  @override
  Widget build(BuildContext context) {
    list.clear();
    provice.clear();
    images.add(imageProduct);
    images.add(imageProduct);
    images.add(imageProduct);
    list.add(new CategoriesModel("assets/images/pets.png", "Pets"));
    list.add(new CategoriesModel("assets/images/appliances.png", "Home appliances"));
    list.add(new CategoriesModel("assets/images/furniture.png", "Furniture"));
    list.add(new CategoriesModel("assets/images/wardrobe.png", "Wardrobe"));
    list.add(new CategoriesModel(
        "assets/images/mobiles.png", "Mobiles and accessories"));
    list.add(new CategoriesModel("assets/images/kitchen.png", "Kitchen"));
    list.add(new CategoriesModel("assets/images/garden.png", "Garden"));
    list.add(new CategoriesModel("assets/images/vehicles.png", "Showroom"));
    list.add(new CategoriesModel(
        "assets/images/miscellaneous.png", "miscellaneous"));

    provice.add("Balochistan");
    provice.add("Sindh");
    provice.add("Punjab");
    provice.add("KPK");



    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/login.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          key:  _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: _splashBody(),
        ),
      ],
    );
  }

  Widget _splashBody() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                  child: Text(
                    "Add product",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  )),
              Container(
                  width: 150.0,
                  child: Text(
                    "Login to start ordering your favourite products",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ))
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 500,
                  child: setupFormAddProduct(),
                ),
              ],
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void returnFunction(int index) {
    this.imageIndex = index;
    imagePicker.showDialog(context);
  }

  Widget setupFormAddProduct() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Owner",
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
                    controller: ownerController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Owner Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Owner mobile number",
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
                    controller: ownerMobileNumberController,

                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the mobile number";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: '03XXXXXXXXX'),
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Product Name",
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
                    controller: productController,

                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the product name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Product Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Product Catigory",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showCategory();

                  },

                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                     category

                    ),
                ),
                ),
                Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Short Description",
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
                    controller: shorDesController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please write the short description";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Short Description'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Long Description",
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
                    controller: longDesController,

                    validator: (text){
                      if(text.isEmpty){
                        return "Please write the long description";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Long Description'),
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Price",
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
                    controller: priceController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the price of product";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Price'),
                  ),
                ),
                Container(


                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Is Price negotiable ?",
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
                    controller: isPriceNegotiableController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please write something like yes or no...";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Yes or No'),
                  ),
                )
                ,Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Quantity",
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
                    controller: quantityController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the Quantity of product";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                    new InputDecoration.collapsed(hintText: 'Price'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Expiry date",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showDate(context);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(dateString),
                  ),
                ),

                Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Provice",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showProvince();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                    padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(province),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "City",
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
                    controller: cityController,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please put the city name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                    new InputDecoration.collapsed(hintText: 'Quetta, etc'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Featured",
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
                  child: Checkbox(
                    value: isFeature,
                    onChanged: (T){
                     setState(() {
                       isFeature = T;
                     });
                    },
                  ),
                ),
                Divider()
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 5.0, 0.0, 5.0),
                  child: Text(
                    "1st Image of product",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  height: 400,
                  margin: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 5.0),
                  child: GestureDetector(
                    onTap: () {
                      returnFunction(0);
                    },
                    child: new Center(
                      child: images[0] == null
                          ? Container(
                              color: Colors.blue,
                            )
                          : Container(
                        width: double.infinity,
                        child: Image.file(images[0]),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 5.0, 0.0, 5.0),
                  child: Text(
                    "2nd Image of product",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  height: 400,
                  margin: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 5.0),
                  child: GestureDetector(
                    onTap: () {
                      returnFunction(1);
                    },
                    child: new Center(
                      child: images[1] == null
                          ? Container(
                              color: Colors.red,
                            )
                          : Container(
                        width: double.infinity,
                        child: Image.file(images[1]),
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "3rd Image of product",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  height: 400,
                  margin: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
                  child: GestureDetector(
                    onTap: () {
                      returnFunction(2);
                    },
                    child: new Center(
                      child: images[2] == null
                          ? Container(
                              color: Colors.indigo,
                            )
                          : Container(
                              width: double.infinity,
                              child: Image.file(images[2]),
                            ),
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(30.0, 35.0, 10.0, 10.0),
                        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: FlatButton(
                            onPressed: () {
                              showDialogue();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 35.0, 30.0, 10.0),
                        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: FlatButton(
                            onPressed: () async {
                              String ownerS, ownerNumerS, productNameS, productCategoryS, quantityS, shortDesS, longDesS, priceS, isNegotiableS, cityS;


                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                               if(images[0] != null || images[1] != null || images[2] != null){
                                 if(province != "Tap me" && category != "Tap me" && dateString != "Tap me"){
                                   pr.show();
                                   ownerS = ownerController.text;
                                   ownerNumerS = ownerMobileNumberController.text;
                                   productNameS = productController.text;
//                                   productCategoryS = catigoryController.text;
                                   shortDesS = shorDesController.text;
                                   longDesS = longDesController.text;
                                   priceS = priceController.text;
                                   quantityS = quantityController.text;
                                   isNegotiableS = isPriceNegotiableController.text;
                                   cityS = cityController.text;
                                   Map<String, Object> product = new HashMap();
                                   product['owner'] = ownerS;
                                   product['owner_number'] = ownerNumerS;
                                   product['product'] = productNameS;
                                   product['prduct_category'] = category;
                                   product['shot_desc'] = shortDesS;
                                   product['long_desc'] = longDesS;
                                   product['price'] = priceS;
                                   product['quantity'] = quantityS;
                                   product['is_negotiable'] = isNegotiableS;
                                   product['city'] = cityS;
                                   product['province'] = province;
                                   product['is_feature'] = isFeature;
                                   product['expire_date'] = dateString;
                                   product['uid'] = uid;
                                   product['current_date'] = DateTime.now();
                                   product['image_1'] = "image";
                                   product['image_2'] = "image";
                                   product['image_3'] = "image";
                                   DocumentReference document = await db.collection("products").add(product);
                                   print(document.documentID);
                                   for(int i = 0; i < images.length; i++){
                                     if(images[i] != null){
                                     print(_pickSaveImage(images[i],document.documentID, i));
                                     }
                                   }

                                   pr.dismiss();
                                   Navigator.pushAndRemoveUntil(
                                       context,
                                       MaterialPageRoute(
                                         builder: (_) => SuccesfullAddProduct(
                                           title: "Success page",
                                           documentId: document.documentID,
                                           productName: productNameS,
                                         ),
                                       ),
                                           (e) => false);
                                 }else{
                                   _scaffoldKey.currentState
                                       .showSnackBar(SnackBar(content: Text('Please select the check the form again')));
                                 }
                               }else{
                                 _scaffoldKey.currentState
                                     .showSnackBar(SnackBar(content: Text('Please select the one image atleast of product')));
                               }
                              }else{
                                _scaffoldKey.currentState
                                    .showSnackBar(SnackBar(content: Text('Please check the form again and fill the field again!')));
                              }


//                              Navigator.pushAndRemoveUntil(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (_) => Home(
//                                      title: "Home page",
//                                    ),
//                                  ),
//                                      (e) => false);
                            },
                            child: Text(
                              _nameProduct,
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*Widget setupAddProduct(int indexSlide) {
    return CarouselSlider.builder(
        height: 300,
        initialPage: indexSlide,
        itemCount: 6,
        viewportFraction: 1.0,
        onPageChanged: (i) {
          if (i == 5) {
            setState(() {
              _nameProduct = "Add product";
              _current = i;
            });
          } else {
            setState(() {
              _nameProduct = "Next";
              _current = i;
            });
          }
        },
        itemBuilder: (BuildContext context, int i) {
          print("Slider: $i");

          if (i == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Owner",
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
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Owner Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Owner mobile number",
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: '03XXXXXXXXX'),
                  ),
                ),
              ],
            );
          } else if (i == 1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Product Name",
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
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'Product Name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Product Catigory",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showDialogue();
                  },
                    child: Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
                  padding: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: TextFormField(
                    onChanged: (String){
                      showCategory();
                    },
                    onTap: (){
                      showDialogue();
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'pets, cars or etc'),
                  ),
                )),
              ],
            );
          } else if (i == 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                  child: Text(
                    "Short Description",
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
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Short Description'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Long Description",
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
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Long Description'),
                  ),
                ),
              ],
            );
          } else if (i == 3) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                  child: Text(
                    "Quantity",
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    decoration:
                        new InputDecoration.collapsed(hintText: 'example: 10'),
                  ),
                ),
              ],
            );
          } else if (i == 4) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 40.0, 0.0, 10.0),
                    child: Text(
                      "Price",
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
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Price'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                    child: Text(
                      "Is Price negotiable",
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Yes or No'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 15.0, 0.0, 10.0),
                    child: Text(
                      "Expiry Date",
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration: new InputDecoration.collapsed(
                          hintText: 'Put expiry Date'),
                    ),
                  ),
                ],
              ),
            );
          } else if (i == 5) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 5.0, 0.0, 5.0),
                    child: Text(
                      "1st Image of product",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 400,
                    margin: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 5.0),
                    child: GestureDetector(
                      onTap: () {
                        returnFunction(0);
                      },
                      child: new Center(
                        child: images[0] == null
                            ? Container(
                                color: Colors.blue,
                              )
                            : new Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(images[0].path),
                                    fit: BoxFit.cover,
                                  ),
//                border:
//                Border.all(color: Colors.red, width: 5.0),
//                borderRadius:
//                new BorderRadius.all(const Radius.circular(80.0)),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 5.0, 0.0, 5.0),
                    child: Text(
                      "2nd Image of product",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 400,
                    margin: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 5.0),
                    child: GestureDetector(
                      onTap: () {
                        returnFunction(1);
                      },
                      child: new Center(
                        child: images[1] == null
                            ? Container(
                                color: Colors.red,
                              )
                            : new Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(images[1].path),
                                    fit: BoxFit.cover,
                                  ),
//                border:
//                Border.all(color: Colors.red, width: 5.0),
//                borderRadius:
//                new BorderRadius.all(const Radius.circular(80.0)),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "3rd Image of product",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    height: 400,
                    margin: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
                    child: GestureDetector(
                      onTap: () {
                        returnFunction(2);
                      },
                      child: new Center(
                        child: images[2] == null
                            ? Container(
                                color: Colors.indigo,
                              )
                            : new Container(
                                width: double.infinity,
                                child: Image.file(images[2]),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
*/
  @override
  userImage(File _image) {
    setState(() {
      print(imageIndex);
      this.images[imageIndex] = _image;
      print(this.images[imageIndex]);
    });
  }

  void showDialogue() {
    showMaterialDialog<String>(
      context: context,
      child: AlertDialog(
        content: Text(
          'Discard the Product form?',
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Theme.of(context).textTheme.caption.color),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context, 'cancel');
            },
          ),
          FlatButton(
            child: const Text('DISCARD'),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Home(
                      title: "Home page",
                      filter: "All",
                    ),
                  ),
                  (e) => false);
            },
          ),
        ],
      ),
    );
  }

  void showProvince(){
    showMaterialDialog<String>(
      context: context,
      child: AlertDialog(
          title: Text("Select the Category"),
          content:  Container(
            margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: ListView.builder(
              itemCount: provice.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: (){
                    setState(() {

                      province = provice[i];
                      print(province);
                      Navigator.pop(context, 'cancel');
                    });
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
                    margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 8.0),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                          child: Text(
                            provice[i],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions:null
      ),
    );
  }

  void showCategory(){
    showMaterialDialog<String>(
      context: context,
      child: AlertDialog(
        title: Text("Select the Category"),
        content:  Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: (){
                  setState(() {

                    category = list[i].name;
                    print(category);
                    Navigator.pop(context, 'cancel');
                  });
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
                  margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 8.0),
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
        ),
        actions:null
      ),
    );
  }
  Future<String> _pickSaveImage(File image, String document, int index) async {
//    request.auth != null
    var imageFileName =  DateTime.now().millisecondsSinceEpoch;
    StorageReference ref =
    FirebaseStorage.instance.ref().child("products_images").child(imageFileName.toString()+"image.jpg");
    StorageUploadTask uploadTask = ref.putFile(image);
    String imge = await (await uploadTask.onComplete).ref.getDownloadURL();
    if(index == 0 ){
      Map<String, Object> imagesMap = new HashMap();
      String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      imagesMap["image_1"] = imageUrl;
      imagesMap["thumbnailmm"] = imageUrl;
      Future<void> doc = db.collection("products").document(document).updateData(imagesMap);
    }else if(index  == 1){
      Map<String, Object> imagesMap = new HashMap();
      String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      imagesMap["image_2"] = imageUrl;
      imagesMap["thumbnail"] = imageUrl;
      Future<void> doc = db.collection("products").document(document).updateData(imagesMap);

    }else if(index == 2){
      Map<String, Object> imagesMap = new HashMap();
      String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      imagesMap["image_1"] = imageUrl;
      imagesMap["thumbnail"] = imageUrl;
      Future<void> doc = db.collection("products").document(document).updateData(imagesMap);

    }
return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
  

  Future<Null> showDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030));
    if (picked != null && picked != DateTime.now())
      setState(() {
        dateString = picked.toString();
      });
  }

  void showMaterialDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
