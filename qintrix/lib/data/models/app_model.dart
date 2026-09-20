class AppModel {
  const AppModel({
    required this.id,
    required this.name,
    required this.isEnabled,
    required this.apiKey,
    required this.allowedPrinterIds,
    required this.allowedPrinterNames,
    required this.createdAt,
    required this.updatedAt,
    this.description,
  });

  final String id;
  final String name;
  final bool isEnabled;
  final String apiKey;
  final List<String> allowedPrinterIds;
  final List<String> allowedPrinterNames;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;

  bool get allowsAllPrinters => allowedPrinterIds.isEmpty;

  AppModel copyWith({
    String? id,
    String? name,
    bool? isEnabled,
    String? apiKey,
    List<String>? allowedPrinterIds,
    List<String>? allowedPrinterNames,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
  }) {
    return AppModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
      apiKey: apiKey ?? this.apiKey,
      allowedPrinterIds: allowedPrinterIds ?? this.allowedPrinterIds,
      allowedPrinterNames: allowedPrinterNames ?? this.allowedPrinterNames,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
    );
  }
}
