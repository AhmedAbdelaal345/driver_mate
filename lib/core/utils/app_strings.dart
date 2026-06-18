import 'package:flutter/material.dart';
import 'package:driver_mate/l10n/app_localizations.dart';

class AppStrings {
  AppStrings._();

  static AppLocalizations of(BuildContext context) {
    // Do NOT call AppLocalizations.of(context) — it has a hard ! that throws.
    // Call Localizations.of directly so the ?? fallback actually works.
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        lookupAppLocalizations(const Locale('en'));
  }
}
