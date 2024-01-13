import 'package:flutter/material.dart';
import 'package:reviews_slider/reviews_slider.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Create List which store string and this strings show below faces.
  List<String> list = ['Terrible', 'Bad', 'Okay', 'Good', 'Great'];
  // Create null variable because in this variable we store selected face text
  String selected_valueoftxt = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // Column used to get full height
        mainAxisAlignment: MainAxisAlignment
            .center, //  MainAxisAlignment.center helps to center the widget of height
        children: [
          Center(
            child: ReviewSlider(
                initialValue:
                    3, // initialValue 3 means our bydefault selected face is 3 which is in list is OKAY
                options:
                    list, // in options parameter we pass our list option which i mention above
                onChange: (int value) {
                  // onchange means trigger every time when user slide from one face to other face and it take int parameter using this parameter we find our selected face text in the list
                  selected_valueoftxt =
                      list[value]; // here we store current selected face value
                  setState(() {
                    // setState means it rebuild our app again but nowtime our selected_valueoftxt change
                  });
                }),
          ),
          // Now we implemented text and in this text our selected face text value show
          Text(
            selected_valueoftxt,
            style: TextStyle(
              color: Colors.black, // our text color is black
              fontSize:
                  20, // fontsize help to increase or decrease our size text
            ),
          )
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
