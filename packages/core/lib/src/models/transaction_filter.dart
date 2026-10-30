enum TransactionType {
  income,
  expense;

  String toJson() => name;

  static TransactionType? fromJson(String? json) {
    if (json == null) return null;
    return TransactionType.values.firstWhere(
      (e) => e.name == json,
      orElse: () => TransactionType.expense,
    );
  }
}

class TransactionFilter {
  final int? month;
  final TransactionType? type;

  const TransactionFilter({
    this.month,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      if (month != null) 'month': month,
      if (type != null) 'type': type?.toJson(),
    };
  }
}