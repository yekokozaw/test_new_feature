import 'package:flutter/foundation.dart';

import '../state/enums.dart';

///Base of All BLoC class
class BaseBloc extends ChangeNotifier {
  ///Check is Dispose or not
  bool _dispose = false;

  ///Check API is Fetching, Done Fetch and Get Error
  LoadingState _loadingState = LoadingState.loading;

  LoadingState get getLoadingState => _loadingState;

  /// Error Message when API fetching has error
  String? _errorMessage;

  String? get getErrorMessage => _errorMessage;

  /// set Loading for Fetching API
  void setLoadingState() {
    _loadingState = LoadingState.loading;
    notifyListeners();
  }

  /// set Success for Done Fetching API
  void setSuccessState() {
    _loadingState = LoadingState.success;
    notifyListeners();
  }

  /// set Error for show Error
  void setErrorState({
    required String message,
  }) {
    _loadingState = LoadingState.error;
    _errorMessage = message;
    notifyListeners();
  }

  /// only notify state if only it is alive in widget tree
  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  /// make sure widget is dispose by using "_dispose" flag true
  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}