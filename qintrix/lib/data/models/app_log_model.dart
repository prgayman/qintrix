class AppLogModel {
  const AppLogModel({
    required this.id,
    required this.level,
    required this.eventType,
    required this.title,
    required this.message,
    required this.createdAt,
    this.metadata,
  });

  final String id;
  final String level;
  final String eventType;
  final String title;
  final String message;
  final DateTime createdAt;
  final String? metadata;
}
