import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/telegram_monet_constants.dart';
import '../../controllers/telegram_monet_controller.dart';
import '../../widgets/theme_card_widget.dart';
import '../../widgets/settings_card_widget.dart';

class TelegramMonetPage extends StatefulWidget {
  const TelegramMonetPage({super.key});

  @override
  State<TelegramMonetPage> createState() => _TelegramMonetPageState();
}

class _TelegramMonetPageState extends State<TelegramMonetPage> {
  late TelegramMonetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TelegramMonetController();
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleShareTheme(bool isTelegram, bool isLight) async {
    final result = await _controller.shareTheme(
      isTelegram: isTelegram,
      isLight: isLight,
      context: context,
    );

    if (!result.success && mounted && result.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppStrings.tgMonetError}${result.error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.tgMonetTitle)),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return ListView(
            padding: const EdgeInsets.all(TelegramMonetConstants.paddingMedium),
            children: [
              // Light Theme Card
              ThemeCardWidget(
                title: AppStrings.tgMonetLightTheme,
                description: AppStrings.tgMonetLightDescription,
                icon: Icons.light_mode,
                onTelegramClick: () => _handleShareTheme(true, true),
                onTelegramXClick: () => _handleShareTheme(false, true),
                isLoading: _controller.isLoading,
                telegramLabel: AppStrings.tgMonetTelegram,
                telegramXLabel: AppStrings.tgMonetTelegramX,
              ),
              const SizedBox(height: TelegramMonetConstants.paddingMedium),

              // Dark Theme Card
              ThemeCardWidget(
                title: AppStrings.tgMonetDarkTheme,
                description: AppStrings.tgMonetDarkDescription,
                icon: Icons.dark_mode,
                onTelegramClick: () => _handleShareTheme(true, false),
                onTelegramXClick: () => _handleShareTheme(false, false),
                isLoading: _controller.isLoading,
                telegramLabel: AppStrings.tgMonetTelegram,
                telegramXLabel: AppStrings.tgMonetTelegramX,
              ),
              const SizedBox(height: TelegramMonetConstants.paddingMedium),

              // Settings Card
              SettingsCardWidget(
                title: AppStrings.tgMonetSettings,
                settings: [
                  SettingItem(
                    text: AppStrings.tgMonetAmoledMode,
                    value: _controller.isAmoled,
                    onChanged: _controller.setAmoled,
                  ),
                  SettingItem(
                    text: AppStrings.tgMonetEnableGradient,
                    value: _controller.isGradient,
                    onChanged: _controller.setGradient,
                  ),
                  SettingItem(
                    text: AppStrings.tgMonetEnableGradientAvatars,
                    value: _controller.isAvatarGradient,
                    onChanged: _controller.setAvatarGradient,
                  ),
                  SettingItem(
                    text: AppStrings.tgMonetEnableMonetNicknames,
                    value: _controller.isNicknameColorful,
                    onChanged: _controller.setNicknameColorful,
                  ),
                  SettingItem(
                    text: AppStrings.tgMonetUseAltOutgoingStyle,
                    value: _controller.isAlterOutColor,
                    onChanged: _controller.setAlterOutColor,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
