import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tres_astronautas_flutter/src/blocs/bloc_busqueda.dart';
import 'package:tres_astronautas_flutter/src/services/http_v1.dart';
import 'package:tres_astronautas_flutter/src/utils/responsive.dart';
import 'package:tres_astronautas_flutter/src/widgets/tarjeta.dart';

class DisenoPage extends StatefulWidget {
  const DisenoPage({Key? key}) : super(key: key);

  @override
  State<DisenoPage> createState() => _DisenoPageState();
}

class _DisenoPageState extends State<DisenoPage> {
  String tab = 'all'; // all, happyhours, drinks, beer, desserts, cocktails
  int _selectedIndex = 2;

  static const List<BottomNavigationBarItem> _navigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '')
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpV1().buscar(q: tab).then((itemsData){
      blocBusqueda.changeItems(itemsData["data"]);
    });
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
          items: _navigationItems,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(color: Colors.black, size: responsive.ip(5), opacity: 1),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: responsive.ip(3), opacity: 1),
          onTap: _onItemTapped,
        ),
        body: Container(
          height: double.infinity,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: responsive.ip(1)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: responsive.ip(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _logoNasa(responsive),
                      _logosBotones(responsive)
                    ],
                  ),
                ),
                SizedBox(height: responsive.ip(2)),
                 _favoritesMas(responsive),
                SizedBox(height: responsive.ip(2)),
                 _tabs(responsive, width),
                SizedBox(height: responsive.ip(2)),
                 _seleccion(responsive),
                SizedBox(height: responsive.ip(2)),
                 _busqueda(responsive)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoNasa(Responsive responsive){
    return Container(
            height: responsive.ip(10),
            width: responsive.ip(12),
            // margin: EdgeInsets.symmetric(vertical: responsive.ip(10)),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/png/nasa.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
          );
  }

  Widget _logosBotones(Responsive responsive){
    return Row(
      children: [
        CupertinoButton(
          padding: EdgeInsets.all(0),
          minSize: 0,
          onPressed: (){},
          child: Container(
            height: responsive.ip(5),
            width: responsive.ip(5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/png/notificacion.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: responsive.ip(1)),
        CupertinoButton(
          padding: EdgeInsets.all(0),
          minSize: 0,
          onPressed: (){},
          child: Container(
            height: responsive.ip(5),
            width: responsive.ip(5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/png/configuracion.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _favoritesMas(Responsive responsive){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.ip(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: responsive.ip(6),
            width: responsive.ip(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/png/favorites.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            minSize: 0,
            onPressed: (){},
            child: Container(
              height: responsive.ip(6.5),
              width: responsive.ip(6.5),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/png/mas.png'),
                  fit: BoxFit.fill,
                ),
                // shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs(Responsive responsive, double width){
    return Container(
      width: width * 0.9,
      height: responsive.ip(8),
      margin: EdgeInsets.symmetric(horizontal: responsive.ip(2)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _tab(responsive, 'All', (tab == 'all') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'all') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'all';
              });
            }),
            _tab(responsive, 'Happy Hours', (tab == 'happyhours') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'happyhours') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'happyhours';
              });
            }),
            _tab(responsive, 'Drinks', (tab == 'drinks') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'drinks') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'drinks';
              });
            }),
            _tab(responsive, 'Beer', (tab == 'beer') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'beer') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'beer';
              });
            }),
            _tab(responsive, 'Desserts', (tab == 'desserts') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'desserts') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'desserts';
              });
            }),
            _tab(responsive, 'Cocktails', (tab == 'cocktails') ? Color.fromRGBO(238, 127, 61, 1) : Colors.white, (tab == 'cocktails') ? Colors.white : Colors.black, (){
              setState(() {
                EasyLoading.show(status: "Cargando...");
                blocBusqueda.changeItems([]);
                HttpV1().buscar(q: tab).then((itemsData){
                  blocBusqueda.changeItems(itemsData["data"]);
                });
                tab = 'cocktails';
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _tab(Responsive responsive, String text, Color backgroundColor, Color textColor, Function function){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.ip(1)),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(2, 2)
              ),
          ]
        ),
        child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: responsive.ip(2.5), vertical: responsive.ip(1.8)),
          // minSize: 0,
          onPressed: () => function(),
          child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: responsive.ip(2),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
  }

  Widget _seleccion(Responsive responsive){
    String text = '';
    if(tab == 'all'){
      text = 'All';
    }else if(tab == 'happyhours'){
      text = 'Happy Hours';
    }else if(tab == 'drinks'){
      text = 'Drinks';
    }else if(tab == 'beer'){
      text = 'Beer';
    }else if(tab == 'desserts'){
      text = 'Desserts';
    }else if(tab == 'cocktails'){
      text = 'Cocktails';
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.ip(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsive.ip(4),
              fontWeight: FontWeight.w900,
            ),
          ),
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0),
            minSize: 0,
            onPressed: (){},
            child: Container(
              height: responsive.ip(5),
              width: responsive.ip(5),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/png/basurero.png'),
                  fit: BoxFit.fill,
                ),
                // shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _busqueda(Responsive responsive){
    String text = '';
    if(tab == 'all'){
      text = 'All';
    }else if(tab == 'happyhours'){
      text = 'Happy Hours';
    }else if(tab == 'drinks'){
      text = 'Drinks';
    }else if(tab == 'beer'){
      text = 'Beer';
    }else if(tab == 'desserts'){
      text = 'Desserts';
    }else if(tab == 'cocktails'){
      text = 'Cocktails';
    }

    return Container(
      height: responsive.ip(40),
      // color: Colors.red,
      child: StreamBuilder(
        stream: blocBusqueda.itemsStream,
        builder: (_, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            
            List<Tarjeta> itemsWidgets = [];
            for(var i in snapshot.data as List){
              itemsWidgets.add(Tarjeta(item: i));
            }
            if(snapshot.data!.isEmpty){
              EasyLoading.show(status: "Cargando...");
              return Container();
            }else{
              EasyLoading.dismiss();
              return SingleChildScrollView(
              child: Column(
                children: itemsWidgets,
              ),
             );
            }
            
          }else if(snapshot.hasError){
            EasyLoading.dismiss();
             return Container(
              margin: EdgeInsets.only(top: responsive.ip(7)),
               child: Center(
                 child: Text('Error al obtener la información!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: responsive.ip(3),
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),
               ),
             );
          }else{
            EasyLoading.dismiss();
              // return Center(
              //   child: Container(
              //     margin: EdgeInsets.only(top: responsive.ip(7)),
              //     child: const CircularProgressIndicator(
              //       color: Colors.black,
              //     ),
              //   ),
              // );
              // return Container(
              //     margin: EdgeInsets.only(top: responsive.ip(7)),
              //     height: responsive.ip(5),
              //     width: responsive.ip(15),
              //     // margin: EdgeInsets.symmetric(vertical: responsive.ip(10)),
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(
              //             'assets/gif/loadin.gif'),
              //         fit: BoxFit.fill,
              //       ),
              //       // shape: BoxShape.circle,
              //     ),
              //   );
              return Container(
               margin: EdgeInsets.only(top: responsive.ip(7)),
               child: Center(
                
                 child: Text('Cargando Información...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: responsive.ip(3.5),
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic
                    ),
                  ),
               ),
             );
          }
        }
      ),
    );
  }

}