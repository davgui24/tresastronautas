import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tres_astronautas_flutter/src/utils/responsive.dart';

class Tarjeta extends StatelessWidget {
  dynamic item;
  Tarjeta({this.item});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
    return Container(
              margin: EdgeInsets.only(right: responsive.ip(2), left: responsive.ip(2), bottom: responsive.ip(2)),
              height: responsive.ip(22),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(251,251,251,30),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: responsive.ip(1),
                    right: responsive.ip(1),
                    child: CupertinoButton(
                      onPressed: (){},
                      padding: EdgeInsets.all(0),
                      minSize: 0,
                      child: Container(
                        height: responsive.ip(2),
                        width: responsive.ip(3),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/png/trespuntos.png'),
                            fit: BoxFit.contain,
                          ),
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: responsive.ip(3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    child: Image.network(
                                      item["images"]["original"]["url"],
                                      fit: BoxFit.cover,
                                      height: responsive.ip(13),
                                      width: responsive.ip(17),
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        // return Center(
                                        //   child: Container(
                                        //     height: responsive.ip(2),
                                        //     width: responsive.ip(2),
                                        //     child: CircularProgressIndicator(
                                        //       color: Colors.grey,
                                        //       value: loadingProgress.expectedTotalBytes != null
                                        //           ? loadingProgress.cumulativeBytesLoaded /
                                        //               loadingProgress.expectedTotalBytes!
                                        //           : null,
                                        //     ),
                                        //   ),
                                        // );
                                        return Container(
                                            margin: EdgeInsets.only(bottom: responsive.ip(4)),
                                            height: responsive.ip(5),
                                            width: responsive.ip(15),
                                            // margin: EdgeInsets.symmetric(vertical: responsive.ip(10)),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/gif/loadin.gif'),
                                                fit: BoxFit.cover,
                                              ),
                                              // shape: BoxShape.circle,
                                            ),
                                          );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: responsive.ip(0),
                                child: Container(
                                  height: responsive.ip(5),
                                  width: responsive.ip(5),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/png/corazon.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                  )
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: responsive.ip(15),
                            child: Text(item["title"],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: responsive.ip(2),
                                fontWeight: FontWeight.w900,
                                // fontStyle: FontStyle.italic
                              ),
                            ),
                          ),
                          SizedBox(width: responsive.ip(1))
                        ],
                      ),
                    ),
                  ),
                ],
              )
            );
  }
}