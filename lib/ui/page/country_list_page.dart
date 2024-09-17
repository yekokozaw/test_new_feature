import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/country_list_model.dart';
import '../../state/country_list/country_list_notifier.dart';
import '../../state/country_list/country_list_state.dart';
import '../widgets/country_list_view.dart';
import '../widgets/error_country_widget.dart';

class CountryListPage extends ConsumerStatefulWidget {
  const CountryListPage({super.key});

  @override
  ConsumerState<CountryListPage> createState() => _CountryListPageState();
}

class _CountryListPageState extends ConsumerState<CountryListPage> {
  final TextEditingController _addressController = TextEditingController();
  CountryListNotifier? countryListNotifier;
  final countryNotifierProvider =
  NotifierProvider<CountryListNotifier, CountryListState>(() {
    return CountryListNotifier();
  });

  @override
  void initState() {
    super.initState();

    ///call after the ui build is complete
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      countryListNotifier?.getCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    countryListNotifier = ref.read(countryNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AddressTextField(controller: _addressController),
          Expanded(child: CountryListBody(countryNotifierProvider: countryNotifierProvider)),
        ],
      ),
    );
  }
}

// Separate widget for TextField to prevent unnecessary rebuilds
class AddressTextField extends StatelessWidget {
  final TextEditingController controller;

  const AddressTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: const TextStyle(fontSize: 18),
        controller: controller,
        cursorColor: Colors.deepOrange,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(color: Colors.blue),
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: const Icon(Icons.location_on),
          labelText: 'Address',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: Colors.deepOrange), // Bottom border color when focused
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

// Separate widget for displaying the country list that listens to the state
class CountryListBody extends ConsumerWidget {
  final NotifierProvider<CountryListNotifier, CountryListState> countryNotifierProvider;

  const CountryListBody({Key? key, required this.countryNotifierProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryListNotifier = ref.read(countryNotifierProvider.notifier);
    final countryListState = ref.watch(countryNotifierProvider);

    return switch (countryListState) {
      CountryListLoading() => const Center(
        child: CircularProgressIndicator(),
      ),
      CountryListSuccess(countryList: List<CountryListModel> countryList) =>
          CountryListView(countryList: countryList),
      CountryListFailed(showError: String error) => Center(
        child: ErrorCountryWidget(
          errorCountry: error,
          tryAgain: () {
            countryListNotifier.getCountryList();
          },
        ),
      ),
    };
  }
}
