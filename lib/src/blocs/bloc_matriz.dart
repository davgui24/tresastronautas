
import 'package:rxdart/rxdart.dart';

class MatrizBloc {

  final _filasController = BehaviorSubject<int>();
  final _columnasController = BehaviorSubject<int>();
  final _matrixController = BehaviorSubject<List<List>>();


Stream<int> get filasStream => _filasController.stream;
Stream<int> get columnasStream => _columnasController.stream;
Stream<List<List>> get matrizStream => _matrixController.stream;
Stream<bool> get validarColumnasFilasStream => CombineLatestStream.combine2(filasStream, columnasStream, (f, c) => true);

int? get filas => _filasController.value;
int? get columnas => _columnasController.value;
List<List>? get matriz => _matrixController.value;

Function(int) get changeFilas => _filasController.sink.add;
Function(int) get changeColumnas => _columnasController.sink.add;
Function(List<List>) get changeMatrix => _matrixController.sink.add;


// HasValue
  bool get filasStreamHasValue => _filasController.hasValue;
  bool get columnasStreamHasValue => _columnasController.hasValue;


  dispose() {
    _filasController.close();
    _columnasController.close();
    _matrixController.close();
  }


}

MatrizBloc blocMatriz = MatrizBloc();