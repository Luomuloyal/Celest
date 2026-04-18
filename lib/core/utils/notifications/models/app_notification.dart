class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    this.channelId,
    this.channelName,
    this.channelDescription,
  });

  final int id;
  final String title;
  final String body;
  final String? payload;
  final String? channelId;
  final String? channelName;
  final String? channelDescription;
}
