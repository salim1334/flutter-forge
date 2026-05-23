<% if (withModel) { %>
class <%= featurePascal %>Model {
  const <%= featurePascal %>Model({required this.id, required this.title});

  final String id;
  final String title;

  factory <%= featurePascal %>Model.fromJson(Map<String, dynamic> json) {
    return <%= featurePascal %>Model(
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}
<% } %>
