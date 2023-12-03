class City {
  final int? id;
  final String name;
  final String imagePath;

  City({this.id, required this.name, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
    );
  }
}
