class Amiibo {
  final String name;
  final String gameSeries;
  final String amiiboSeries;
  final String character;
  final String imageUrl;
  final Map<String, dynamic> releaseDates;
  final String head;
  final String tail;
  final String type;

  Amiibo({
    required this.name,
    required this.gameSeries,
    required this.amiiboSeries,
    required this.character,
    required this.imageUrl,
    required this.releaseDates,
    required this.head,
    required this.tail,
    required this.type,
  });

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      name: json['name'],
      gameSeries: json['gameSeries'],
      amiiboSeries: json['amiiboSeries'],
      character: json['character'],
      imageUrl: json['image'],
      releaseDates: json['release'],
      head: json['head'],
      tail: json['tail'],
      type: json['type'],
    );
  }
}
