//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:shopify_app/models/ads.model.dart';
//import 'package:shopify_app/providers/adsProvider.dart';

//class CarouselSliderFirebaseWidget extends StatelessWidget {
  //const CarouselSliderFirebaseWidget({super.key, required this.ad});
  //final Ads ad;
 // @override
 // Widget build(BuildContext context) {
   // final adsProvider = Provider.of<AdsProvider>(context, listen: false);

   // return FutureBuilder<void>(
    //  future: adsProvider.getAds(),
    //  builder: (context, snapshot) {
      //  if (snapshot.connectionState == ConnectionState.waiting) {
        //  return CircularProgressIndicator();
       // } else if (snapshot.hasError) {
       //   return Text('Error loading ads');
       // } else {
       //   return Consumer<AdsProvider>(
          //  builder: (context, adsProvider, _) {
            //  return CarouselSlider.builder(
               // itemCount: adsProvider.adsList.length,
               // itemBuilder: (context, index, realIndex) {
                //  final ad = adsProvider.adsList[index];
              //    return Container(
                 //   child: Image.network(ad.imageUrl),
               //   );
             //   },
             //   options: CarouselOptions(
            //      aspectRatio: 16 / 9,
                //  viewportFraction: 0.8,
          //     //   initialPage: 0,
                //  autoPlay: true,
              //    autoPlayInterval: Duration(seconds: 3),
             //   ),
            //  );
           // },
       //   );
      //  }
    //  },
   // );
 // }
//}
