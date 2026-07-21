enum OnboardingGender { woman, man, nonBinary }

class ProfileBasicsState {
  const ProfileBasicsState({
    required this.isLoading,
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth,
    this.age,
    this.gender,
    this.occupation,
  });

  final bool isLoading;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final int? age;
  final OnboardingGender? gender;
  final String? occupation;

  factory ProfileBasicsState.initial() => const ProfileBasicsState(isLoading: false);

  ProfileBasicsState copyWith({
    bool? isLoading,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    int? age,
    OnboardingGender? gender,
    String? occupation,
    bool clearDateOfBirth = false,
    bool clearOccupation = false,
  }) {
    return ProfileBasicsState(
      isLoading: isLoading ?? this.isLoading,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: clearDateOfBirth ? null : (dateOfBirth ?? this.dateOfBirth),
      age: clearDateOfBirth ? null : (age ?? this.age),
      gender: gender ?? this.gender,
      occupation: clearOccupation ? null : (occupation ?? this.occupation),
    );
  }
}
