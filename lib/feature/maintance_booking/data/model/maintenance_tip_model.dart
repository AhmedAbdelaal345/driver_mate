class MaintenanceTipModel {
  final String title;
  final String description;
  final List<String> whyItMatters;
  final List<String> whatYouNeed;
  final List<String> steps;
  final List<String> mistakes;

  MaintenanceTipModel({
    required this.title,
    required this.description,
    required this.whyItMatters,
    required this.whatYouNeed,
    required this.steps,
    required this.mistakes,
  });

  factory MaintenanceTipModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceTipModel(
      title: json['title'],
      description: json['description'],
      whyItMatters: List<String>.from(json['whyItMatters']),
      whatYouNeed: List<String>.from(json['whatYouNeed']),
      steps: List<String>.from(json['steps']),
      mistakes: List<String>.from(json['mistakes']),
    );
  }
}
