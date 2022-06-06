class PropertyClass {
  int id;
  String title;
  int bedroom;
  int bathroom;
  int hall;
  int kitchen;
  int balcony;
  double longitude;
  double latitude;
  String price;
  String sqr_price;
  String address;
  String video;
  String image;
  String description;

  String property_owner;
  String property_type;
  String lot_size;
  String sold;
  String load_area;
  String date;
  String email;

  PropertyClass(
      {this.id = 0,
      this.bathroom = 0,
      this.title = '',
      this.bedroom = 0,
      this.hall = 0,
      this.kitchen = 0,
      this.balcony = 0,
      this.price = '',
      this.sqr_price = '',
      this.address = '',
      this.video = '',
      this.date = '',
      this.description = '',
      this.email = '',
      this.image = '',
      this.load_area = '',
      this.lot_size = '',
      this.property_owner = '',
      this.property_type = '',
      this.sold = '',
      this.latitude = 0,
      this.longitude = 0});
}
