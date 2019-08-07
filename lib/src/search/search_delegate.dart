import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/pelicual_provider.dart';

/*
Se ne cesita crear una clase que extienda de la clase SearchDelegate e implementar sus 4 metodos
*/

class DataSearch extends SearchDelegate {

  String seleccion = '';
  // instanciamos un objeto de la clase PeliculasProvider para hacer la busqueda de peliculas
  final peliculasProvider = new PeliculasProvider();

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
    
      if (query.isEmpty) return Container();

      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          
          if(snapshot.hasData){
            
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  }

}