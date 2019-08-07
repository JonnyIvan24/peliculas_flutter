

class Cast {
  List<Actor> actores = new List();

  Cast.jsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach( (item) {
      final actor = Actor.jsonMap(item);
      actores.add(actor);
    });
  }

}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.jsonMap( Map<String, dynamic> json ){
    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getPosterImg() {

    if (profilePath == null){ // si no tenemos un dato para la imagen posterPath enviamos una por defecto
      return 'https://www.imaswmp.in/wp-content/uploads/default-avatar.jpg';
    } else{   // caso contrario mandamos la ruta de la imagen para el poster
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }

  }

}

