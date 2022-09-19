import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ShopScreen  extends StatefulWidget {
  ShopScreen ({Key? key}) : super(key: key);

  @override
  State<ShopScreen > createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen > {

  TextEditingController questionController = new TextEditingController();
  TextEditingController questionController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.blueGrey],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: const Text('Shop'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Coin Amount : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: questionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter coin amount here',
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Lives Amount : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: questionController2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter lives amount here',
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if(questionController.text.toString().isNotEmpty&&questionController2.text.toString().isNotEmpty)
                  {
                    CollectionReference question = FirebaseFirestore.instance.collection('shop');
                    question.add(
                        {
                          "coinforlives": questionController.text.toString(),
                          "lives": questionController2.text.toString(),
                        }).then((value){
                      print(value.id);
                    });
                    questionController.clear();
                    questionController2.clear();
                  }
                //DocumentReference question = FirebaseFirestore.instance.collection('question').doc('1');
              },
              child: Center(child: Text('Save to database')),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  onPrimary: Colors.white,
                  shape: StadiumBorder()
              ),
            ),
          ),
        ],
      ),
    );
  }
}
