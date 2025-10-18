class PlayerRanking {
  final String id;
  final String name;
  final String team;
  final String position;
  final String avatarUrl;
  final String avatarBase64;
  final double fantasyPoints;
  final int rank;

  const PlayerRanking({
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.avatarUrl,
    required this.avatarBase64,
    required this.fantasyPoints,
    required this.rank,
  });

  PlayerRanking copyWith({
    String? id,
    String? name,
    String? team,
    String? position,
    String? avatarUrl,
    String? avatarBase64,
    double? fantasyPoints,
    int? rank,
  }) {
    return PlayerRanking(
      id: id ?? this.id,
      name: name ?? this.name,
      team: team ?? this.team,
      position: position ?? this.position,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarBase64: avatarBase64 ?? this.avatarBase64,
      fantasyPoints: fantasyPoints ?? this.fantasyPoints,
      rank: rank ?? this.rank,
    );
  }
}


