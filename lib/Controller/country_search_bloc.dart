import 'dart:async';

class CountrySearchBloc {
  String _value = "";

  final searchControllerState = StreamController<String>.broadcast();

  Sink<String> get strValue => searchControllerState.sink;

  Stream<String> get value => searchControllerState.stream;

}
