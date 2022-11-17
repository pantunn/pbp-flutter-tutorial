var listBudget = <Budget>[];

class Budget {
  late String title;
  late int nominal;
  late String type;
  late DateTime date;

  Budget ({
    required this.title,
    required this.nominal,
    required this.type,
    required this.date,
  });

}