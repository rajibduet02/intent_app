import 'package:intent_app/presentation/onboarding/data/love_language_options.dart';

class LoveLanguageState {
  const LoveLanguageState({
    required this.selectedLanguages,
    required this.vibeValues,
    required this.isLoading,
  });

  final List<LoveLanguageType> selectedLanguages;
  final Map<String, double> vibeValues;
  final bool isLoading;

  factory LoveLanguageState.initial() {
    return LoveLanguageState(
      selectedLanguages: const [],
      vibeValues: {
        for (final axis in LoveLanguageOptions.vibeAxes) axis.id: 0.5,
      },
      isLoading: false,
    );
  }

  bool get canContinue => selectedLanguages.length == 2;

  int? rankFor(LoveLanguageType type) {
    final index = selectedLanguages.indexOf(type);
    return index == -1 ? null : index + 1;
  }

  LoveLanguageState copyWith({
    List<LoveLanguageType>? selectedLanguages,
    Map<String, double>? vibeValues,
    bool? isLoading,
  }) {
    return LoveLanguageState(
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      vibeValues: vibeValues ?? this.vibeValues,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
