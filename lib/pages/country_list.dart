import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:learn_bloc/pages/country_details.dart';

// Bloc provider logic class using Cubit
class CountryListLogic extends Cubit<Map<String, dynamic>> {
  // initial state
  CountryListLogic()
      : super({'isLoading': false, 'countryList': [], 'error': null});

  // all logic functions
  void fetchCountryList() async {
    // update loading state
    emit({'isLoading': true, 'countryList': [], 'error': null});
    // make the api call
    try {
      final response = await http.get(Uri.parse(
          'https://countrylist.teamrabbil.com/public/api/country-list'));
      List<dynamic> countryListData = json.decode(response.body);
      debugPrint(countryListData.toString());
      // update the state
      emit({'isLoading': false, 'countryList': countryListData, 'error': null});
    } catch (e) {
      // update the state
      emit({'isLoading': false, 'countryList': [], 'error': e.toString()});
    }
  }
}

// country list page
class CountryListPage extends StatelessWidget {
  const CountryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // initially
    // call the fetchCountryList function from the bloc
    Future.microtask(
      () => context.read<CountryListLogic>().fetchCountryList(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Country List API')),
      // build the ui with BlocBuilder
      body: BlocBuilder<CountryListLogic, Map<String, dynamic>>(
          builder: (context, data) {
        // check the state
        if (data['isLoading'] == true) {
          return const Center(child: CircularProgressIndicator());
        } else if (data['error'] != null) {
          return Center(child: Text(data['error']));
        } else {
          return ListView.builder(itemBuilder: (context, index) {
            // display the country list
            return ListTile(
              leading: Image.network(data['countryList'][index]['flag']),
              title: Text(data['countryList'][index]['name']),
              subtitle: Text(data['countryList'][index]['capital']),
              onTap: () {
                // navigate to country details page with country name
                context
                    .read<NavigateToCountryDetailsPageLogic>()
                    .navigateToCountryDetailsPage(
                        context, data['countryList'][index]);
              },
            );
          });
        }
      }),
    );
  }
}
