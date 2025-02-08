import 'package:flutter/material.dart';
import '../../domain/models/settings_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _locationEnabled = false;
  String _selectedTheme = 'ライト';
  String _selectedLanguage = '日本語';

  List<SettingsSection> _getSettingsSections() {
    return [
      SettingsSection(
        title: 'アカウント設定',
        items: [
          SettingsItem(
            title: 'プロフィール',
            onTap: () {
              // TODO: プロフィール画面への遷移
            },
          ),
        ],
      ),
      SettingsSection(
        title: '通知設定',
        items: [
          SettingsItem(
            title: '通知設定',
            onTap: () {
              // TODO: 通知設定画面への遷移
            },
          ),
        ],
      ),
      SettingsSection(
        title: 'アプリ設定',
        items: [
          SettingsItem(
            title: 'テーマ',
            value: _selectedTheme,
            onTap: () {
              // TODO: テーマ選択ダイアログの表示
            },
          ),
          SettingsItem(
            title: '言語',
            value: _selectedLanguage,
            onTap: () {
              // TODO: 言語選択ダイアログの表示
            },
          ),
        ],
      ),
      SettingsSection(
        items: [
          SettingsItem(
            title: '位置情報の使用',
            isToggle: true,
            toggleValue: _locationEnabled,
            onToggle: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
          ),
        ],
      ),
      SettingsSection(
        title: 'その他',
        items: [
          SettingsItem(
            title: 'プライバシーポリシー',
            onTap: () {
              // TODO: プライバシーポリシー画面への遷移
            },
          ),
          SettingsItem(
            title: 'アプリについて',
            subtitle: 'v1.0.0',
            onTap: () {
              // TODO: アプリ情報画面への遷移
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sections = _getSettingsSections();

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, sectionIndex) {
          final section = sections[sectionIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (section.title != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    section.title!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              ...section.items.map((item) => _buildSettingsItem(item)),
              if (sectionIndex < sections.length - 1) const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingsItem(SettingsItem item) {
    return ListTile(
      onTap: item.isToggle ? null : item.onTap,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: item.isToggle
          ? Switch(
              value: item.toggleValue,
              onChanged: item.onToggle,
              activeColor: const Color(0xFF008080),
            )
          : item.value != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.value!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ],
                )
              : const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
    );
  }
}
