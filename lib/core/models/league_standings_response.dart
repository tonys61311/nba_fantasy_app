import 'owner_model.dart';

class LeagueStandingsResponse {
  const LeagueStandingsResponse({
    required this.status,
    required this.seasonId,
    required this.standings,
  });

  final String status;
  final int seasonId;
  final List<TeamStanding> standings;

  factory LeagueStandingsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> raw = (json['standings'] as List<dynamic>?) ?? const [];
    return LeagueStandingsResponse(
      status: (json['status'] as String?) ?? (json['message'] as String?) ?? '',
      seasonId: (json['seasonId'] as num?)?.toInt() ?? (json['season_id'] as num?)?.toInt() ?? 0,
      standings: raw.map((e) => TeamStanding.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'seasonId': seasonId,
        'standings': standings.map((e) => e.toJson()).toList(),
      };
}

class TeamStanding {
  const TeamStanding({
    required this.teamId,
    required this.teamAbbrev,
    required this.teamName,
    required this.divisionId,
    required this.divisionName,
    required this.finalStanding,
    required this.standing,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.points,
    required this.pointsFor,
    required this.pointsAgainst,
    required this.logoUrl,
    required this.logoBase64,
    required this.pointsByStat,
    required this.owners,
  });

  final String teamId;
  final String teamAbbrev;
  final String teamName;
  final String divisionId;
  final String divisionName;
  final int finalStanding;
  final int standing;
  final int wins;
  final int losses;
  final int ties;
  final double points;
  final double pointsFor;
  final double pointsAgainst;
  final String logoUrl;
  final String logoBase64;
  final Map<String, int> pointsByStat;
  final List<Owner> owners;

  factory TeamStanding.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> pbs =
        (json['pointsByStat'] as Map<String, dynamic>?) ?? (json['points_by_stat'] as Map<String, dynamic>?) ?? const {};
    final List<dynamic> rawOwners = (json['owners'] as List<dynamic>?) ?? const [];
    return TeamStanding(
      teamId: (json['teamId'] as String?) ?? (json['team_id']?.toString() ?? ''),
      teamAbbrev: (json['teamAbbrev'] as String?) ?? (json['team_abbrev'] as String?) ?? '',
      teamName: (json['teamName'] as String?) ?? (json['team_name'] as String?) ?? '',
      divisionId: (json['divisionId'] as String?) ?? (json['division_id']?.toString() ?? ''),
      divisionName: (json['divisionName'] as String?) ?? (json['division_name'] as String?) ?? '',
      finalStanding: (json['finalStanding'] as num?)?.toInt() ?? (json['final_standing'] as num?)?.toInt() ?? 0,
      standing: (json['standing'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      ties: (json['ties'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toDouble() ?? 0,
      pointsFor: (json['pointsFor'] as num?)?.toDouble() ?? (json['points_for'] as num?)?.toDouble() ?? 0,
      pointsAgainst: (json['pointsAgainst'] as num?)?.toDouble() ?? (json['points_against'] as num?)?.toDouble() ?? 0,
      logoUrl: (json['logoUrl'] as String?) ?? (json['logo_url'] as String?) ?? '',
      logoBase64: (json['logoBase64'] as String?) ?? (json['logo_base64'] as String?) ?? '',
      pointsByStat: pbs.map((key, value) => MapEntry(key, (value as num).toInt())),
      owners: rawOwners.map((e) => Owner.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'teamId': teamId,
        'teamAbbrev': teamAbbrev,
        'teamName': teamName,
        'divisionId': divisionId,
        'divisionName': divisionName,
        'finalStanding': finalStanding,
        'standing': standing,
        'wins': wins,
        'losses': losses,
        'ties': ties,
        'points': points,
        'pointsFor': pointsFor,
        'pointsAgainst': pointsAgainst,
        'logoUrl': logoUrl,
      'logoBase64': logoBase64,
        'pointsByStat': pointsByStat,
        'owners': owners.map((e) => e.toJson()).toList(),
      };
}


