class NotificationSetting {
  const NotificationSetting({
    required this.enabled,
    required this.id,
    required this.type,
  });

  final bool enabled;
  final String id;
  final String type;

  factory NotificationSetting.fromJson(Map<String, dynamic> json) {
    return NotificationSetting(
      enabled: (json['enabled'] as bool?) ?? false,
      id: (json['id'] as String?) ?? '',
      type: (json['type'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'id': id,
        'type': type,
      };
}

class Owner {
  const Owner({
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.notificationSettings,
  });

  final String displayName;
  final String firstName;
  final String lastName;
  final String id;
  final List<NotificationSetting> notificationSettings;

  factory Owner.fromJson(Map<String, dynamic> json) {
    final List<dynamic> noti = (json['notificationSettings'] as List<dynamic>?) ?? const [];
    return Owner(
      displayName: (json['displayName'] as String?) ?? '',
      firstName: (json['firstName'] as String?) ?? '',
      lastName: (json['lastName'] as String?) ?? '',
      id: (json['id'] as String?) ?? '',
      notificationSettings:
          noti.map((e) => NotificationSetting.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'firstName': firstName,
        'lastName': lastName,
        'id': id,
        'notificationSettings': notificationSettings.map((e) => e.toJson()).toList(),
      };
}


