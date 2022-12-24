import 'package:flutter/material.dart';

import 'package:hashirama1/main.dart';

class FormuleHome extends StatefulWidget {
  const FormuleHome({super.key});

  @override
  State<FormuleHome> createState() => FormuleHomeState();
}

class FormuleHomeState extends State<FormuleHome> {
  double hashirama(context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  Widget Formula(String formula, String jedinica) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          constraints: BoxConstraints(
            maxWidth: hashirama(context),
          ),
          child: FittedBox(
            child: Text(
              '$formula ($jedinica)',
              style: TextStyle(
                color: Colors.indigo.shade400,
                fontSize: 30,
                fontFamily: 'FiraCode',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Formula('V = S / t', 'm/s'),
              Formula('Φ = B * S cos α', 'Wb'),
              Formula('Fl = qBr', 'N'),
              Formula('Fa = IlB sin α', 'N'),
              Formula('ε = VBl', 'Volt'),
              Formula('T = t/N', 'S'),
              Formula('f = N/t', 'Hz'),
              Formula('T = 2π √(m/k)', 'S'),
              Formula('f = 1/(2π√k/m)', 'Hz'),
              Formula('K = N/m', ''),
              Formula('F = k * X', 'N'), // tenk ju Ena
            ],
          ),
        ),
      ),
    );
  }
}
