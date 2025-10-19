class PlayerRanking {
  final String id;
  final String teamName;
  final String teamAbbrev;
  final String position;
  final String avatarUrl;
  final String avatarBase64;
  final double fantasyPoints;
  final int rank;
  final String firstName;
  final String lastName;

  const PlayerRanking({
    required this.id,
    required this.teamName,
    required this.teamAbbrev,
    required this.position,
    required this.avatarUrl,
    required this.avatarBase64,
    required this.fantasyPoints,
    required this.rank,
    required this.firstName,
    required this.lastName,
  });

  PlayerRanking copyWith({
    String? id,
    String? teamName,
    String? teamAbbrev,
    String? position,
    String? avatarUrl,
    String? avatarBase64,
    double? fantasyPoints,
    int? rank,
    String? firstName,
    String? lastName,
  }) {
    return PlayerRanking(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      teamAbbrev: teamAbbrev ?? this.teamAbbrev,
      position: position ?? this.position,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarBase64: avatarBase64 ?? this.avatarBase64,
      fantasyPoints: fantasyPoints ?? this.fantasyPoints,
      rank: rank ?? this.rank,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}


