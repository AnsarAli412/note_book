class NoteModel {
  NoteModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
