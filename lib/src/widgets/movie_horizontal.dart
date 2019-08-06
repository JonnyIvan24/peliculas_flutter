import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal ({@required this.peliculas, @required this.siguientePagina});

  // en el controller podemos configurar por medio de un PageController la forma de presentar las paginas
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    // no olvidemos que tambien podemos agregar listeners
    _pageController.addListener( () {
      // si llegamos cerca del final de la lista
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        // ejecutamos la funcion que mandamos por parametro desde el widget padre
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      // PageView sirve para mostrar datos de manera paginada
      // .builder hace que el PageView solo renderize los elementos que se vallan mostrando así evitamos consumir mucha memoria del dispositivo
      child: PageView.builder(
        controller: _pageController,
        // en la propiedad pageSnapping se le puede quitar el efecto de imantado al momento de hacer scroll y dejar que mantenga el momentum
        pageSnapping: false,
        // children: _tarjetas(context),
        // indicamos cual elemento va ir renderizando
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
        // el ser una lista dinamica tenemos que indicar cuanto elementos tiene la lista con la funcion .lenght
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            // en la propiedad overflow podemos poner algun dato o caracteriztica en caso de que el texto sea muy largo
            // en este caso con .ellipsis se ponen ... al final
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            // en la propiedad overflow podemos poner algun dato o caracteriztica en caso de que el texto sea muy largo
            // en este caso con .ellipsis se ponen ... al final
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
          ],
        ),
      );

    }).toList();

  }

}