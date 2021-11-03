class Washing {
  String heading;
  String subheading;
  int price;
  String image;
  int counter;
  Washing(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.image,
      required this.counter});
}

List<Washing> mens = [
  Washing(
    heading: 'T-shirt',
    subheading: "Wash Only",
    image: 'asset/images/t-shirt.jpg',
    price: 101,
    counter: 0,
  ),
  Washing(
    heading: 'Shirt',
    subheading: "Wash Only",
    image: 'asset/images/shirt.jpg',
    price: 158,
    counter: 0,
  ),
  Washing(
    heading: 'Jeans',
    subheading: "Wash Only",
    image: 'asset/images/jeans.jpg',
    price: 160,
    counter: 0,
  ),
  Washing(
    heading: 'Jacket',
    subheading: "Wash Only",
    image: 'asset/images/jacket.JPG',
    price: 302,
    counter: 0,
  ),
  Washing(
    heading: 'Sweater',
    subheading: "Wash Only",
    image: 'asset/images/sweater.JPG',
    price: 256,
    counter: 0,
  ),
  Washing(
    heading: 'Trouser',
    subheading: "Wash Only",
    image: 'asset/images/trouser.JPG',
    price: 100,
    counter: 0,
  ),
  Washing(
    heading: 'Shalwar Kameez (simple)',
    subheading: "Wash Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 110,
    counter: 0,
  ),
  Washing(
    heading: 'Shalwar Kameez (Cotton)',
    subheading: "Wash Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 120,
    counter: 0,
  ),
];
List<Washing> women = [
  Washing(
    heading: 'Shalwar Kameez 2 pc',
    subheading: "Wash Only",
    image: 'asset/images/women2.JPG',
    price: 127,
    counter: 0,
  ),
  Washing(
    heading: 'Shalwar Kameez 3 pc',
    subheading: "Wash Only",
    image: 'asset/images/women3.JPG',
    price: 151,
    counter: 0,
  ),
  Washing(
    heading: 'Scarf',
    subheading: "Wash Only",
    image: 'asset/images/scarf.jpg',
    price: 115,
    counter: 0,
  ),
  Washing(
    heading: 'Abaya',
    subheading: "Wash Only",
    image: 'asset/images/abaya.JPG',
    price: 210,
    counter: 0,
  ),
];
List<Washing> kids = [
  Washing(
    heading: 'Shirt',
    subheading: "Wash Only",
    image: 'asset/images/shirt.jpg',
    price: 51,
    counter: 0,
  ),
  Washing(
    heading: 'Jeans',
    subheading: "Wash Only",
    image: 'asset/images/jeans.jpg',
    price: 125,
    counter: 0,
  ),
  Washing(
    heading: 'Jacket',
    subheading: "Wash Only",
    image: 'asset/images/jacket.JPG',
    price: 205,
    counter: 0,
  ),
  Washing(
    heading: 'Sweater',
    subheading: "Wash Only",
    image: 'asset/images/sweater.JPG',
    price: 230,
    counter: 0,
  ),
  Washing(
    heading: 'Trouser',
    subheading: "Wash Only",
    image: 'asset/images/trouser.JPG',
    price: 57,
    counter: 0,
  ),
  Washing(
    heading: 'Shalwar Kameez',
    subheading: "Wash Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 117,
    counter: 0,
  ),
];
List<Washing> others = [
  Washing(
    heading: 'Towel (small)',
    subheading: "Wash Only",
    image: 'asset/images/towels.jpg',
    price: 45,
    counter: 0,
  ),
  Washing(
    heading: 'Towel (Large)',
    subheading: "Wash Only",
    image: 'asset/images/towell.jpg',
    price: 75,
    counter: 0,
  ),
  Washing(
    heading: 'Bedsheet (Single)',
    subheading: "Wash Only",
    image: 'asset/images/bedsheet.jpg',
    price: 122,
    counter: 0,
  ),
  Washing(
    heading: 'Bedsheet (Double)',
    subheading: "Wash Only",
    image: 'asset/images/bedsheetd.jpg',
    price: 152,
    counter: 0,
  ),
  Washing(
    heading: 'Pillow Cover',
    subheading: "Wash Only",
    image: 'asset/images/pillowcover.jpg',
    price: 42,
    counter: 0,
  ),
  Washing(
    heading: 'Blanket (Single)',
    subheading: "Wash Only",
    image: 'asset/images/blinkets.jpg',
    price: 355,
    counter: 0,
  ),
  Washing(
    heading: 'Blanket (Double)',
    subheading: "Wash Only",
    image: 'asset/images/blinketd.jpg',
    price: 405,
    counter: 0,
  ),
  Washing(
    heading: 'Quilt / Comforter',
    subheading: "Wash Only",
    image: 'asset/images/comforter.jpg',
    price: 402,
    counter: 0,
  ),
  Washing(
    heading: 'Coushion Cover',
    subheading: "Wash Only",
    image: 'asset/images/cousioncover.jpg',
    price: 104,
    counter: 0,
  ),
  Washing(
    heading: 'Carpet (Per sqr ft)',
    subheading: "Wash Only",
    image: 'asset/images/carpet.jpg',
    price: 15,
    counter: 0,
  ),
];

