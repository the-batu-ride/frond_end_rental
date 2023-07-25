class Package {
  final int id;
  final String name;

  Package({required this.id, required this.name});

  @override
  String toString() {
    return name;
  }

  static List<Package> toModels(List<dynamic> json) =>
      json.map((e) => Package(id: e['id'], name: e['name'])).toList();
}
