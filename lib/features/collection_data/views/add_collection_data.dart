import "dart:convert";
import "dart:typed_data";

import "package:collect/core/models/task_card_model.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/custom_app_bar.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:signature/signature.dart";

class AddCollectionData extends StatefulWidget {
  const AddCollectionData({super.key, required this.data});

  final TransferCardData data;

  @override
  State<AddCollectionData> createState() => _AddCollectionDataState();
}

class _AddCollectionDataState extends State<AddCollectionData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _collectorController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  late DateTime _collectionDate;
  late final SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _collectionDate = DateTime.now();
    _signatureController = SignatureController(
      penStrokeWidth: 4,
      penColor: ThemeColors.themeColor,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _collectorController.dispose();
    _kgController.dispose();
    _notesController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ThemeColors.bgColor,
    body: Column(
      children: <Widget>[
        CustomAppBar(
          title: 'Collection Data',
          onBackPressed: () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: <Widget>[
                _buildSummaryCard(),
                const SizedBox(height: 20),
                _buildDateField(),
                const SizedBox(height: 16),
                _buildCollectorField(),
                const SizedBox(height: 16),
                _buildKgField(),
                const SizedBox(height: 16),
                _buildNotesField(),
                const SizedBox(height: 20),
                _buildSignaturePad(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildSummaryCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: ThemeColors.whiteColor,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color.fromRGBO(15, 23, 42, 0.08),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.data.restaurantName,
          style: StyleUtils.kTextStyleSize20Weight600(
            color: ThemeColors.themeColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.data.restaurantAddress,
          style: StyleUtils.kTextStyleSize14Weight400(
            color: ThemeColors.greyTextColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            _buildChip(CupertinoIcons.location_solid, widget.data.emirate),
          ],
        ),
      ],
    ),
  );

  Widget _buildChip(IconData icon, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ThemeColors.bgColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: ThemeColors.themeColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: StyleUtils.kTextStyleSize14Weight600(
                color: ThemeColors.themeTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildDateField() {
    final DateFormat formatter = DateFormat('EEE, MMM d • hh:mm a');
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ThemeColors.whiteColor,
          border: Border.all(color: ThemeColors.borderColor),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.bgColor,
              ),
              child: const Icon(
                CupertinoIcons.calendar,
                color: ThemeColors.themeColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Collection date",
                    style: StyleUtils.kTextStyleSize12Weight500(
                      color: ThemeColors.greyTextColor,
                    ),
                  ),
                  Text(
                    formatter.format(_collectionDate),
                    style: StyleUtils.kTextStyleSize16Weight600(
                      color: ThemeColors.themeTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              color: ThemeColors.greyTextColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectorField() => TextFormField(
    controller: _collectorController,
    decoration: StyleUtils.inputDecoration(
      hintText: "Collected From (Name)",
      prefixIcon: CupertinoIcons.person_alt,
    ),
    validator: (String? value) => (value == null || value.trim().isEmpty)
        ? "Collector name required"
        : null,
  );

  Widget _buildKgField() => TextFormField(
    controller: _kgController,
    keyboardType: TextInputType.number,
    decoration: StyleUtils.inputDecoration(
      hintText: "Collected weight (KG)",
      prefixIcon: CupertinoIcons.cube_box,
    ),
    validator: (String? value) {
      final double? parsed = double.tryParse(value ?? "");
      if (parsed == null || parsed <= 0) {
        return "Enter valid weight";
      }
      return null;
    },
  );

  Widget _buildNotesField() => TextFormField(
    controller: _notesController,
    minLines: 3,
    maxLines: 4,
    decoration: StyleUtils.inputDecoration(
      hintText: "Notes (optional)",
      prefixIcon: CupertinoIcons.text_alignleft,
    ),
  );

  Widget _buildSignaturePad() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Collector signature",
        style: StyleUtils.kTextStyleSize16Weight600(
          color: ThemeColors.themeTextColor,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ThemeColors.whiteColor,
          border: Border.all(color: ThemeColors.borderColor),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(15, 23, 42, 0.05),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: <Widget>[
          TextButton.icon(
            onPressed: _signatureController.clear,
            icon: const Icon(CupertinoIcons.refresh, size: 18),
            label: Text("Reset", style: StyleUtils.kTextStyleSize14Weight600()),
          ),
          const Spacer(),
          Text(
            _signatureController.isNotEmpty
                ? "Signature captured"
                : "Awaiting signature",
            style: StyleUtils.kTextStyleSize12Weight500(
              color: _signatureController.isNotEmpty
                  ? ThemeColors.completedColor
                  : ThemeColors.greyTextColor,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildActionButtons() => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColors.themeColor,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    onPressed: _handleSubmit,
    child: Text(
      "Save collection",
      style: StyleUtils.kTextStyleSize16Weight600(color: Colors.white),
    ),
  );

  Future<void> _pickDate() async {
    final DateTime initialDate = _collectionDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate == null) return;
    // Keep the same time component.
    setState(
      () => _collectionDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        initialDate.hour,
        initialDate.minute,
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_signatureController.isEmpty) {
      _showSnack("Signature required");
      return;
    }

    final Uint8List? signatureData = await _signatureController.toPngBytes();
    final String payload = jsonEncode(<String, dynamic>{
      "booking_id": widget.data.bookingId,
      "collector_name": _collectorController.text.trim(),
      "collected_kg": double.tryParse(_kgController.text.trim()) ?? 0,
      "collection_date": _collectionDate.toIso8601String(),
      "notes": _notesController.text.trim(),
      "signature": signatureData != null ? base64Encode(signatureData) : null,
    });

    _showSnack("Payload ready: $payload");
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: StyleUtils.kTextStyleSize14Weight500(color: Colors.white),
        ),
      ),
    );
  }
}
