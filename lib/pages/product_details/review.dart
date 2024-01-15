import 'package:flutter/material.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:shopify_app/pages/master_page.dart';
import 'package:shopify_app/pages/product_details.page.dart';
import 'package:shopify_app/widgets/button_icon.widget.dart';
import 'package:shopify_app/widgets/headline.widget.dart';

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
      appBar: AppBar(
          title: Text("Reviews"),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => MasterPage()));
            },
            icon: Icon(Icons.arrow_back),
          )),
      body: Column(
        // Column used to get full height
        mainAxisAlignment: MainAxisAlignment
            .center, //  MainAxisAlignment.center helps to center the widget of height
        children: [
          Text(
            "Rate Our Product",
            style: TextStyle(
                color: Color(0xff515C6F),
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
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
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            " How Was The Delivery ?",
            style: TextStyle(
                color: Color(0xff515C6F),
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),

          SizedBox(
            height: 30,
          ),
          Center(
            child: ReviewSlider(
                initialValue: 3,
                options: list,
                onChange: (int value) {
                  selected_valueoftxt = list[value];
                  setState(() {});
                }),
          ),

          Text(
            selected_valueoftxt,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),

          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => MasterPage()));
            },
            child: ButtonIconWidget(
              txt: 'Submit',
              con: Icons.arrow_forward_ios_outlined,
              clcon: Color(0xffff6969),
              clcont: Color(0xffffffff),
              cltxt: Color(0xffffffff),
              backcl: Color(0xffff6969),
            ),
          )
        ],
      ),
    );
  }
}
