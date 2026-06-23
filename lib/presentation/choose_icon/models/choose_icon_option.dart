import 'package:flutter/material.dart';

class ChooseIconOption {
  const ChooseIconOption({
    required this.id,
    required this.label,
    required this.icon,
    this.isPremium = false,
    this.isLocked = false,
  });

  final String id;
  final String label;
  final IconData icon;
  final bool isPremium;
  final bool isLocked;

  /// Icons shown when the Premium tab is active (2 rows × 4 columns).
  static const List<ChooseIconOption> premiumTabIcons = [
    ChooseIconOption(
      id: 'mountain',
      label: 'Mountain',
      icon: Icons.terrain_outlined,
    ),
    ChooseIconOption(
      id: 'camera',
      label: 'Camera',
      icon: Icons.photo_camera_outlined,
    ),
    ChooseIconOption(
      id: 'book',
      label: 'Book',
      icon: Icons.menu_book_outlined,
    ),
    ChooseIconOption(
      id: 'coffee',
      label: 'Coffee',
      icon: Icons.coffee_outlined,
    ),
    ChooseIconOption(
      id: 'music',
      label: 'Music',
      icon: Icons.music_note_outlined,
    ),
    ChooseIconOption(
      id: 'plant',
      label: 'Plant',
      icon: Icons.eco_outlined,
      isLocked: true,
    ),
    ChooseIconOption(
      id: 'dog',
      label: 'Dog',
      icon: Icons.chat_bubble_outline,
      isLocked: true,
    ),
    ChooseIconOption(
      id: 'travel',
      label: 'Travel',
      icon: Icons.public_outlined,
    ),
  ];

  static const List<ChooseIconOption> freeIcons = [
    ChooseIconOption(id: 'mountain', label: 'Mountain', icon: Icons.terrain_outlined),
    ChooseIconOption(id: 'ball', label: 'Ball', icon: Icons.sports_soccer_outlined),
    ChooseIconOption(id: 'music', label: 'Music', icon: Icons.music_note_outlined),
    ChooseIconOption(id: 'gaming', label: 'Gaming', icon: Icons.sports_esports_outlined),
    ChooseIconOption(id: 'book', label: 'Book', icon: Icons.menu_book_outlined),
    ChooseIconOption(id: 'travel', label: 'Travel', icon: Icons.flight_outlined),
    ChooseIconOption(id: 'coffee', label: 'Coffee', icon: Icons.coffee_outlined),
    ChooseIconOption(id: 'nature', label: 'Nature', icon: Icons.park_outlined),
    ChooseIconOption(id: 'family', label: 'Family', icon: Icons.family_restroom_outlined),
    ChooseIconOption(id: 'plus', label: '+', icon: Icons.add),
    ChooseIconOption(id: 'cooking', label: 'Cooking', icon: Icons.restaurant_outlined),
    ChooseIconOption(id: 'sports', label: 'Sports', icon: Icons.fitness_center_outlined),
  ];
}

enum ChooseIconTab {
  free,
  premium,
}
