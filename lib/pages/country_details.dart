import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// navigate to country details page from country list page (bloc logic class with cubit)
class NavigateToCountryDetailsPageLogic extends Cubit<void> {
  NavigateToCountryDetailsPageLogic() : super(null);

  // logic function with context and country data
  void navigateToCountryDetailsPage(
      BuildContext context, Map<String, dynamic> countryData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CountryDetailsPage(
                  countryData: countryData,
                )));
  }
}

// country details page
class CountryDetailsPage extends StatelessWidget {
  // country name
  final Map<String, dynamic> countryData;
  const CountryDetailsPage({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(countryData['name'])),
      body: Center(
        child: Column(
          // center the column
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          // display the country details
          children: [
            const Text('Country Details', style: TextStyle(fontSize: 20)),
            Text(countryData['name']),
            Text(countryData['capital']),
            Text(countryData['short_description']),
            // Text(countryData['subregion']),
          ],
        ),
      ),
    );
  }
}
