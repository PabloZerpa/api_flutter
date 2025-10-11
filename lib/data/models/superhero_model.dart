class Superhero {
  final String id;
  final String name;
  final Powerstats powerstats;
  final Biography biography;
  final Appearance appearance;
  final Work work;
  final Connections connections;
  final Image image;

  Superhero({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.biography,
    required this.appearance,
    required this.work,
    required this.connections,
    required this.image,
  });

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      id: json['id']?.toString() ?? '0',
      name: json['name'] ?? 'Desconocido',
      powerstats: Powerstats.fromJson(json['powerstats'] ?? {}),
      biography: Biography.fromJson(json['biography'] ?? {}),
      appearance: Appearance.fromJson(json['appearance'] ?? {}),
      work: Work.fromJson(json['work'] ?? {}),
      connections: Connections.fromJson(json['connections'] ?? {}),
      image: Image.fromJson(json['image'] ?? {}),
    );
  }
}

class Powerstats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
      intelligence: json['intelligence'] ?? '0',
      strength: json['strength'] ?? '0',
      speed: json['speed'] ?? '0',
      durability: json['durability'] ?? '0',
      power: json['power'] ?? '0',
      combat: json['combat'] ?? '0',
    );
  }
}

class Biography {
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['full-name'] ?? 'Desconocido',
      alterEgos: json['alter-egos'] ?? 'No alter egos',
      aliases: List<String>.from(json['aliases'] ?? []),
      placeOfBirth: json['place-of-birth'] ?? 'Desconocido',
      firstAppearance: json['first-appearance'] ?? 'Desconocido',
      publisher: json['publisher'] ?? 'Desconocido',
      alignment: json['alignment'] ?? 'neutral',
    );
  }
}

class Appearance {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'] ?? 'Desconocido',
      race: json['race'] ?? 'Desconocido',
      height: List<String>.from(json['height'] ?? []),
      weight: List<String>.from(json['weight'] ?? []),
      eyeColor: json['eye-color'] ?? 'Desconocido',
      hairColor: json['hair-color'] ?? 'Desconocido',
    );
  }
}

class Work {
  final String occupation;
  final String base;

  Work({
    required this.occupation,
    required this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'] ?? 'Desconocido',
      base: json['base'] ?? 'Desconocido',
    );
  }
}

class Connections {
  final String groupAffiliation;
  final String relatives;

  Connections({
    required this.groupAffiliation,
    required this.relatives,
  });

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['group-affiliation'] ?? 'Ninguna',
      relatives: json['relatives'] ?? 'Ninguno',
    );
  }
}

class Image {
  final String url;

  Image({
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'] ?? '',
    );
  }
}