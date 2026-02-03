class CollectionDay {
  const CollectionDay({required this.date, required this.entries});

  final DateTime date;
  final List<CollectionEntry> entries;

  double get totalKg =>
      entries.fold(0, (double sum, CollectionEntry e) => sum + e.collectedKg);
}

class CollectionEntry {
  const CollectionEntry({
    required this.driverName,
    required this.collectedFrom,
    required this.timestamp,
    required this.collectedKg,
    required this.signBytes,
  });

  final String driverName;
  final DateTime timestamp;
  final double collectedKg;
  final String collectedFrom;
  final String signBytes;
}