class Ironing {
  String heading;
  String subheading;
  int price;
  String image;
  int counter;
  Ironing(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.image,
      required this.counter});
}

List<Ironing> imens = [
  // Ironing(
  //   heading: 'T-shirt',
  //   subheading: "Iron Only",
  //   image: 'asset/images/t-shirt.jpg',
  //   price: 101,
  //   counter: 0,
  // ),
  Ironing(
    heading: 'Shirt',
    subheading: "Iron Only",
    image: 'asset/images/shirt.jpg',
    price: 20,
    counter: 0,
  ),
  Ironing(
    heading: 'Jeans',
    subheading: "Iron Only",
    image: 'asset/images/jeans.jpg',
    price: 25,
    counter: 0,
  ),
  // Ironing(
  //   heading: 'Jacket',
  //   subheading: "Iron Only",
  //   image: 'asset/images/jacket.JPG',
  //   price: 302,
  //   counter: 0,
  // ),
  Ironing(
    heading: 'Sweater',
    subheading: "Iron Only",
    image: 'asset/images/sweater.JPG',
    price: 30,
    counter: 0,
  ),
  // Ironing(
  //   heading: 'Trouser',
  //   subheading: "Iron Only",
  //   image: 'asset/images/trouser.JPG',
  //   price: 100,
  //   counter: 0,
  // ),
  Ironing(
    heading: 'Shalwar Kameez (simple)',
    subheading: "Iron Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 52,
    counter: 0,
  ),
  Ironing(
    heading: 'Shalwar Kameez (Cotton)',
    subheading: "Iron Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 60,
    counter: 0,
  ),
];
List<Ironing> iwomen = [
  Ironing(
    heading: 'Shalwar Kameez 2 pc',
    subheading: "Iron Only",
    image: 'asset/images/women2.JPG',
    price: 65,
    counter: 0,
  ),
  Ironing(
    heading: 'Shalwar Kameez 3 pc',
    subheading: "Iron Only",
    image: 'asset/images/women3.JPG',
    price: 70,
    counter: 0,
  ),
  Ironing(
    heading: 'Scarf',
    subheading: "Iron Only",
    image: 'asset/images/scarf.jpg',
    price: 15,
    counter: 0,
  ),
  Ironing(
    heading: 'Abaya',
    subheading: "Iron Only",
    image: 'asset/images/abaya.JPG',
    price: 32,
    counter: 0,
  ),
];
List<Ironing> ikids = [
  Ironing(
    heading: 'Shirt',
    subheading: "Iron Only",
    image: 'asset/images/shirt.jpg',
    price: 12,
    counter: 0,
  ),
  Ironing(
    heading: 'Jeans',
    subheading: "Iron Only",
    image: 'asset/images/jeans.jpg',
    price: 14,
    counter: 0,
  ),
  // Ironing(
  //   heading: 'Jacket',
  //   subheading: "Iron Only",
  //   image: 'asset/images/jacket.JPG',
  //   price: 205,
  //   counter: 0,
  // ),
  // Ironing(
  //   heading: 'Sweater',
  //   subheading: "Iron Only",
  //   image: 'asset/images/sweater.JPG',
  //   price: 230,
  //   counter: 0,
  // ),
  Ironing(
    heading: 'Trouser',
    subheading: "Iron Only",
    image: 'asset/images/trouser.JPG',
    price: 16,
    counter: 0,
  ),
  Ironing(
    heading: 'Shalwar Kameez',
    subheading: "Iron Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 35,
    counter: 0,
  ),
];

class DryClean {
  String heading;
  String subheading;
  int price;
  String image;
  int counter;
  DryClean(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.image,
      required this.counter});
}

