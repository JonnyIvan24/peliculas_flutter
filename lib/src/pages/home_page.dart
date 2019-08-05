import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        // SafeArea sirve para desplegar componentes por debajo de la información principal del dispositivo
        // en pocas palabras por debajo de la hora o el estado de carga de la batería
        child: Text('Hola mundo...'),
      ),
    );
  }
}