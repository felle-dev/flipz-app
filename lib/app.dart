import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random/screen.dart';
import 'package:dynamic_color/dynamic_color.dart';

class RandomApp extends StatelessWidget {
  const RandomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'Random',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'Outfit',
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: 'NoyhR'),
              displayMedium: TextStyle(fontFamily: 'NoyhR'),
              displaySmall: TextStyle(fontFamily: 'NoyhR'),
              headlineLarge: TextStyle(fontFamily: 'NoyhR'),
              headlineMedium: TextStyle(fontFamily: 'NoyhR'),
              headlineSmall: TextStyle(fontFamily: 'NoyhR'),
              titleLarge: TextStyle(fontFamily: 'NoyhR'),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: lightColorScheme.surface,
              foregroundColor: lightColorScheme.onSurface,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 0,
              color: lightColorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            fontFamily: 'Outfit',
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontFamily: 'NoyhR'),
              displayMedium: TextStyle(fontFamily: 'NoyhR'),
              displaySmall: TextStyle(fontFamily: 'NoyhR'),
              headlineLarge: TextStyle(fontFamily: 'NoyhR'),
              headlineMedium: TextStyle(fontFamily: 'NoyhR'),
              headlineSmall: TextStyle(fontFamily: 'NoyhR'),
              titleLarge: TextStyle(fontFamily: 'NoyhR'),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: darkColorScheme.surface,
              foregroundColor: darkColorScheme.onSurface,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 0,
              color: darkColorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
