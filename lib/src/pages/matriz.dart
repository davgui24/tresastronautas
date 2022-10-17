
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:tres_astronautas_flutter/src/blocs/bloc_matriz.dart';
import 'package:tres_astronautas_flutter/src/services/toast.dart';

import '../utils/responsive.dart';

class Matriz extends StatefulWidget {
  @override
  State<Matriz> createState() => _MatrizState();
}

class _MatrizState extends State<Matriz> {
  TextEditingController controladorN = TextEditingController();
  late bool _botonCrearMatriz;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _botonCrearMatriz = false;
    //  ******************************
    //  blocMatriz.changeColumnas(5);
    //  blocMatriz.changeFilas(5);
    //  controladorN.text = 5.toString();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.ip(7)),
        child: AppBar(
          elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.black,
              title: Text('Ingresar matriz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.ip(3.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'diseno_page');
                  }, icon: Icon(Icons.arrow_circle_right_rounded, size: responsive.ip(5), ))
              ]
        ),
      ),
      body: Container(
        height: height,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: responsive.ip(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _textN(context, height, width, responsive),
                  ],
                ),
                _llenarMatriz(responsive),
                SizedBox(height: responsive.ip(2)),
                _numerodeIslas(responsive),
                SizedBox(height: responsive.ip(2)),
                _mostrarMatriz(responsive)
              ],
            ),
          ),
        ),
      ),
    );
  }


  
 Widget _textN(BuildContext context, double height, double width, Responsive responsive){
    String text = controladorN.text.isEmpty ? '' : controladorN.text;
    controladorN.text = controladorN.text.isEmpty ? '' : controladorN.text;
    controladorN.selection = TextSelection.collapsed(offset: controladorN.text.length);

    return Container(
      margin: EdgeInsets.symmetric(vertical: responsive.ip(1)),
      child: Column(
        children: [
          Text('# Intoduzca un número (N)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsive.ip(2.5),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: responsive.ip(0.5)),
          Container(
            height: responsive.ip(6),
            width: responsive.ip(15),
            child: TextField(
                    enabled: true,
                    controller: controladorN,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: responsive.ip(1.8),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      // labelText: text,
                      labelStyle: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        try{
                          int.parse(controladorN.text).toString();
                        }catch(e){
                          toastService.showToastCenter(context: context, text: 'No es un número', durationSeconds: 1);
                          controladorN.clear();
                        }
                      });
                    },
                  )
          ),
        ],
      ),
    );
  }

 Widget _llenarMatriz(Responsive responsive){
    return CupertinoButton(
        color: Colors.black,
        padding: EdgeInsets.all(responsive.ip(1.5)),
        minSize: 0,
      child: Text("Llenar matriz: NxN",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: (controladorN.text.isEmpty) ? Colors.grey : Colors.white,
                        fontSize: responsive.ip(2.5)
                    )
                ), 
              onPressed: (controladorN.text.isEmpty) 
              ? null 
              : (){
                if(controladorN.text.isEmpty){
                  toastService.showToastCenter(context: context, text: "Llene los campos de la matriz", durationSeconds: 1);
                  return;
                }
                
                List<List> matriz = [];
                blocMatriz.changeFilas(int.parse(controladorN.text));
                blocMatriz.changeColumnas(int.parse(controladorN.text));
            
                for(int i=0; i<int.parse(controladorN.text); i++){
                  List filas = [];
                  for(int j=0; j<int.parse(controladorN.text); j++){
                    var infoCelda = {
                      "idIsla": "", 
                      "fila": i,
                      "columna": j,
                      "valor": false
                    };
                    filas.add(infoCelda);
                  }
                  matriz.add(filas);
                }
                blocMatriz.changeMatrix(matriz);
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                setState(() {
                  islas  = [];
                });
              } 
            );
 }


  Widget _mostrarMatriz(Responsive responsive){
    return Container(
      height: responsive.ip(150),
      width: responsive.ip(150),
      child: StreamBuilder(
        stream: blocMatriz.matrizStream,
        builder: (_, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            // print(blocMatriz.matriz);

            List<TableRow>  filas = [];
            blocMatriz.matriz!.asMap().forEach((indexF, fila) {
              List<Widget> columnas = [];
              fila.asMap().forEach((indexC, columna) {
                columnas.add(
                    // Text("${columna["fila"]},${columna["columna"]}",
                    //   textAlign: TextAlign.center,
                    //   textScaleFactor: 1.5,
                    //   style: TextStyle(
                    //     fontSize: responsive.ip(2.5),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // )
                    Checkbox(
                      value: columna["valor"],
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          List<List> matriz = blocMatriz.matriz as List<List>;
                          matriz.asMap().forEach((inf, f) {
                            f.asMap().forEach((inc, c) {
                              if(columna["fila"] == c["fila"] && columna["columna"] == c["columna"]){
                                columna["valor"] = value;
                                 blocMatriz.changeMatrix(matriz);
                                 _mostrarTierrasYAguas(blocMatriz.matriz as List<List>, c);
                              }
                            });
                          });
                        });
                      },
                    )
                  );
              });
              filas.add(TableRow(children: columnas));
            });
             
             return Container(
              child: Table(
                children: filas,
            ),
            );
          }else{
            return Container(
            );
          }
        }
      ),
    );
 }

