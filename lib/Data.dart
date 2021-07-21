class DataModel {
  String? date;
  String? label;
  int? nbVisits;
  int? nbHits;
  int? sumTimeSpent;
  int? nbHitsWithTimeGeneration;
  String? minTimeGeneration;
  String? maxTimeGeneration;
  int? sumBandwidth;
  int? nbHitsWithBandwidth;
  int? minBandwidth;
  int? maxBandwidth;
  int? sumDailyNbUniqVisitors;
  int? entryNbVisits;
  int? entryNbActions;
  int? entrySumVisitLength;
  int? entryBounceCount;
  int? exitNbVisits;
  int? sumDailyEntryNbUniqVisitors;
  int? sumDailyExitNbUniqVisitors;
  int? avgBandwidth;
  int? avgTimeOnPage;
  String? bounceRate;
  String? exitRate;
  double? avgTimeGeneration;

  DataModel(
      {required this.date,
        required this.label,
        required this.nbVisits,
        required this.nbHits,
        required this.sumTimeSpent,
        required this.nbHitsWithTimeGeneration,
        required this.minTimeGeneration,
        required this.maxTimeGeneration,
        required this.sumBandwidth,
        required this.nbHitsWithBandwidth,
        required this.minBandwidth,
        required this.maxBandwidth,
        required this.sumDailyNbUniqVisitors,
        required this.entryNbVisits,
        required this.entryNbActions,
        required this.entrySumVisitLength,
        required this.entryBounceCount,
        required this.exitNbVisits,
        required this.sumDailyEntryNbUniqVisitors,
        required this.sumDailyExitNbUniqVisitors,
        required this.avgBandwidth,
        required this.avgTimeOnPage,
        required this.bounceRate,
        required this.exitRate,
        required this.avgTimeGeneration});

  DataModel.fromJson(Map<String, dynamic> json, String? dateKey) {
    date = dateKey;
    label = json['label'];
    nbVisits = json['nb_visits'];
    nbHits = json['nb_hits'];
    sumTimeSpent = json['sum_time_spent'];
    nbHitsWithTimeGeneration = json['nb_hits_with_time_generation'];
    minTimeGeneration = json['min_time_generation'];
    maxTimeGeneration = json['max_time_generation'];
    sumBandwidth = json['sum_bandwidth'];
    nbHitsWithBandwidth = json['nb_hits_with_bandwidth'];
    minBandwidth = json['min_bandwidth'];
    maxBandwidth = json['max_bandwidth'];
    sumDailyNbUniqVisitors = json['sum_daily_nb_uniq_visitors'];
    entryNbVisits = json['entry_nb_visits'];
    entryNbActions = json['entry_nb_actions'];
    entrySumVisitLength = json['entry_sum_visit_length'];
    entryBounceCount = json['entry_bounce_count'];
    exitNbVisits = json['exit_nb_visits'];
    sumDailyEntryNbUniqVisitors = json['sum_daily_entry_nb_uniq_visitors'];
    sumDailyExitNbUniqVisitors = json['sum_daily_exit_nb_uniq_visitors'];
    avgBandwidth = json['avg_bandwidth'];
    avgTimeOnPage = json['avg_time_on_page'];
    bounceRate = json['bounce_rate'];
    exitRate = json['exit_rate'];
    avgTimeGeneration = json['avg_time_generation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['label'] = this.label;
    data['nb_visits'] = this.nbVisits;
    data['nb_hits'] = this.nbHits;
    data['sum_time_spent'] = this.sumTimeSpent;
    data['nb_hits_with_time_generation'] = this.nbHitsWithTimeGeneration;
    data['min_time_generation'] = this.minTimeGeneration;
    data['max_time_generation'] = this.maxTimeGeneration;
    data['sum_bandwidth'] = this.sumBandwidth;
    data['nb_hits_with_bandwidth'] = this.nbHitsWithBandwidth;
    data['min_bandwidth'] = this.minBandwidth;
    data['max_bandwidth'] = this.maxBandwidth;
    data['sum_daily_nb_uniq_visitors'] = this.sumDailyNbUniqVisitors;
    data['entry_nb_visits'] = this.entryNbVisits;
    data['entry_nb_actions'] = this.entryNbActions;
    data['entry_sum_visit_length'] = this.entrySumVisitLength;
    data['entry_bounce_count'] = this.entryBounceCount;
    data['exit_nb_visits'] = this.exitNbVisits;
    data['sum_daily_entry_nb_uniq_visitors'] = this.sumDailyEntryNbUniqVisitors;
    data['sum_daily_exit_nb_uniq_visitors'] = this.sumDailyExitNbUniqVisitors;
    data['avg_bandwidth'] = this.avgBandwidth;
    data['avg_time_on_page'] = this.avgTimeOnPage;
    data['bounce_rate'] = this.bounceRate;
    data['exit_rate'] = this.exitRate;
    data['avg_time_generation'] = this.avgTimeGeneration;
    return data;
  }
}
