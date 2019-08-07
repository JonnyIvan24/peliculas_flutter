import 'package:flutter/material.dart';

/*
Se ne cesita crear una clase que extienda de la clase SearchDelegate e implementar sus 4 metodos
*/

class DataSearch extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro navBar
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Los iconos a la izquierda de appBar
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Es a instrucción que crea los resultados a mostrar
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al ir escribiendo
    return null;
  }

}