class PackageModel {
  final String name;
  final double price;
  final String timePeriod;
  final List<String> features;

  PackageModel({required this.name, required this.price, required this.timePeriod, required this.features});
  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      name: json['name'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] ?? 0.0).toDouble(),
      timePeriod: json['time_period'] ?? 0,
      features: List<String>.from(json['features'] ?? []),
    );
  }

  /// Convert PackageModel to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'time_period': timePeriod, 'features': features};
  }
}

List<PackageModel> groupClass = [
  PackageModel(
    name: "Single Class",
    price: 195,
    timePeriod: "7 Days",
    features: ["1 group session", "Certified trainer", "Access to any open class"],
  ),
  PackageModel(
    name: "5 Class Pack",
    price: 895,
    timePeriod: "20 Days",
    features: ["5 group sessions", "Flexible timing", "Beginner to advanced levels"],
  ),
  PackageModel(name: "10 Class Pack", price: 1695, timePeriod: "30 Days", features: ["10 sessions", "Priority booking", "Free guest pass"]),
  PackageModel(
    name: "15 Class Pack",
    price: 2295,
    timePeriod: "45 Days",
    features: ["15 sessions", "Progress tracking", "Water & towel service"],
  ),
  PackageModel(
    name: "20 Class Pack",
    price: 2895,
    timePeriod: "45 Days",
    features: ["20 sessions", "Extended booking window", "2 free guest passes"],
  ),
  PackageModel(
    name: "Monthly Membership",
    price: 3995,
    timePeriod: "30 Days",
    features: ["Unlimited classes", "VIP access", "10% off in-studio purchases"],
  ),
];
List<PackageModel> privateClass = [
  PackageModel(
    name: "Private - Single Class",
    price: 495,
    timePeriod: "7 Days",
    features: ["1 private session", "Certified personal trainer", "Tailored to your goals"],
  ),
  PackageModel(
    name: "Private - 5 Class Pack",
    price: 2295,
    timePeriod: "15 Days",
    features: ["5 private sessions", "One-on-one coaching", "Flexible schedule"],
  ),
  PackageModel(
    name: "Private - 10 Class Pack",
    price: 3995,
    timePeriod: "20 Days",
    features: ["10 private sessions", "Dedicated personal trainer", "Progress tracking included"],
  ),
  PackageModel(
    name: "Private - 20 Class Pack",
    price: 6995,
    timePeriod: "35 Days",
    features: ["20 private sessions", "Comprehensive goal plan", "Priority scheduling"],
  ),
];
