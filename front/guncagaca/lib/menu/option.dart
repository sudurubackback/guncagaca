class Option {
  final String label;
  final int price;

  Option({required this.label, required this.price});

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      label: map['label'],
      price: map['price'],
    );
  }
}