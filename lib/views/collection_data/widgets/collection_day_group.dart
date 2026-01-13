part of 'package:collect/views/collection_data/collection_data.dart';

class _DayGroup extends StatelessWidget {
  const _DayGroup(CollectionDay day) : _day = day;

  final CollectionDay _day;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat(
      'EEEE, MMM d',
      TranslationService.getLocale().toString(),
    );
    final List<Widget> entryWidgets = <Widget>[];
    for (int i = 0; i < _day.entries.length; i++) {
      entryWidgets.add(_CollectionEntryTile(entry: _day.entries[i]));
      if (i < _day.entries.length - 1) {
        entryWidgets.add(const SizedBox(height: 12));
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorUtils.whiteColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Utils.replaceFarsiNumber(dateFormatter.format(_day.date)),
                      style: StyleUtils.kTextStyleSize18Weight600(
                        color: ColorUtils.themeTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Utils.replaceFarsiNumber(
                        "${_day.entries.length} pickups",
                      ),
                      style: StyleUtils.kTextStyleSize14Weight400(
                        color: ColorUtils.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: ColorUtils.themeColor.withValues(alpha: 0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Collected",
                      style: StyleUtils.kTextStyleSize12Weight500(
                        color: ColorUtils.greyTextColor,
                      ),
                    ),
                    Text(
                      Utils.replaceFarsiNumber(
                        "${_day.totalKg.toStringAsFixed(1)} KG",
                      ),
                      style: StyleUtils.kTextStyleSize16Weight600(
                        color: ColorUtils.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...entryWidgets,
        ],
      ),
    );
  }
}

class _CollectionEntryTile extends StatelessWidget {
  const _CollectionEntryTile({required this.entry});

  final CollectionEntry entry;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: ColorUtils.bgColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorUtils.whiteColor,
            ),
            child: const Icon(CupertinoIcons.car, color: ColorUtils.themeColor),
          ),
          10.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        entry.driverName,
                        style: StyleUtils.kTextStyleSize16Weight600(
                          color: ColorUtils.themeTextColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorUtils.whiteColor,
                      ),
                      child: Text(
                        Utils.replaceFarsiNumber(
                          "${entry.collectedKg.toStringAsFixed(1)} KG",
                        ),
                        style: StyleUtils.kTextStyleSize12Weight600(
                          color: ColorUtils.darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  Utils.replaceFarsiNumber(
                    timeFormatter.format(entry.timestamp),
                  ),
                  style: StyleUtils.kTextStyleSize14Weight400(
                    color: ColorUtils.greyTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    _InfoTag(
                      label: "Collected From",
                      value: entry.collectedFrom,
                      icon: CupertinoIcons.person_badge_plus,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _SignaturePreview(bytes: entry.signBytes),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  const _InfoTag({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: ColorUtils.whiteColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 16, color: ColorUtils.themeColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: StyleUtils.kTextStyleSize10Weight500(
                    color: ColorUtils.greyTextColor,
                  ),
                ),
                Text(
                  value,
                  style: StyleUtils.kTextStyleSize12Weight600(
                    color: ColorUtils.themeTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _SignaturePreview extends StatelessWidget {
  const _SignaturePreview({required this.bytes});

  final String bytes;

  @override
  Widget build(BuildContext context) {
    final Uint8List? signatureBytes = _decodeSignature(bytes);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorUtils.borderColor),
        color: ColorUtils.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                CupertinoIcons.pencil,
                color: ColorUtils.themeColor,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                "Signature",
                style: StyleUtils.kTextStyleSize12Weight500(
                  color: ColorUtils.greyTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (signatureBytes != null && signatureBytes.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                signatureBytes,
                height: 68,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 68,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorUtils.bgColor,
              ),
              child: Text(
                "No signature preview available",
                style: StyleUtils.kTextStyleSize12Weight500(
                  color: ColorUtils.greyTextColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Uint8List? _decodeSignature(String source) {
    if (source.trim().isEmpty) return null;
    try {
      final String clean = source.contains(',')
          ? source.split(',').last
          : source;
      return base64Decode(clean);
    } catch (_) {
      return null;
    }
  }
}
