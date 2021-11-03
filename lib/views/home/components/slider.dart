import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class Cslider extends StatelessWidget {
  const Cslider({Key? key}) : super(key: key);

  // const Cslider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        disableCenter: true,
        height: 220.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: [
        _sliderContainer(
            image: 'asset/images/washing.jpg',
            heading: 'Electraction',
            sub_heading: 'Our skilled worker will help you'),
        _sliderContainer(
            image: 'asset/images/ironing.jpg',
            heading: 'Electraction',
            sub_heading: 'Our skilled worker will help you'),
        _sliderContainer(
            image: 'asset/images/dryclean.jpg',
            heading: 'Electraction',
            sub_heading: 'Our skilled worker will help you'),
        _sliderContainer(
            image: 'asset/images/folding.jpg',
            heading: 'Electraction',
            sub_heading: 'Our skilled worker will help you'),
      ],
    );
  }

  Widget _sliderContainer(
      {required String image,
      required String heading,
      required String sub_heading}) {
    return Opacity(
      opacity: 1,
      child: Container(
        // margin: EdgeInsets.only(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
