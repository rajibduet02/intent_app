import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/custom_tab_navigation.dart';
import 'package:intent_app/core/widgets/custom_bottom_nav.dart';
import 'package:intent_app/presentation/discover/widgets/discover_scaffold.dart';
import 'package:intent_app/presentation/propose_date/widgets/propose_date_header.dart';
import 'package:intent_app/presentation/propose_date/widgets/propose_date_sections.dart';

class ProposeDateScreen extends StatefulWidget {
  const ProposeDateScreen({super.key});

  @override
  State<ProposeDateScreen> createState() => _ProposeDateScreenState();
}

class _ProposeDateScreenState extends State<ProposeDateScreen> {
  ProposeDateMode _mode = ProposeDateMode.inPerson;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _placeFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();
  int _messageLength = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() => _messageLength = _messageController.text.length);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _placeController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    _placeFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.intentForest,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.intentText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      _selectedDate = picked;
      _dateController.text = _formatDate(picked);
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 18, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.intentForest,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.intentText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      _selectedTime = picked;
      _timeController.text = _formatTime(picked);
    });
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$month/$day/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _onBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.discover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DiscoverScaffold(
      bottomNavigationBar: DiscoverBottomNav(
        selectedTab: CustomBottomNavTab.dates,
        onTabSelected: (tab) => navigateCustomBottomNavTab(context, tab),
        messagesBadgeCount: 5,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProposeDateHeader(onBack: _onBack),
            const SizedBox(height: 12),
            const ProposeDateIntroText(),
            const SizedBox(height: 18),
            const ProposeDateMatchSummary(),
            const SizedBox(height: 20),
            ProposeDateDetailsCard(
              mode: _mode,
              onModeChanged: (mode) => setState(() => _mode = mode),
              messageController: _messageController,
              placeController: _placeController,
              dateController: _dateController,
              timeController: _timeController,
              dateFocusNode: _dateFocusNode,
              timeFocusNode: _timeFocusNode,
              placeFocusNode: _placeFocusNode,
              messageFocusNode: _messageFocusNode,
              messageLength: _messageLength,
              onDateTap: _pickDate,
              onTimeTap: _pickTime,
            ),
            const SizedBox(height: 18),
            const ProposeDateSuggestedIdeas(),
            const SizedBox(height: 14),
            const ProposeDateSafetyCard(),
            const SizedBox(height: 12),
            const ProposeDateInfoNote(),
            const SizedBox(height: 18),
            ProposeDateSendButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
