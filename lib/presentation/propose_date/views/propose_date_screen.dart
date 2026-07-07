import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intent_app/app/routes/app_routes.dart';
import 'package:intent_app/app/theme/theme.dart';
import 'package:intent_app/core/utils/chat_navigation.dart';
import 'package:intent_app/presentation/auth/widgets/shared/fixed_background_auth_scaffold.dart';
import 'package:intent_app/presentation/chat/providers/date_proposal_provider.dart';
import 'package:intent_app/presentation/propose_date/widgets/propose_date_header.dart';
import 'package:intent_app/presentation/propose_date/widgets/propose_date_sections.dart';

class ProposeDateScreen extends ConsumerStatefulWidget {
  const ProposeDateScreen({super.key});

  @override
  ConsumerState<ProposeDateScreen> createState() => _ProposeDateScreenState();
}

class _ProposeDateScreenState extends ConsumerState<ProposeDateScreen> {
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
  String? _selectedDateIdea;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() => _messageLength = _messageController.text.length);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_prefilled) {
      _prefillFromExistingProposal();
      _prefilled = true;
    }
  }

  void _prefillFromExistingProposal() {
    final proposal = ref.read(dateProposalProvider).proposal;
    if (proposal == null) {
      return;
    }
    setState(() {
      _selectedDateIdea = proposal.dateIdea;
      _placeController.text = proposal.place ?? '';
      _dateController.text = proposal.date ?? '';
      _timeController.text = proposal.time ?? '';
      _messageController.text = proposal.message ?? '';
      _messageLength = _messageController.text.length;
      _mode = proposal.modeLabel == 'Virtual'
          ? ProposeDateMode.virtual
          : ProposeDateMode.inPerson;
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
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final weekday = weekdays[date.weekday - 1];
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$weekday, $month/$day/${date.year}';
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
    }
  }

  void _sendProposal() {
    final existing = ref.read(dateProposalProvider).proposal;
    final isCounter = existing != null && !existing.isSentByMe;

    ref.read(dateProposalProvider.notifier).sendProposal(
          dateIdea: _selectedDateIdea,
          place: _placeController.text.trim().isEmpty
              ? null
              : _placeController.text.trim(),
          date: _dateController.text.trim().isEmpty
              ? null
              : _dateController.text.trim(),
          time: _timeController.text.trim().isEmpty
              ? null
              : _timeController.text.trim(),
          message: _messageController.text.trim().isEmpty
              ? null
              : _messageController.text.trim(),
          modeLabel: _mode == ProposeDateMode.virtual ? 'Virtual' : 'In person',
          isCounterProposal: isCounter,
        );

    popToChat(context);
  }

  @override
  Widget build(BuildContext context) {
    return FixedBackgroundAuthScaffold(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
            ProposeDateSuggestedIdeas(
              selectedLabel: _selectedDateIdea,
              onSelected: (label) => setState(() => _selectedDateIdea = label),
            ),
            const SizedBox(height: 14),
            ProposeDateSafetyCard(
              onTap: () => context.push(AppRoutes.safetyCenter),
            ),
            const SizedBox(height: 12),
            const ProposeDateInfoNote(),
            const SizedBox(height: 18),
            ProposeDateSendButton(onPressed: _sendProposal),
          ],
        ),
      ),
    );
  }
}
