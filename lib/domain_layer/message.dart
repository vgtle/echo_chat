class Message {
  final String message;
  final String username;
  final DateTime time;

  Message({
    required this.message,
    required this.username,
    required this.time,
  });

  bool get isMe => username == "me";

  Message copyWith({
    String? message,
    String? username,
    DateTime? time,
  }) {
    return Message(
      message: message ?? this.message,
      username: username ?? this.username,
      time: time ?? this.time,
    );
  }

  @override
  String toString() =>
      'Message(message: $message, username: $username, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.message == message &&
        other.username == username &&
        other.time == time;
  }

  @override
  int get hashCode => message.hashCode ^ username.hashCode ^ time.hashCode;
}
