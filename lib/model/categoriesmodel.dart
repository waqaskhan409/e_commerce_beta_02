class CategoriesModel{
  String _images;
  String _name;

  CategoriesModel(this._images, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get images => _images;

  set images(String value) {
    _images = value;
  }


}