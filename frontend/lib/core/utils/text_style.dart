import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';

extension ThemeTextStyles on BuildContext {
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;

  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;
}
extension TextStyleExtension on TextStyle {
  // 🔤 Font Sizes: 8 to 22
  TextStyle get s8 => copyWith(fontSize: 8.0);
  TextStyle get s9 => copyWith(fontSize: 9.0);
  TextStyle get s10 => copyWith(fontSize: 10.0);
  TextStyle get s11 => copyWith(fontSize: 11.0);
  TextStyle get s12 => copyWith(fontSize: 12.0);
  TextStyle get s13 => copyWith(fontSize: 13.0);
  TextStyle get s14 => copyWith(fontSize: 14.0);
  TextStyle get s15 => copyWith(fontSize: 15.0);
  TextStyle get s16 => copyWith(fontSize: 16.0);
  TextStyle get s17 => copyWith(fontSize: 17.0);
  TextStyle get s18 => copyWith(fontSize: 18.0);
  TextStyle get s19 => copyWith(fontSize: 19.0);
  TextStyle get s20 => copyWith(fontSize: 20.0);
  TextStyle get s21 => copyWith(fontSize: 21.0);
  TextStyle get s22 => copyWith(fontSize: 22.0);

  // 💬 FontWeight shortcuts
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);

  // 🎨 Common Color Styles
  TextStyle get black => copyWith(color: Colors.black);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get red => copyWith(color: Colors.red);
  TextStyle get green => copyWith(color: Colors.green);
  TextStyle get blue => copyWith(color: Colors.blue);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle get indigo => copyWith(color: Colors.indigo);
  TextStyle get amber => copyWith(color: Colors.amber);
  TextStyle get teal => copyWith(color: Colors.teal);
  TextStyle get primary => copyWith(color: AppColors.primary); // You can change this to Theme.of(context).primaryColor

  // 📝 Text Decoration
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get noDecoration => copyWith(decoration: TextDecoration.none);

  // 🧩 FontStyle
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get normalStyle => copyWith(fontStyle: FontStyle.normal);

  // 📏 Letter Spacing
  TextStyle letterSpacing(double spacing) => copyWith(letterSpacing: spacing);

  // 📐 Word Spacing
  TextStyle wordSpacing(double spacing) => copyWith(wordSpacing: spacing);

  // ⬆️ Line Height / Height
  TextStyle height(double value) => copyWith(height: value);

  // 🟨 Background Color
  TextStyle backgroundColor(Color color) => copyWith(backgroundColor: color);
}