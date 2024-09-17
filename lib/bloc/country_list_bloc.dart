
import 'package:flutter/cupertino.dart';
import 'package:test_new_feature/data/service/country_list_service.dart';

import '../data/model/country_list_model.dart';

enum CountryState {loading, success, error }

class CountryListBloc extends ChangeNotifier{

  final CountryListService _service = CountryListService();
  CountryState _countryState = CountryState.loading;
  List<CountryListModel> _countryList = [];
  List<CountryListModel> _secondCountryList = [];
  String? _errorMessage;
  String? _secondError;

  CountryState get countryState => _countryState;
  List<CountryListModel> get countryList => _countryList;
  List<CountryListModel> get secondCountryList => _secondCountryList;
  String? get errorMessage => _errorMessage;
  String? get secondError => _secondError;

  CountryListBloc(){
    ///fetch country list
    getCountryList();
    getSecondCountryList();
  }

  Future<void> getCountryList() async{
    _countryState = CountryState.loading;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 2000));
    _service.getCountryList().then((countries){
      _countryList = countries;
      _countryState = CountryState.success;
      notifyListeners();
    }).catchError((onError){
      _errorMessage = onError.toString();
      _countryState = CountryState.error;
      notifyListeners();
    });
  }

  Future<void> getSecondCountryList() async{
    _service.getCountryList().then((countries){
      _secondCountryList = countries;
      notifyListeners();
    }).catchError((onError){
      _secondError = onError.toString();
      notifyListeners();
    });
  }
}
