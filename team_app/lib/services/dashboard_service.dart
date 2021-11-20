import 'dart:convert';

import 'package:http/http.dart';
import 'package:icovid/models/dashboard_model.dart';

class HttpServices {
  Client client = Client();

  Future<List<CovidStat>> getCovidStatistics() async {
    print('in-covid method');
    final response = await client.get(
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var all = AllCovidStat.fromJson(
        json.decode(response.body),
      );
      print(all.stats);
      return all.stats;
    }

    throw Exception('Failed to load covid statistics');
  }
}
