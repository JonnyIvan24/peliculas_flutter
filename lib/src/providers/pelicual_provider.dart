import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actores_model.dart';

class PeliculasProvider {

  String _apyKey      = '2901cde95371f399f890b0378b4d1b03';
  String _url         = 'api.themoviedb.org';
  String _language    = 'es-MX';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  // creamos el objeto de tipo stream
  // con .broadcast podemos mas de un listener al stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  // metodo para intruducir datos
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  // metodo para escuchar datos
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;



  void disposeStreams(){
    // si el stream tiene informacion se cierra
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    // esperar la respuesta http
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    //print(decodeData['results']);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    //print(peliculas.items[0].title);

    return peliculas.items;
  }


  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apyKey,
      'language': _language
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    // si estoy cargando retorno una lista vacia
    if (_cargando) return [];
    
    _cargando = true;
    // cada vez que se ejecute este metodo auentaremos el valor del page como aoarece en la api de las peliculas osea 1,2,3...
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apyKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    // añadimos toda la respuesta "lista de Pelicula" a la variable _populares
    _populares.addAll(resp);

    // intoducimos la información al stream
    popularesSink(_populares);

    _cargando = false;

    return resp;

  }

  Future<List<Actor>> getCast(String peliId) async {

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apyKey,
      'language': _language
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Cast.jsonList(decodeData['cast']);

    return cast.actores;

  }

}
