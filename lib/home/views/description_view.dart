

import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({this.state, this.index});
  final state;
  final index;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.black,
                    offset: Offset(0, 2),
                    spreadRadius: 1)
              ]),
          height: height * 0.15,

          child: Column(
            children: [
              Text(
                state.results[index].title,
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                state.results[index].domain,style:TextStyle(fontSize: 20,color: Colors.white)
              )
            ],
          ),
        ),
      ),
    );
  }
}
