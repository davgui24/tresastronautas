
import 'package:rxdart/rxdart.dart';

class BusquedaBloc {

final _itemsController = BehaviorSubject<List>();



Stream<List> get itemsStream => _itemsController.stream;

List? get items => _itemsController.value;

Function(List) get changeItems => _itemsController.sink.add;


  dispose() {
    _itemsController.close();
  }

}

BusquedaBloc blocBusqueda = BusquedaBloc();