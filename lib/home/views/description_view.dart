import 'package:flutter/material.dart';

import 'package:crypto_currency/constants/constants.dart';

/// create a stateless widget to show the description of each news
class DescriptionView extends StatelessWidget {
  const DescriptionView({this.state, this.index});
  final state;
  final index;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: height * 0.30,
          child: Column(
            children: [
              Text(
                /// fetch the title of corresponding news
                state.results[index].title,
                style: kTextStyle,
              ),
              Row(
                children: [
                  Icon(
                    Icons.link_outlined,
                    color: Colors.grey,
                    size: 15.0,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        /// fetch the Domain of corresponding news
                        '${state.results![index].domain}',
                        textAlign: TextAlign.center,
                        style: kDomainStyle,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
