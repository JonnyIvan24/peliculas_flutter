import 'package:flutter/material.dart';

/*
Se ne cesita crear una clase que extienda de la clase SearchDelegate e implementar sus 4 metodos
*/

class DataSearch extends SearchDelegate {

  String seleccion = '';

  final peliculas = ['Spiderman', 'Avengers', 'Shazam', 'El rey leon', 'X men'];

  final peliculasRecientes = ['Spiderman', 'Avengers'];

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
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightBlueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al ir escribiendo

    // se crea una variable para asignar los valores o posibles sugerencias
    // si esta vacio retornamos la lsta de peliculas recientes
    // si hay info en el query hacemos la busqueda en la lista de peliculas
    final listaSugerida = (query.isEmpty) 
                ? peliculasRecientes 
                : peliculas.where(
                  (p) => p.toLowerCase().startsWith(query.toLowerCase())
                  ).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            // showResults construye los resultados
            showResults(context);
          },
        );
      },
    );
  }

}