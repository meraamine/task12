import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/models/ads.model.dart';
import 'package:shopify_app/widgets/carousel_slider_ex.dart';

class AdsProvider extends StatelessWidget {
  final CollectionReference adsCollection =
      FirebaseFirestore.instance.collection('ads');

  Future<List<Ads>> getAds() async {
    QuerySnapshot querySnapshot = await adsCollection.get();
    List<Ads> adsList = [];
    for (var document in querySnapshot.docs) {
      Ads ad =
          Ads.fromJson(document.data() as Map<String, dynamic>, document.id);
      adsList.add(ad);
    }
    return adsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ads>>(
      future: getAds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Ads> adsList = snapshot.data!;
          return CarouselSliderEx(
            adsList: adsList,
            onBtnPressed: () {
              // Handle button press event here
            },
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
