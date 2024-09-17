
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/country_list_model.dart';
import '../../data/service/country_list_service.dart';
import 'country_list_state.dart';


class CountryListNotifier extends Notifier<CountryListState>{
  final CountryListService _countryListService = CountryListService();
  @override
  CountryListState build() {
    return CountryListLoading();
  }

  void getCountryList() async{
    try{
      state = CountryListLoading();
      final List<CountryListModel> countryList = await _countryListService.getCountryList();
      state = CountryListSuccess(countryList);
    }
    catch(e){
      state = CountryListFailed('Something was wrong!');
    }
  }
}