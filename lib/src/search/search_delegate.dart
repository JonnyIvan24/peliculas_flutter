import 'package:flutter/material.dart';

/*
Se ne cesita crear una clase que extienda de la clase SearchDelegate e implementar sus 4 metodos
*/

class DataSearch extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro navBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          // la variable query es el texto que tenemos en el input del search
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Los iconos a la izquierda de appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // con la función cerramos la ventana del SearchDelegate, nos pide el contexto y los resultados
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Es a instrucción que crea los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al ir escribiendo
    return Container();
  }

}