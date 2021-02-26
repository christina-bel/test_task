/// Класс цвета
class Colour {
  int _id;
  String _name, _color;

  Colour(Map<String, dynamic> json) {
    _id = json['id'] ?? 0;
    _name = json['name'] ?? 'unknown colour';
    _color = json['color']?.replaceAll('#', '0xFF') ?? '';
  }

  /// Геттеры приватных свойств цвета
  int get color => int.tryParse(_color);

  String get name => _name;

  int get id => _id;
}
