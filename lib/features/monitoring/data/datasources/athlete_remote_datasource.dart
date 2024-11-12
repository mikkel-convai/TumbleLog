import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/app_user_model.dart';

abstract class AthleteRemoteDataSource {
  Future<List<AppUserModel>> loadAthletes();
}

class AthleteRemoteDataSourceImpl implements AthleteRemoteDataSource {
  final SupabaseClient supabaseClient;

  AthleteRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<AppUserModel>> loadAthletes() async {
    try {
      final athletesJson =
          await supabaseClient.from('users').select().eq('role', 'athlete');

      final List<AppUserModel> athletes = athletesJson
          .map((athleteJson) => AppUserModel.fromJson(athleteJson))
          .toList();

      return athletes;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
