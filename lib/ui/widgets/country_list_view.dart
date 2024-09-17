import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/country_list_model.dart';

class CountryListView extends StatelessWidget {
  const CountryListView({super.key, required this.countryList});

  final List<CountryListModel> countryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(countryList[index].countryName?.commonName ?? ''),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    countryList[index].flag?.png ?? '',
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
