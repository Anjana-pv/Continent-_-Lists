import 'package:country_list/model/model.dart';
import 'package:flutter/material.dart';

class DiscrptionScreen extends StatelessWidget {
  final Country country;
  
  const DiscrptionScreen({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth * 0.3; // Adjust image size based on screen width
            double textSize = constraints.maxWidth * 0.04; // Adjust text size based on screen width
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        country.flag,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        country.name,
                        style: TextStyle(fontSize: textSize * 2, fontWeight: FontWeight.bold), // Increase font size
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  country.description,
                  style: TextStyle(fontSize: textSize),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
