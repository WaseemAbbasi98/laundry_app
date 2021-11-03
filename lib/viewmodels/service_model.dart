class Services {
  String title;
  String subtitle;
  bool istapped;

  String img;
  Services(
      {required this.title,
      required this.subtitle,
      required this.img,
      required this.istapped});
}

List<Services> servicelsit = <Services>[
  Services(
      title: 'Washing',
      subtitle: 'Easy Washing',
      img: 'asset/images/washingicon.JPG',
      istapped: false),
  Services(
      title: 'Ironing',
      subtitle: 'Easy Ironing',
      img: 'asset/images/ironingicon.JPG',
      istapped: false),
  Services(
      title: 'DryClean',
      subtitle: 'Easy dryclean',
      istapped: false,
      img: 'asset/images/drycleanicon.JPG'),
  Services(
      title: 'Folding',
      subtitle: 'Easy folding',
      istapped: false,
      img: 'asset/images/foldingicon.JPG'),
];
