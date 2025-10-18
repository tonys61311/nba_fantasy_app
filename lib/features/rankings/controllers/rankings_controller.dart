import 'package:get/get.dart';
import 'package:nba_fantasy_app/core/api/app_api.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';

class RankingsController extends GetxController {
  final IAppApi _api = AppApi();

  final RxList<TeamStanding> standings = RxList<TeamStanding>([]);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStandings();
  }

  Future<void> fetchStandings() async {
    try {
      isLoading.value = true;
      error.value = '';
      final response = await _api.fetchLeagueStandings();
      standings.value = response.standings;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}


