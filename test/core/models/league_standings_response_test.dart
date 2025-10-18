import 'package:flutter_test/flutter_test.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';

void main() {
  group('LeagueStandingsResponse', () {
    test('fromJson/toJson round trip', () {
      final json = {
        'status': 'ok',
        'seasonId': 2025,
        'standings': [
          {
            'teamId': 't1',
            'teamAbbrev': 'ABC',
            'teamName': 'Alpha Team',
            'divisionId': 'd1',
            'divisionName': 'Alpha Div',
            'finalStanding': 1,
            'standing': 1,
            'wins': 10,
            'losses': 2,
            'ties': 0,
            'points': 123.5,
            'pointsFor': 100.2,
            'pointsAgainst': 80.7,
            'logoUrl': 'https://logo',
            'pointsByStat': {
              'PTS': 50,
              'REB': 30,
            },
            'owners': [
              {
                'displayName': 'John D',
                'firstName': 'John',
                'lastName': 'Doe',
                'id': 'o1',
                'notificationSettings': [
                  {
                    'enabled': true,
                    'id': 'n1',
                    'type': 'PUSH',
                  }
                ]
              }
            ]
          }
        ]
      };

      final parsed = LeagueStandingsResponse.fromJson(json);
      expect(parsed.status, 'ok');
      expect(parsed.seasonId, 2025);
      expect(parsed.standings.length, 1);
      final team = parsed.standings.first;
      expect(team.teamId, 't1');
      expect(team.pointsByStat['PTS'], 50);
      expect(team.owners.first.displayName, 'John D');

      final back = parsed.toJson();
      expect(back['status'], 'ok');
      expect(back['standings'], isA<List<dynamic>>());
    });
  });
}


