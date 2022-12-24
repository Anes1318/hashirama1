import 'dart:ffi';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// stranice
import 'pages/formule.dart';

void main() {
  runApp(MaterialApp(
    // home: Home(),
    routes: {
      '/': (context) => Home(),
      '/formule': (context) => FormuleHome(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String unos = '';
  String rezultat_string = '';
  double radni_rezultat = 0, zadnji_broj = 0;
  int broj_unesenih = 0;
  String last_op = '';
  int tema = 1;

  Widget brojDugme(String vrijednost) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () {
          if (vrijednost == '.') {
            if (unos.contains('.')) {
              return;
            }

            setState(() {
              unos += vrijednost;
              broj_unesenih++;
            });
          } else if (unos == '0') {
            setState(() {
              unos = vrijednost;
              broj_unesenih++;
              zadnji_broj = double.parse(unos);
            });
          } else {
            setState(() {
              unos += vrijednost;
              broj_unesenih++;
              zadnji_broj = double.parse(unos);
            });
          }
        },
        child: Text(
          '$vrijednost',
          style: TextStyle(
            color: (tema == 1) ? Colors.white : Colors.black,
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Widget jednakoDugme(String vrijednost) {
    return Container(
      child: TextButton(
        onPressed: () {
          if (unos == '' && rezultat_string == '') return;

          if (unos == '' && rezultat_string != '') {
            double broj = radni_rezultat;
            setState(() {
              rezultat_string = '';
              unos = broj.toString();
            });
            return;
          }
          double broj = double.parse(unos);
          if (unos != '' && rezultat_string == '') {
            setState(() {
              // print('PITE4');
              switch (last_op) {
                case '+':
                  radni_rezultat += zadnji_broj;
                  broj = radni_rezultat;
                  unos = broj.toString();

                  break;
                case '-':
                  radni_rezultat -= zadnji_broj;
                  broj = radni_rezultat;
                  unos = broj.toString();

                  break;
                case '*':
                  radni_rezultat *= zadnji_broj;
                  broj = radni_rezultat;
                  unos = broj.toString();

                  break;
                case '÷':
                  radni_rezultat /= zadnji_broj;
                  broj = radni_rezultat;
                  unos = broj.toString();
                  break;
                default:
                  unos = broj.toStringAsFixed(2);
                  break;
              }
              rezultat_string = '';
            });
          } else if (unos != '' && rezultat_string != '') {
            setState(() {
              switch (last_op) {
                case '+':
                  radni_rezultat += broj;
                  unos = radni_rezultat.toStringAsFixed(2);
                  rezultat_string = '';
                  break;
                case '-':
                  radni_rezultat -= broj;
                  unos = radni_rezultat.toStringAsFixed(2);
                  rezultat_string = '';
                  break;
                case '*':
                  radni_rezultat *= broj;
                  unos = radni_rezultat.toStringAsFixed(2);
                  rezultat_string = '';
                  break;
                case '÷':
                  if (broj == 0) {
                    return;
                  }
                  radni_rezultat /= broj;
                  unos = radni_rezultat.toStringAsFixed(2);
                  rezultat_string = '';
                  break;
                default:
              }
            });
          }
        },
        child: Text(
          '$vrijednost',
          style: TextStyle(
            color: (tema == 1) ? Colors.white : Colors.black,
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Widget snagaDugme(String vrijednost) {
    return Container(
      child: TextButton(
        onPressed: () {
          setState(() {
            if (unos == '') {
              return;
            }
            double broj = double.parse(unos);
            final radni_rezultat = pow(broj, 2);
            unos = radni_rezultat.toString();
          });
        },
        child: Text(
          '$vrijednost',
          style: TextStyle(
            color: (tema == 1) ? Colors.white : Colors.black,
            fontSize: 45,
          ),
        ),
      ),
    );
  }

  Widget operacijaDugme(String vrijednost) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (unos == '' && rezultat_string == '') {
              // print('PITE');
              return;
            }
            if (unos == '' && rezultat_string != '') {
              rezultat_string =
                  rezultat_string.substring(0, rezultat_string.length - 1);
              rezultat_string += '$vrijednost';
              last_op = vrijednost;
              return;
            }

            double broj = double.parse(unos);

            switch (vrijednost) {
              case '+':
                switch (last_op) {
                  case '-':
                    radni_rezultat -= broj;
                    break;
                  case '*':
                    radni_rezultat *= broj;
                    break;
                  case '÷':
                    if (broj == 0) {
                      return;
                    }
                    radni_rezultat /= broj;
                    break;
                  default:
                    radni_rezultat += broj;
                    break;
                }
                if (rezultat_string == '') {
                  radni_rezultat = broj;
                }

                unos = '';
                rezultat_string = radni_rezultat.toStringAsFixed(2) + '+';
                last_op = '+';
                break;
              case '-':
                switch (last_op) {
                  case '+':
                    radni_rezultat += broj;
                    break;
                  case '*':
                    radni_rezultat *= broj;
                    break;
                  case '÷':
                    if (broj == 0) {
                      return;
                    }
                    radni_rezultat /= broj;
                    break;
                  default:
                    radni_rezultat -= broj;
                    break;
                }
                if (rezultat_string == '') {
                  radni_rezultat = broj;
                }
                unos = '';
                rezultat_string = radni_rezultat.toStringAsFixed(2) + '-';
                last_op = '-';
                break;
              case '*':
                switch (last_op) {
                  case '+':
                    radni_rezultat += broj;
                    break;
                  case '-':
                    radni_rezultat -= broj;
                    break;
                  case '÷':
                    if (broj == 0) {
                      return;
                    }
                    radni_rezultat /= broj;
                    break;
                  default:
                    radni_rezultat *= broj;
                    break;
                }
                if (rezultat_string == '') {
                  radni_rezultat = broj;
                }
                unos = '';
                rezultat_string = radni_rezultat.toStringAsFixed(2) + '*';
                last_op = '*';
                break;
              case '÷':
                switch (last_op) {
                  case '+':
                    radni_rezultat += broj;
                    break;
                  case '*':
                    radni_rezultat *= broj;
                    break;
                  case '-':
                    radni_rezultat -= broj;
                    break;
                  default:
                    if (broj == 0) {
                      return;
                    }
                    radni_rezultat /= broj;
                    break;
                }
                if (rezultat_string == '') {
                  radni_rezultat = broj;
                }
                unos = '';

                rezultat_string = radni_rezultat.toStringAsFixed(2) + '÷';
                last_op = '÷';
                break;

              default:
            }
          });
        },
        child: Text(
          '$vrijednost',
          style: TextStyle(
            color: (tema == 1) ? Colors.white : Colors.black,
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormuleHome()),
            );
          },
          child: Icon(
            Icons.assignment,
            color: (tema == 1) ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: (tema == 1) ? Colors.black : Colors.grey.shade400,
        body: Container(
          margin: EdgeInsets.only(bottom: 40),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0,
                          color: (tema == 1)
                              ? Colors.blue
                              : Colors.orange.shade700,
                        ),
                        color:
                            (tema == 1) ? Colors.blue : Colors.orange.shade700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 320,
                        maxHeight: 30,
                        minHeight: 30,
                        minWidth: 320,
                      ),
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$rezultat_string',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: (tema == 1) ? Colors.white : Colors.black,
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0,
                          color: (tema == 1)
                              ? Colors.blue
                              : Colors.orange.shade700,
                        ),
                        color:
                            (tema == 1) ? Colors.blue : Colors.orange.shade700,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 320,
                        maxHeight: 60,
                        minHeight: 60,
                        minWidth: 320,
                      ),
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$unos',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: (tema == 1) ? Colors.white : Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      snagaDugme('X2'),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              unos = '';
                              rezultat_string = '';
                              last_op = '';
                              radni_rezultat = 0;
                              broj_unesenih = 0;
                            });
                          },
                          child: Text(
                            'AC',
                            style: TextStyle(
                              color: (tema == 1) ? Colors.white : Colors.black,
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (unos != '') {
                                unos = unos.substring(0, unos.length - 1);
                                broj_unesenih--;
                              }
                            });
                          },
                          child: Text(
                            'DEL',
                            style: TextStyle(
                              color: (tema == 1) ? Colors.white : Colors.black,
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),
                      operacijaDugme('÷'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      brojDugme('7'),
                      brojDugme('8'),
                      brojDugme('9'),
                      operacijaDugme('*'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      brojDugme('4'),
                      brojDugme('5'),
                      brojDugme('6'),
                      operacijaDugme('+'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      brojDugme('1'),
                      brojDugme('2'),
                      brojDugme('3'),
                      operacijaDugme('-'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (tema == 1) {
                                tema = 2;
                                return;
                              }
                              tema = 1;
                            });
                          },
                          padding: EdgeInsets.zero,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                          icon: Icon(
                            Icons.mode_night_outlined,
                            color: (tema == 1) ? Colors.white : Colors.black,
                            size: 50,
                          ),
                        ),
                      ),
                      brojDugme('0'),
                      brojDugme('.'),
                      jednakoDugme('='),
                    ],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ));
  }
}