List islas = [];
void _mostrarTierrasYAguas(List<List> matriz, dynamic celda){
  if(celda["valor"] == false){
        islas.removeWhere((element) => (element["fila"] == celda["fila"] && element["columna"] == celda["columna"]));
  }else{
    bool conecoConOtraCelda = false;
    dynamic celdaALaQueConecto;

    matriz.asMap().forEach((inf, f) {
      f.asMap().forEach((inc, c) {
        if(c["valor"] == true && celda["valor"] == true){
          // VALIDAMOS LOS PUNTOS DE ALREDEDOR
          // CELDA ARRIBA ***  c["fila"] == celda["fila"]-1 && c["columna"] == celda["columna"]
          // CELDA ABAJO ***  c["fila"] == celda["fila"]+1 && c["columna"] == celda["columna"]
          // CELDA IZQUIERDA ***  c["columna"] == celda["columna"]-1 && c["fila"] == celda["fila"]
          // CELDA DERECHA ***  c["columna"] == celda["columna"]+1 && c["fila"] == celda["fila"]

          if(
            c["fila"] == celda["fila"]-1 && c["columna"] == celda["columna"] ||
            c["fila"] == celda["fila"]+1 && c["columna"] == celda["columna"] ||
            c["columna"] == celda["columna"]-1 && c["fila"] == celda["fila"] ||
            c["columna"] == celda["columna"]+1 && c["fila"] == celda["fila"]
          ){
            conecoConOtraCelda = true;
            celdaALaQueConecto = c;
          }else{
          }
        }
      });
    });

    if(conecoConOtraCelda == true){
      celda["idIsla"] = celdaALaQueConecto["idIsla"];
    }else{
      String idHhexString = ObjectId().hexString;
      celda["idIsla"] = idHhexString;
    }

    if(celda["valor"] == false){
          islas.removeWhere((element) => (element["fila"] == celda["fila"] && element["columna"] == celda["columna"]));

    }


    blocMatriz.changeMatrix(matriz);
    blocMatriz.matriz!.asMap().forEach((indexF, celdasF) {
      celdasF.asMap().forEach((indexC, celdasC) {
        if(celdasC["idIsla"].toString().isNotEmpty){
          islas.add(celdasC);
          return;
        }
      });
    });
  }
}



Widget _numerodeIslas(Responsive responsive){
  final Map<String, dynamic> mapFilter = {};
  for (Map<String, dynamic> myMap in islas) {
      mapFilter[myMap['idIsla']] = myMap;
  }

  islas = mapFilter.keys.map((key) => mapFilter[key] as Map<String,dynamic>).toList();
  return Text("Número de Islas: ${islas.length}",
      textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: responsive.ip(3)
        )
    );
}
}

