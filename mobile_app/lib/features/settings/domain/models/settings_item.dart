import 'dart:ui';

class SettingsItem {
  final String title;
  final String? subtitle;
  final String? value;
  final bool isToggle;
  final bool toggleValue;
  final VoidCallback? onTap;
  final Function(bool)? onToggle;

  SettingsItem({
    required this.title,
    this.subtitle,
    this.value,
    this.isToggle = false,
    this.toggleValue = false,
    this.onTap,
    this.onToggle,
  });
}

// 設定セクション
class SettingsSection {
  final String? title;
  final List<SettingsItem> items;

  SettingsSection({
    this.title,
    required this.items,
  });
}
