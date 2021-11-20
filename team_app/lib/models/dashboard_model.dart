class CovidStat {
  final String txn_date;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_death;
  final int total_death;
  final int new_recovered;
  final int total_recovered;
  final String update_date;

  CovidStat(
      this.txn_date,
      this.new_case,
      this.total_case,
      this.new_case_excludeabroad,
      this.total_case_excludeabroad,
      this.new_death,
      this.total_death,
      this.new_recovered,
      this.total_recovered,
      this.update_date);

  factory CovidStat.fromJson(
    Map<String, dynamic> json,
  ) {
    return CovidStat(
      json['txn_date'] as String,
      json['new_case'] as int,
      json['total_case'] as int,
      json['new_case_excludeabroad'] as int,
      json['total_case_excludeabroad'] as int,
      json['new_death'] as int,
      json['total_death'] as int,
      json['new_recovered'] as int,
      json['total_recovered'] as int,
      json['update_date'] as String,
    );
  }
}

class AllCovidStat {
  final List<CovidStat> stats;
  AllCovidStat(this.stats);

  factory AllCovidStat.fromJson(List<dynamic> json) {
    List<CovidStat> stats;

    stats = json.map((index) => CovidStat.fromJson(index)).toList();

    return AllCovidStat(stats);
  }
}