List<DryClean> dmens = [
  DryClean(
    heading: 'Shirt',
    subheading: "DryClean Only",
    image: 'asset/images/shirt.jpg',
    price: 59,
    counter: 0,
  ),
  DryClean(
    heading: 'Sweater',
    subheading: "DryClean Only",
    image: 'asset/images/sweater.JPG',
    price: 249,
    counter: 0,
  ),
  DryClean(
    heading: 'Trouser',
    subheading: "DryClean Only",
    image: 'asset/images/trouser.JPG',
    price: 98,
    counter: 0,
  ),
  DryClean(
    heading: 'Shalwar Kameez (Cotton)',
    subheading: "DryClean Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 128,
    counter: 0,
  ),
];
List<DryClean> dwomen = [
  DryClean(
    heading: 'Shalwar Kameez 2 pc',
    subheading: "DryClean Only",
    image: 'asset/images/women2.JPG',
    price: 129,
    counter: 0,
  ),
  DryClean(
    heading: 'Shalwar Kameez 3 pc',
    subheading: "DryClean Only",
    image: 'asset/images/women3.JPG',
    price: 159,
    counter: 0,
  ),
  DryClean(
    heading: 'Scarf',
    subheading: "DryClean Only",
    image: 'asset/images/scarf.jpg',
    price: 119,
    counter: 0,
  ),
  DryClean(
    heading: 'Abaya',
    subheading: "DryClean Only",
    image: 'asset/images/abaya.JPG',
    price: 210,
    counter: 0,
  ),
];
List<DryClean> dkids = [
  DryClean(
    heading: 'Shirt',
    subheading: "DryClean Only",
    image: 'asset/images/shirt.jpg',
    price: 51,
    counter: 0,
  ),
  DryClean(
    heading: 'Sweater',
    subheading: "DryClean Only",
    image: 'asset/images/sweater.JPG',
    price: 109,
    counter: 0,
  ),
  DryClean(
    heading: 'Trouser',
    subheading: "DryClean Only",
    image: 'asset/images/trouser.JPG',
    price: 59,
    counter: 0,
  ),
  DryClean(
    heading: 'Shalwar Kameez',
    subheading: "DryClean Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 139,
    counter: 0,
  ),
];
List<DryClean> dothers = [
  DryClean(
    heading: 'Towel (small)',
    subheading: "DryClean Only",
    image: 'asset/images/towels.jpg',
    price: 47,
    counter: 0,
  ),
  DryClean(
    heading: 'Towel (Large)',
    subheading: "DryClean Only",
    image: 'asset/images/towell.jpg',
    price: 85,
    counter: 0,
  ),
  DryClean(
    heading: 'Bedsheet (Single)',
    subheading: "DryClean Only",
    image: 'asset/images/bedsheet.jpg',
    price: 133,
    counter: 0,
  ),
  DryClean(
    heading: 'Bedsheet (Double)',
    subheading: "DryClean Only",
    image: 'asset/images/bedsheetd.jpg',
    price: 156,
    counter: 0,
  ),
  DryClean(
    heading: 'Pillow Cover',
    subheading: "DryClean Only",
    image: 'asset/images/pillowcover.jpg',
    price: 42,
    counter: 0,
  ),
  DryClean(
    heading: 'Blanket (Single)',
    subheading: "DryClean Only",
    image: 'asset/images/blinkets.jpg',
    price: 320,
    counter: 0,
  ),
  DryClean(
    heading: 'Blanket (Double)',
    subheading: "DryClean Only",
    image: 'asset/images/blinketd.jpg',
    price: 425,
    counter: 0,
  ),
  DryClean(
    heading: 'Quilt / Comforter',
    subheading: "DryClean Only",
    image: 'asset/images/comforter.jpg',
    price: 405,
    counter: 0,
  ),
  DryClean(
    heading: 'Coushion Cover',
    subheading: "DryClean Only",
    image: 'asset/images/cousioncover.jpg',
    price: 112,
    counter: 0,
  ),
];

class Folding {
  String heading;
  String subheading;
  int price;
  String image;
  int counter;
  Folding(
      {required this.heading,
      required this.subheading,
      required this.price,
      required this.image,
      required this.counter});
}

List<Folding> fmens = [
  Folding(
    heading: 'Shirt',
    subheading: "Folding Only",
    image: 'asset/images/shirt.jpg',
    price: 5,
    counter: 0,
  ),
  Folding(
    heading: 'Jeans',
    subheading: "Folding Only",
    image: 'asset/images/jeans.jpg',
    price: 6,
    counter: 0,
  ),
  Folding(
    heading: 'Sweater',
    subheading: "Folding Only",
    image: 'asset/images/sweater.JPG',
    price: 7,
    counter: 0,
  ),
  Folding(
    heading: 'Shalwar Kameez (simple)',
    subheading: "Folding Only",
    image: 'asset/images/shalwar_kmeez.jpg',
    price: 8,
    counter: 0,
  ),
];
List<Folding> fwomen = [
  Folding(
    heading: 'Shalwar Kameez 2 pc',
    subheading: "Folding Only",
    image: 'asset/images/women2.JPG',
    price: 9,
    counter: 0,
  ),
  Folding(
    heading: 'Shalwar Kameez 3 pc',
    subheading: "Folding Only",
    image: 'asset/images/women3.JPG',
    price: 10,
    counter: 0,
  ),
  Folding(
    heading: 'Abaya',
    subheading: "Folding Only",
    image: 'asset/images/abaya.JPG',
    price: 11,
    counter: 0,
  ),
];
