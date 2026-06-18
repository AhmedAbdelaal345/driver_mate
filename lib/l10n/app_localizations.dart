import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// App name
  ///
  /// In en, this message translates to:
  /// **'Drive Mate'**
  String get driverMate;

  /// No description provided for @loginText.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginText;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @problems.
  ///
  /// In en, this message translates to:
  /// **'Problems'**
  String get problems;

  /// No description provided for @verifyOTP.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOTP;

  /// No description provided for @problem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get problem;

  /// No description provided for @enterBrandCar.
  ///
  /// In en, this message translates to:
  /// **'Enter a Brand Car'**
  String get enterBrandCar;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @selectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle'**
  String get selectVehicle;

  /// No description provided for @carDetails.
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get carDetails;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @postdetails.
  ///
  /// In en, this message translates to:
  /// **'Post Details'**
  String get postdetails;

  /// No description provided for @removeVehicle.
  ///
  /// In en, this message translates to:
  /// **'Remove Vehicle'**
  String get removeVehicle;

  /// No description provided for @batteryHealth.
  ///
  /// In en, this message translates to:
  /// **'Battery Health'**
  String get batteryHealth;

  /// No description provided for @myDailyDriver.
  ///
  /// In en, this message translates to:
  /// **'My Daily Driver'**
  String get myDailyDriver;

  /// No description provided for @lastService.
  ///
  /// In en, this message translates to:
  /// **'LAST SERVICE'**
  String get lastService;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// No description provided for @confirmNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password is required'**
  String get confirmNewPasswordRequired;

  /// No description provided for @editVehicle.
  ///
  /// In en, this message translates to:
  /// **'EDIT VEHICLE'**
  String get editVehicle;

  /// No description provided for @nextService.
  ///
  /// In en, this message translates to:
  /// **'NEXT SERVICE'**
  String get nextService;

  /// No description provided for @updateVehicle.
  ///
  /// In en, this message translates to:
  /// **'UPDATE VEHICLE'**
  String get updateVehicle;

  /// No description provided for @mileage.
  ///
  /// In en, this message translates to:
  /// **'MILEAGE'**
  String get mileage;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get inactive;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @runAIScan.
  ///
  /// In en, this message translates to:
  /// **'Run AI Scan'**
  String get runAIScan;

  /// No description provided for @runAIScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Diagnose issues with AI technology'**
  String get runAIScanDescription;

  /// No description provided for @bookMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Book Maintenance'**
  String get bookMaintenance;

  /// No description provided for @bookMaintenanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedule service appointment'**
  String get bookMaintenanceDescription;

  /// No description provided for @emergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get emergencyHelp;

  /// No description provided for @locationError.
  ///
  /// In en, this message translates to:
  /// **'Location Error'**
  String get locationError;

  /// No description provided for @viewMaintenanceHistory.
  ///
  /// In en, this message translates to:
  /// **'View Maintenance History'**
  String get viewMaintenanceHistory;

  /// No description provided for @viewMaintenanceHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'See all past services and repairs'**
  String get viewMaintenanceHistoryDescription;

  /// No description provided for @emergencyHelpDescription.
  ///
  /// In en, this message translates to:
  /// **'Get immediate roadside assistance'**
  String get emergencyHelpDescription;

  /// No description provided for @removeVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Vehicle'**
  String get removeVehicleTitle;

  /// No description provided for @removeVehicleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this vehicle from your garage? This action cannot be undone.'**
  String get removeVehicleMessage;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @duplicateCarError.
  ///
  /// In en, this message translates to:
  /// **'A car with the same brand, model, and year already exists.'**
  String get duplicateCarError;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @duplicatePlateError.
  ///
  /// In en, this message translates to:
  /// **'A car with the same plate number already exists.'**
  String get duplicatePlateError;

  /// No description provided for @currentMileage.
  ///
  /// In en, this message translates to:
  /// **'Current Mileage'**
  String get currentMileage;

  /// No description provided for @currentMileageHint.
  ///
  /// In en, this message translates to:
  /// **'Enter current mileage'**
  String get currentMileageHint;

  /// No description provided for @nicknameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., My Camry'**
  String get nicknameHint;

  /// No description provided for @addToMyCars.
  ///
  /// In en, this message translates to:
  /// **'Add to My Cars'**
  String get addToMyCars;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @engine.
  ///
  /// In en, this message translates to:
  /// **'Engine'**
  String get engine;

  /// No description provided for @transmission.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get transmission;

  /// No description provided for @fuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get fuelType;

  /// No description provided for @drivetrain.
  ///
  /// In en, this message translates to:
  /// **'Drivetrain'**
  String get drivetrain;

  /// No description provided for @seating.
  ///
  /// In en, this message translates to:
  /// **'Seating'**
  String get seating;

  /// No description provided for @mpg.
  ///
  /// In en, this message translates to:
  /// **'MPG'**
  String get mpg;

  /// No description provided for @invalidMileage.
  ///
  /// In en, this message translates to:
  /// **'Invalid mileage format'**
  String get invalidMileage;

  /// No description provided for @additionalNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add any special requests or notes about your service...'**
  String get additionalNotesHint;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @viewMoreTips.
  ///
  /// In en, this message translates to:
  /// **'View More Tips'**
  String get viewMoreTips;

  /// No description provided for @additionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additionalNotes;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @selectYourVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select your vehicle'**
  String get selectYourVehicle;

  /// No description provided for @noVehiclesFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicles found'**
  String get noVehiclesFound;

  /// No description provided for @avoidCommonMistakes.
  ///
  /// In en, this message translates to:
  /// **'Avoid Common Mistakes'**
  String get avoidCommonMistakes;

  /// No description provided for @whyItMatters.
  ///
  /// In en, this message translates to:
  /// **'Why It Matters'**
  String get whyItMatters;

  /// No description provided for @howToSteps.
  ///
  /// In en, this message translates to:
  /// **'How To Steps'**
  String get howToSteps;

  /// No description provided for @whatYouNeed.
  ///
  /// In en, this message translates to:
  /// **'What You Need'**
  String get whatYouNeed;

  /// No description provided for @relatedTips.
  ///
  /// In en, this message translates to:
  /// **'Related Tips'**
  String get relatedTips;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @enterYearCar.
  ///
  /// In en, this message translates to:
  /// **'Enter The Year for a Car'**
  String get enterYearCar;

  /// No description provided for @carAddedSuccefully.
  ///
  /// In en, this message translates to:
  /// **'Car Added Successfully'**
  String get carAddedSuccefully;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @selectServiceCenter.
  ///
  /// In en, this message translates to:
  /// **'Select Service Center'**
  String get selectServiceCenter;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @changedSuccefully.
  ///
  /// In en, this message translates to:
  /// **'Your Data Changed Successfully'**
  String get changedSuccefully;

  /// No description provided for @loadedSuccefully.
  ///
  /// In en, this message translates to:
  /// **'Your Data Loaded Successfully'**
  String get loadedSuccefully;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @noRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'No recent searches'**
  String get noRecentSearches;

  /// No description provided for @maxDist.
  ///
  /// In en, this message translates to:
  /// **'Max distance (km)'**
  String get maxDist;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @maintenanceTip.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Tip'**
  String get maintenanceTip;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @nearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get nearest;

  /// No description provided for @highestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get highestRated;

  /// No description provided for @lowestPrice.
  ///
  /// In en, this message translates to:
  /// **'Lowest Price'**
  String get lowestPrice;

  /// No description provided for @highestPrice.
  ///
  /// In en, this message translates to:
  /// **'Highest Price'**
  String get highestPrice;

  /// No description provided for @newPost.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get newPost;

  /// No description provided for @postType.
  ///
  /// In en, this message translates to:
  /// **'Post Type'**
  String get postType;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'What\'\'s your question or topic?'**
  String get titleHint;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add details, context, or what you\'\'ve tried...'**
  String get descriptionHint;

  /// No description provided for @publishPost.
  ///
  /// In en, this message translates to:
  /// **'Publish Post'**
  String get publishPost;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @minRating.
  ///
  /// In en, this message translates to:
  /// **'Min rating'**
  String get minRating;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @restartLanguage.
  ///
  /// In en, this message translates to:
  /// **'App will restart to apply language changes'**
  String get restartLanguage;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @searchHelp.
  ///
  /// In en, this message translates to:
  /// **'Search help...'**
  String get searchHelp;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @cars.
  ///
  /// In en, this message translates to:
  /// **'Cars'**
  String get cars;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FREQUENTLY ASKED QUESTIONS'**
  String get faqTitle;

  /// No description provided for @faqAddVehicle.
  ///
  /// In en, this message translates to:
  /// **'How do I add a new vehicle?'**
  String get faqAddVehicle;

  /// No description provided for @faqAiDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'How does AI diagnostics work?'**
  String get faqAiDiagnosis;

  /// No description provided for @faqBookService.
  ///
  /// In en, this message translates to:
  /// **'How do I book a service?'**
  String get faqBookService;

  /// No description provided for @faqCancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel or reschedule a booking?'**
  String get faqCancelBooking;

  /// No description provided for @faqEmergency.
  ///
  /// In en, this message translates to:
  /// **'What if I have an emergency?'**
  String get faqEmergency;

  /// No description provided for @faqChangePassword.
  ///
  /// In en, this message translates to:
  /// **'How do I change my password?'**
  String get faqChangePassword;

  /// No description provided for @faqVehicleSecure.
  ///
  /// In en, this message translates to:
  /// **'Are my vehicle details secure?'**
  String get faqVehicleSecure;

  /// No description provided for @carDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Vehicle deleted successfully!'**
  String get carDeletedSuccessfully;

  /// No description provided for @faqAiAccuracy.
  ///
  /// In en, this message translates to:
  /// **'How accurate is the AI diagnostic?'**
  String get faqAiAccuracy;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About DriveMate'**
  String get about;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your intelligent car maintenance companion. AI-powered diagnostics and seamless service booking.'**
  String get aboutSubtitle;

  /// No description provided for @versionNumber.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get versionNumber;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @termsOfServiceSub.
  ///
  /// In en, this message translates to:
  /// **'Read our terms and conditions'**
  String get termsOfServiceSub;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySub.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get privacyPolicySub;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made with FCI Student IT Department for car owners'**
  String get madeWithLove;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 DriveMate. All rights reserved.'**
  String get copyright;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get callUs;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @subjectHint.
  ///
  /// In en, this message translates to:
  /// **'What do you need help with?'**
  String get subjectHint;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue in detail...'**
  String get messageHint;

  /// No description provided for @sendMessageButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessageButton;

  /// No description provided for @responseTime.
  ///
  /// In en, this message translates to:
  /// **'Response Time'**
  String get responseTime;

  /// No description provided for @responseTimeNote.
  ///
  /// In en, this message translates to:
  /// **'Our support team typically responds within 24 hours. For urgent issues, please use live chat.'**
  String get responseTimeNote;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @microphone.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get microphone;

  /// No description provided for @allowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get allowed;

  /// No description provided for @notAllowed.
  ///
  /// In en, this message translates to:
  /// **'Not allowed'**
  String get notAllowed;

  /// No description provided for @permissionsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Why we need permissions:'**
  String get permissionsInfoTitle;

  /// No description provided for @permissionsInfoBody.
  ///
  /// In en, this message translates to:
  /// **'Location helps find nearby services, microphone enables voice commands, and notifications keep you updated on maintenance.'**
  String get permissionsInfoBody;

  /// No description provided for @clearSearchHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Search History'**
  String get clearSearchHistory;

  /// No description provided for @clearSearchHistorySub.
  ///
  /// In en, this message translates to:
  /// **'Remove all search records'**
  String get clearSearchHistorySub;

  /// No description provided for @requestDataExport.
  ///
  /// In en, this message translates to:
  /// **'Request Data Export'**
  String get requestDataExport;

  /// No description provided for @requestDataExportSub.
  ///
  /// In en, this message translates to:
  /// **'Download your data as JSON'**
  String get requestDataExportSub;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSub.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your account'**
  String get deleteAccountSub;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get enterCurrentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @reEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get reEnterNewPassword;

  /// No description provided for @requirementLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get requirementLength;

  /// No description provided for @requirementUppercase.
  ///
  /// In en, this message translates to:
  /// **'One uppercase letter'**
  String get requirementUppercase;

  /// No description provided for @requirementLowercase.
  ///
  /// In en, this message translates to:
  /// **'One lowercase letter'**
  String get requirementLowercase;

  /// No description provided for @requirementNumber.
  ///
  /// In en, this message translates to:
  /// **'One number'**
  String get requirementNumber;

  /// No description provided for @changeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Change Your Password'**
  String get changeYourPassword;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @addAllYourVehical.
  ///
  /// In en, this message translates to:
  /// **'Add all your vehicles to track maintenance, get AI diagnostics, and book services easily.'**
  String get addAllYourVehical;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @noMoreScans.
  ///
  /// In en, this message translates to:
  /// **'no more Scan'**
  String get noMoreScans;

  /// No description provided for @yourVechical.
  ///
  /// In en, this message translates to:
  /// **'Your Vehicles'**
  String get yourVechical;

  /// No description provided for @currentLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'current Language : English'**
  String get currentLanguageEnglish;

  /// No description provided for @continueWhere.
  ///
  /// In en, this message translates to:
  /// **'Continue where you left off'**
  String get continueWhere;

  /// No description provided for @recommendedMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Recommended Maintenance'**
  String get recommendedMaintenance;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get recommendedForYou;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changeImage;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @myCars.
  ///
  /// In en, this message translates to:
  /// **'My Cars'**
  String get myCars;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @youMust.
  ///
  /// In en, this message translates to:
  /// **'You Must Enter Value'**
  String get youMust;

  /// No description provided for @marketPlace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketPlace;

  /// No description provided for @maintenanceHistory.
  ///
  /// In en, this message translates to:
  /// **'Maintenance History'**
  String get maintenanceHistory;

  /// No description provided for @pastbookings.
  ///
  /// In en, this message translates to:
  /// **'Past bookings'**
  String get pastbookings;

  /// No description provided for @recordingTooShort.
  ///
  /// In en, this message translates to:
  /// **'Recording must be at least 5 seconds. Please try again.'**
  String get recordingTooShort;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @maintenanceReminders.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Reminders'**
  String get maintenanceReminders;

  /// No description provided for @maintenanceRemindersSub.
  ///
  /// In en, this message translates to:
  /// **'Get notified about upcoming services'**
  String get maintenanceRemindersSub;

  /// No description provided for @offersPromotions.
  ///
  /// In en, this message translates to:
  /// **'Offers & Promotions'**
  String get offersPromotions;

  /// No description provided for @offersPromotionsSub.
  ///
  /// In en, this message translates to:
  /// **'Receive special deals and discounts'**
  String get offersPromotionsSub;

  /// No description provided for @aiAlerts.
  ///
  /// In en, this message translates to:
  /// **'AI Alerts'**
  String get aiAlerts;

  /// No description provided for @aiAlertsSub.
  ///
  /// In en, this message translates to:
  /// **'Intelligent diagnostic notifications'**
  String get aiAlertsSub;

  /// No description provided for @emergencyUpdates.
  ///
  /// In en, this message translates to:
  /// **'Emergency Updates'**
  String get emergencyUpdates;

  /// No description provided for @emergencyUpdatesSub.
  ///
  /// In en, this message translates to:
  /// **'Critical alerts and safety recalls'**
  String get emergencyUpdatesSub;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get addReview;

  /// No description provided for @checkNow.
  ///
  /// In en, this message translates to:
  /// **'Check Now'**
  String get checkNow;

  /// No description provided for @oilChangeOnly.
  ///
  /// In en, this message translates to:
  /// **'Oil Change'**
  String get oilChangeOnly;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Up Coming'**
  String get upcoming;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @carTips.
  ///
  /// In en, this message translates to:
  /// **'Car Tips & Guides'**
  String get carTips;

  /// No description provided for @savedItem.
  ///
  /// In en, this message translates to:
  /// **'Saved Items'**
  String get savedItem;

  /// No description provided for @seeMap.
  ///
  /// In en, this message translates to:
  /// **'See map'**
  String get seeMap;

  /// No description provided for @findNearby.
  ///
  /// In en, this message translates to:
  /// **'Find Nearby Station'**
  String get findNearby;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get listView;

  /// No description provided for @mapView.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get mapView;

  /// No description provided for @openNow.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get openNow;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Maps'**
  String get openInMaps;

  /// No description provided for @openingMaps.
  ///
  /// In en, this message translates to:
  /// **'Opening maps...'**
  String get openingMaps;

  /// No description provided for @codeExpiresIn10Minutes.
  ///
  /// In en, this message translates to:
  /// **'code Expires In 10 Minutes'**
  String get codeExpiresIn10Minutes;

  /// No description provided for @weSentACode.
  ///
  /// In en, this message translates to:
  /// **'we Sent a Code'**
  String get weSentACode;

  /// No description provided for @openMapsFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to open maps'**
  String get openMapsFailed;

  /// No description provided for @welcomeToDriveMate.
  ///
  /// In en, this message translates to:
  /// **'Welcome to DriveMate'**
  String get welcomeToDriveMate;

  /// No description provided for @pleaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Please log in the form below.'**
  String get pleaseLogin;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @nearByService.
  ///
  /// In en, this message translates to:
  /// **'Nearby Service Centers'**
  String get nearByService;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get checkYourEmail;

  /// No description provided for @upcomingMaintence.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Maintenance'**
  String get upcomingMaintence;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmail;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please, enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @maintenanceBooking.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Booking'**
  String get maintenanceBooking;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @estimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDuration;

  /// No description provided for @estimatedCost.
  ///
  /// In en, this message translates to:
  /// **'Estimated Cost'**
  String get estimatedCost;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @featuredCars.
  ///
  /// In en, this message translates to:
  /// **'Featured Cars'**
  String get featuredCars;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @doesntMatch.
  ///
  /// In en, this message translates to:
  /// **'The password doesn\'\'t match'**
  String get doesntMatch;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @vehicleStatus.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Status'**
  String get vehicleStatus;

  /// No description provided for @healthMetrics.
  ///
  /// In en, this message translates to:
  /// **'HEALTH METRICS'**
  String get healthMetrics;

  /// No description provided for @engineHealthSub.
  ///
  /// In en, this message translates to:
  /// **'Engine running smoothly. No issues detected.'**
  String get engineHealthSub;

  /// No description provided for @batteryHealthSub.
  ///
  /// In en, this message translates to:
  /// **'Battery voltage lower than optimal. Consider replacement soon.'**
  String get batteryHealthSub;

  /// No description provided for @tirePressure.
  ///
  /// In en, this message translates to:
  /// **'Tire Pressure'**
  String get tirePressure;

  /// No description provided for @tirePressureSub.
  ///
  /// In en, this message translates to:
  /// **'All tires at optimal pressure: 32 PSI average.'**
  String get tirePressureSub;

  /// No description provided for @oilLife.
  ///
  /// In en, this message translates to:
  /// **'Oil Life'**
  String get oilLife;

  /// No description provided for @oilLifeSub.
  ///
  /// In en, this message translates to:
  /// **'Oil change recommended in 500 miles.'**
  String get oilLifeSub;

  /// No description provided for @engineHealth.
  ///
  /// In en, this message translates to:
  /// **'Engine Health'**
  String get engineHealth;

  /// No description provided for @latestCarNews.
  ///
  /// In en, this message translates to:
  /// **'Latest Car News'**
  String get latestCarNews;

  /// No description provided for @recommendedService.
  ///
  /// In en, this message translates to:
  /// **'Recommended Service'**
  String get recommendedService;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @resetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get resetYourPassword;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid password'**
  String get pleaseEnterValidPassword;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get continueWithApple;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @aiVoiceDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'AI Voice Diagnosis'**
  String get aiVoiceDiagnosis;

  /// No description provided for @recordCarSound.
  ///
  /// In en, this message translates to:
  /// **'Record Your Car Sound'**
  String get recordCarSound;

  /// No description provided for @recordHint.
  ///
  /// In en, this message translates to:
  /// **'Our AI will analyze engine sounds to detect potential issues'**
  String get recordHint;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to Start Recording'**
  String get tapToStart;

  /// No description provided for @max30Seconds.
  ///
  /// In en, this message translates to:
  /// **'Max 30 seconds'**
  String get max30Seconds;

  /// No description provided for @uploadAudio.
  ///
  /// In en, this message translates to:
  /// **'Upload Audio'**
  String get uploadAudio;

  /// No description provided for @recentScans.
  ///
  /// In en, this message translates to:
  /// **'Recent Scans'**
  String get recentScans;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @recordStop.
  ///
  /// In en, this message translates to:
  /// **'Stop Recording'**
  String get recordStop;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading audio...'**
  String get uploading;

  /// No description provided for @uploadFromDevice.
  ///
  /// In en, this message translates to:
  /// **'Upload from device'**
  String get uploadFromDevice;

  /// No description provided for @noRecordingFound.
  ///
  /// In en, this message translates to:
  /// **'No recording found'**
  String get noRecordingFound;

  /// No description provided for @pickAudioFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to pick audio file'**
  String get pickAudioFailed;

  /// No description provided for @micPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied'**
  String get micPermissionDenied;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @vehicleAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Added!'**
  String get vehicleAddedTitle;

  /// No description provided for @vehicleAddedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your vehicle has been successfully registered to your account'**
  String get vehicleAddedSubtitle;

  /// No description provided for @manufacturingYear.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing Year'**
  String get manufacturingYear;

  /// No description provided for @plateNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumberLabel;

  /// No description provided for @backToMyCars.
  ///
  /// In en, this message translates to:
  /// **'Back to My Cars'**
  String get backToMyCars;

  /// No description provided for @registerVehicle.
  ///
  /// In en, this message translates to:
  /// **'Register Your Vehicle'**
  String get registerVehicle;

  /// No description provided for @registerVehicleHint.
  ///
  /// In en, this message translates to:
  /// **'Track maintenance and service history'**
  String get registerVehicleHint;

  /// No description provided for @brandRequired.
  ///
  /// In en, this message translates to:
  /// **'Brand  *'**
  String get brandRequired;

  /// No description provided for @modelRequired.
  ///
  /// In en, this message translates to:
  /// **'Model  *'**
  String get modelRequired;

  /// No description provided for @yearRequired.
  ///
  /// In en, this message translates to:
  /// **'Year  *'**
  String get yearRequired;

  /// No description provided for @plateNumberOptional.
  ///
  /// In en, this message translates to:
  /// **'Plate Number *'**
  String get plateNumberOptional;

  /// No description provided for @currentMileageOptional.
  ///
  /// In en, this message translates to:
  /// **'Current Mileage (Optional)'**
  String get currentMileageOptional;

  /// No description provided for @modelHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Camry, Accord, X5'**
  String get modelHint;

  /// No description provided for @plateNumberHint.
  ///
  /// In en, this message translates to:
  /// **'E.g., ABC-1234'**
  String get plateNumberHint;

  /// No description provided for @mileageHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 45000'**
  String get mileageHint;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePassword;

  /// No description provided for @resetByEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'\'ll send you a reset link.'**
  String get resetByEmail;

  /// No description provided for @pleaseEnterTheCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code'**
  String get pleaseEnterTheCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @dontGotEmail.
  ///
  /// In en, this message translates to:
  /// **'Haven\'\'t got the email? '**
  String get dontGotEmail;

  /// No description provided for @passwordRest.
  ///
  /// In en, this message translates to:
  /// **'Password reset'**
  String get passwordRest;

  /// No description provided for @emergencyCall.
  ///
  /// In en, this message translates to:
  /// **'Emergency Call'**
  String get emergencyCall;

  /// No description provided for @emergencyAssistance.
  ///
  /// In en, this message translates to:
  /// **'Emergency Assistance'**
  String get emergencyAssistance;

  /// No description provided for @emergencySos.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get emergencySos;

  /// No description provided for @sos.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get sos;

  /// No description provided for @tapToCallEmergency.
  ///
  /// In en, this message translates to:
  /// **'Tap to call emergency'**
  String get tapToCallEmergency;

  /// No description provided for @emergencyNote.
  ///
  /// In en, this message translates to:
  /// **'This will immediately alert emergency services and share your location'**
  String get emergencyNote;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get currentLocation;

  /// No description provided for @gpsActive.
  ///
  /// In en, this message translates to:
  /// **'GPS Active'**
  String get gpsActive;

  /// No description provided for @gpsInactive.
  ///
  /// In en, this message translates to:
  /// **'GPS Off'**
  String get gpsInactive;

  /// No description provided for @locationLoading.
  ///
  /// In en, this message translates to:
  /// **'Getting your location...'**
  String get locationLoading;

  /// No description provided for @locationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are off'**
  String get locationDisabled;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @towService.
  ///
  /// In en, this message translates to:
  /// **'Tow Service'**
  String get towService;

  /// No description provided for @ambulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get ambulance;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get police;

  /// No description provided for @fireTruck.
  ///
  /// In en, this message translates to:
  /// **'Firetruck'**
  String get fireTruck;

  /// No description provided for @serviceCenter.
  ///
  /// In en, this message translates to:
  /// **'Service Center'**
  String get serviceCenter;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @availableServices.
  ///
  /// In en, this message translates to:
  /// **'Available Services'**
  String get availableServices;

  /// No description provided for @brakeService.
  ///
  /// In en, this message translates to:
  /// **'Brake Service'**
  String get brakeService;

  /// No description provided for @diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get diagnostics;

  /// No description provided for @engineRepair.
  ///
  /// In en, this message translates to:
  /// **'Engine Repair'**
  String get engineRepair;

  /// No description provided for @tireService.
  ///
  /// In en, this message translates to:
  /// **'Tire Service'**
  String get tireService;

  /// No description provided for @acService.
  ///
  /// In en, this message translates to:
  /// **'AC Service'**
  String get acService;

  /// No description provided for @batteryReplacement.
  ///
  /// In en, this message translates to:
  /// **'Battery Replacement'**
  String get batteryReplacement;

  /// No description provided for @wheelAlignment.
  ///
  /// In en, this message translates to:
  /// **'Wheel Alignment'**
  String get wheelAlignment;

  /// No description provided for @selectDateTime.
  ///
  /// In en, this message translates to:
  /// **'Select Date & Time'**
  String get selectDateTime;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful'**
  String get registrationSuccessful;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get loginSuccessful;

  /// No description provided for @passwordResetSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Successful'**
  String get passwordResetSuccessful;

  /// No description provided for @accountToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please log in to continue'**
  String get accountToContinue;

  /// No description provided for @agreeWith.
  ///
  /// In en, this message translates to:
  /// **'Agree with '**
  String get agreeWith;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'termsAndConditions'**
  String get termsAndConditions;

  /// No description provided for @reEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'reEnterNewPassword'**
  String get reEnterYourPassword;

  /// No description provided for @setNewPasswordHintText.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be at least 8 characters long and include a mix of uppercase letters, lowercase letters, numbers, and special characters.'**
  String get setNewPasswordHintText;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get setNewPassword;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @commonMaintenance.
  ///
  /// In en, this message translates to:
  /// **'commonMaintenance'**
  String get commonMaintenance;

  /// No description provided for @keySpecifications.
  ///
  /// In en, this message translates to:
  /// **'Key Specifications'**
  String get keySpecifications;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'highlights'**
  String get highlights;

  /// No description provided for @carTagline.
  ///
  /// In en, this message translates to:
  /// **'carTagline'**
  String get carTagline;

  /// No description provided for @passwordChangedMessage.
  ///
  /// In en, this message translates to:
  /// **'passwordChangedMessage'**
  String get passwordChangedMessage;

  /// No description provided for @pleaseAgreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the Terms & Conditions'**
  String get pleaseAgreeToTerms;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit the app'**
  String get pressBackAgainToExit;

  /// No description provided for @updateYourVehicleHint.
  ///
  /// In en, this message translates to:
  /// **'Keep your vehicle information up to date'**
  String get updateYourVehicleHint;

  /// No description provided for @updateYourVehicle.
  ///
  /// In en, this message translates to:
  /// **'UPDATE YOUR VEHICLE'**
  String get updateYourVehicle;

  /// No description provided for @reviewDetails.
  ///
  /// In en, this message translates to:
  /// **'REVIEW DETAILS'**
  String get reviewDetails;

  /// No description provided for @keySpecificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'KEY SPECIFICATIONS'**
  String get keySpecificationsLabel;

  /// No description provided for @ownershipDetails.
  ///
  /// In en, this message translates to:
  /// **'OWNERSHIP DETAILS'**
  String get ownershipDetails;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase Date'**
  String get purchaseDate;

  /// No description provided for @purchaseDateHint.
  ///
  /// In en, this message translates to:
  /// **'mm/dd/yyyy'**
  String get purchaseDateHint;

  /// No description provided for @serviceReminders.
  ///
  /// In en, this message translates to:
  /// **'Service Reminders'**
  String get serviceReminders;

  /// No description provided for @serviceRemindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Get notified when it\'s time for oil changes, tire rotations, and other maintenance'**
  String get serviceRemindersDescription;

  /// No description provided for @oilChangeInterval.
  ///
  /// In en, this message translates to:
  /// **'Every 6 months'**
  String get oilChangeInterval;

  /// No description provided for @tireRotation.
  ///
  /// In en, this message translates to:
  /// **'Tire Rotation'**
  String get tireRotation;

  /// No description provided for @tireRotationInterval.
  ///
  /// In en, this message translates to:
  /// **'Every 10,000 km'**
  String get tireRotationInterval;

  /// No description provided for @brakeInspection.
  ///
  /// In en, this message translates to:
  /// **'Brake Inspection'**
  String get brakeInspection;

  /// No description provided for @brakeInspectionInterval.
  ///
  /// In en, this message translates to:
  /// **'Every 12 months'**
  String get brakeInspectionInterval;

  /// No description provided for @searchExploreHint.
  ///
  /// In en, this message translates to:
  /// **'Search cars, parts, services...'**
  String get searchExploreHint;

  /// No description provided for @manageYourFleet.
  ///
  /// In en, this message translates to:
  /// **'Manage your fleet'**
  String get manageYourFleet;

  /// No description provided for @manageVehicls.
  ///
  /// In en, this message translates to:
  /// **'Manage vehicles'**
  String get manageVehicls;

  /// No description provided for @preference.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preference;

  /// No description provided for @inService.
  ///
  /// In en, this message translates to:
  /// **'In Service'**
  String get inService;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @stayOnTopMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Stay on Top of Maintenance'**
  String get stayOnTopMaintenance;

  /// No description provided for @stayOnTopMaintenanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders to receive notifications for upcoming service intervals based on your car\'s schedule.'**
  String get stayOnTopMaintenanceDescription;

  /// No description provided for @tirePressureLow.
  ///
  /// In en, this message translates to:
  /// **'Pressure May Be Low'**
  String get tirePressureLow;

  /// No description provided for @aiMaintenance.
  ///
  /// In en, this message translates to:
  /// **'AI Maintenance Tip'**
  String get aiMaintenance;

  /// No description provided for @batteryStatus.
  ///
  /// In en, this message translates to:
  /// **'Your battery voltage is slightly below optimal. Consider getting it checked soon.'**
  String get batteryStatus;

  /// No description provided for @checkTirePressure.
  ///
  /// In en, this message translates to:
  /// **'Check tire pressure before long trips'**
  String get checkTirePressure;

  /// No description provided for @annual.
  ///
  /// In en, this message translates to:
  /// **'Annual Inspection'**
  String get annual;

  /// No description provided for @vehicleAddedNote.
  ///
  /// In en, this message translates to:
  /// **'You can now track maintenance history and get personalized service recommendations for your vehicle!'**
  String get vehicleAddedNote;

  /// No description provided for @addVehicleNote.
  ///
  /// In en, this message translates to:
  /// **'Adding your vehicle helps us provide personalized maintenance recommendations and service reminders.'**
  String get addVehicleNote;

  /// No description provided for @recommendedBannerText.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you based on your car & usages'**
  String get recommendedBannerText;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due in 500 km'**
  String get due;

  /// No description provided for @due2.
  ///
  /// In en, this message translates to:
  /// **'Due in 7 days'**
  String get due2;

  /// No description provided for @due3.
  ///
  /// In en, this message translates to:
  /// **'Due in 2 weeks'**
  String get due3;

  /// No description provided for @askQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a question or share a tip...'**
  String get askQuestion;

  /// No description provided for @shareService.
  ///
  /// In en, this message translates to:
  /// **'Share your service center experience'**
  String get shareService;

  /// No description provided for @weWillVerfiction.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send verification emails to this address'**
  String get weWillVerfiction;

  /// No description provided for @informationHelp.
  ///
  /// In en, this message translates to:
  /// **'This information helps service providers contact you and deliver better service.'**
  String get informationHelp;

  /// No description provided for @keepYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Keep your info up to date'**
  String get keepYourInfo;

  /// No description provided for @notMatch.
  ///
  /// In en, this message translates to:
  /// **'No cars match your filters.'**
  String get notMatch;

  /// No description provided for @carservice.
  ///
  /// In en, this message translates to:
  /// **'Cars & services you bookmarked'**
  String get carservice;

  /// No description provided for @recentlyViewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get recentlyViewed;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @oilChangeDue.
  ///
  /// In en, this message translates to:
  /// **'Oil change due in 500 miles'**
  String get oilChangeDue;

  /// No description provided for @aiBasedRecommendation.
  ///
  /// In en, this message translates to:
  /// **'AI-Based Recommendation'**
  String get aiBasedRecommendation;

  /// No description provided for @recommendedServiceNote.
  ///
  /// In en, this message translates to:
  /// **'Based on your current mileage and driving patterns, we recommend scheduling an oil change soon. Regular oil changes help maintain engine health and prevent costly repairs.'**
  String get recommendedServiceNote;

  /// No description provided for @confidenceLevel.
  ///
  /// In en, this message translates to:
  /// **'Confidence Level'**
  String get confidenceLevel;

  /// No description provided for @findNearestCenter.
  ///
  /// In en, this message translates to:
  /// **'Find Nearest Center'**
  String get findNearestCenter;

  /// No description provided for @findNearestCenterSub.
  ///
  /// In en, this message translates to:
  /// **'Locate service centers near you'**
  String get findNearestCenterSub;

  /// No description provided for @bookNowSub.
  ///
  /// In en, this message translates to:
  /// **'Schedule your oil change today'**
  String get bookNowSub;

  /// No description provided for @setReminder.
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminder;

  /// No description provided for @setReminderSub.
  ///
  /// In en, this message translates to:
  /// **'Get notified when it\'s time'**
  String get setReminderSub;

  /// No description provided for @filterReplacement.
  ///
  /// In en, this message translates to:
  /// **'Filter Replacement'**
  String get filterReplacement;

  /// No description provided for @oilChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Oil Change'**
  String get oilChangeTitle;

  /// No description provided for @seeTips.
  ///
  /// In en, this message translates to:
  /// **'See Tips'**
  String get seeTips;

  /// No description provided for @runAiScan.
  ///
  /// In en, this message translates to:
  /// **'Run AI Scan'**
  String get runAiScan;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @oilhealth.
  ///
  /// In en, this message translates to:
  /// **'Oil Health'**
  String get oilhealth;

  /// No description provided for @mapPreview.
  ///
  /// In en, this message translates to:
  /// **'Map view (mock)'**
  String get mapPreview;

  /// No description provided for @notificationSchedule.
  ///
  /// In en, this message translates to:
  /// **'Notification Schedule'**
  String get notificationSchedule;

  /// No description provided for @setQuietHours.
  ///
  /// In en, this message translates to:
  /// **'Set quiet hours'**
  String get setQuietHours;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @notificationSettingsSub.
  ///
  /// In en, this message translates to:
  /// **'You can customize your notification preferences at any time. Emergency updates are highly recommended for safety.'**
  String get notificationSettingsSub;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminders & offers'**
  String get reminder;

  /// No description provided for @autoSaveEnabled.
  ///
  /// In en, this message translates to:
  /// **'Auto-save Enabled'**
  String get autoSaveEnabled;

  /// No description provided for @autoSaveThemeNote.
  ///
  /// In en, this message translates to:
  /// **'Your theme preference is saved automatically and syncs across all your devices.'**
  String get autoSaveThemeNote;

  /// No description provided for @lightDark.
  ///
  /// In en, this message translates to:
  /// **'Light / Dark'**
  String get lightDark;

  /// No description provided for @englishArabic.
  ///
  /// In en, this message translates to:
  /// **'English / العربية'**
  String get englishArabic;

  /// No description provided for @notificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATION PREFERENCES'**
  String get notificationPreferences;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE'**
  String get schedule;

  /// No description provided for @appPermissions.
  ///
  /// In en, this message translates to:
  /// **'APP PERMISSIONS'**
  String get appPermissions;

  /// No description provided for @yourData.
  ///
  /// In en, this message translates to:
  /// **'YOUR DATA'**
  String get yourData;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get dangerZone;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'LEGAL'**
  String get legal;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get contact;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD REQUIREMENTS'**
  String get passwordRequirements;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// No description provided for @allVehicles.
  ///
  /// In en, this message translates to:
  /// **'All Vehicles'**
  String get allVehicles;

  /// No description provided for @manageFleet.
  ///
  /// In en, this message translates to:
  /// **'Manage your fleet'**
  String get manageFleet;

  /// No description provided for @namePhone.
  ///
  /// In en, this message translates to:
  /// **'Name, phone, email'**
  String get namePhone;

  /// No description provided for @towHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose Tow Service'**
  String get towHelp;

  /// No description provided for @helpoo.
  ///
  /// In en, this message translates to:
  /// **'Helpoo Roadside Assistance'**
  String get helpoo;

  /// No description provided for @egTowing.
  ///
  /// In en, this message translates to:
  /// **'EG Towing'**
  String get egTowing;

  /// No description provided for @mercedesRoadside.
  ///
  /// In en, this message translates to:
  /// **'Mercedes-Benz Roadside'**
  String get mercedesRoadside;

  /// No description provided for @coursalTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Diagnose Your Car'**
  String get coursalTitle;

  /// No description provided for @currentLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Current language'**
  String get currentLanguageLabel;

  /// No description provided for @coursalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Voice-based sound analysis'**
  String get coursalSubtitle;

  /// No description provided for @carNews.
  ///
  /// In en, this message translates to:
  /// **'Car News'**
  String get carNews;

  /// No description provided for @essentialCar.
  ///
  /// In en, this message translates to:
  /// **'Essential Car'**
  String get essentialCar;

  /// No description provided for @howToExtend.
  ///
  /// In en, this message translates to:
  /// **'How To Extend'**
  String get howToExtend;

  /// No description provided for @minRead.
  ///
  /// In en, this message translates to:
  /// **'Min Read : 5 Min'**
  String get minRead;

  /// No description provided for @completeGuide.
  ///
  /// In en, this message translates to:
  /// **'Complete Guide'**
  String get completeGuide;

  /// No description provided for @emergencyModeActive.
  ///
  /// In en, this message translates to:
  /// **'Emergency Mode Active'**
  String get emergencyModeActive;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @selectBrand.
  ///
  /// In en, this message translates to:
  /// **'Select Brand'**
  String get selectBrand;

  /// No description provided for @selectBrandFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Brand First'**
  String get selectBrandFirst;

  /// No description provided for @selectModel.
  ///
  /// In en, this message translates to:
  /// **'Select Model'**
  String get selectModel;

  /// No description provided for @selectYear.
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get selectYear;

  /// No description provided for @pleaseSelectDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Please Select Date And Time'**
  String get pleaseSelectDateAndTime;

  /// No description provided for @bookingRescheduled.
  ///
  /// In en, this message translates to:
  /// **'Booking Rescheduled'**
  String get bookingRescheduled;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password DoNot Match'**
  String get passwordsDoNotMatch;

  /// No description provided for @carTipsAndNews.
  ///
  /// In en, this message translates to:
  /// **'carTipsAndNews'**
  String get carTipsAndNews;

  /// No description provided for @noSavedItems.
  ///
  /// In en, this message translates to:
  /// **'noSavedItems'**
  String get noSavedItems;

  /// No description provided for @carTipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'carTipsSubtitle'**
  String get carTipsSubtitle;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'emergency'**
  String get emergency;

  /// No description provided for @brakes.
  ///
  /// In en, this message translates to:
  /// **'Brakes'**
  String get brakes;

  /// No description provided for @tires.
  ///
  /// In en, this message translates to:
  /// **'Tires'**
  String get tires;

  /// No description provided for @fuelEconomy.
  ///
  /// In en, this message translates to:
  /// **'Fuel Economy'**
  String get fuelEconomy;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @articleIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Whether you\'re buying your first car or switching providers, these tips will ensure you get the best coverage at the right price.'**
  String get articleIntroduction;

  /// No description provided for @articleSaved.
  ///
  /// In en, this message translates to:
  /// **'Article Saved'**
  String get articleSaved;

  /// No description provided for @keyConsideration.
  ///
  /// In en, this message translates to:
  /// **'Key Consideration'**
  String get keyConsideration;

  /// No description provided for @keyTakeAway.
  ///
  /// In en, this message translates to:
  /// **'Key Take Away'**
  String get keyTakeAway;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All Read'**
  String get markAllRead;

  /// No description provided for @noNotification.
  ///
  /// In en, this message translates to:
  /// **'No Notification'**
  String get noNotification;

  /// No description provided for @oilPercent.
  ///
  /// In en, this message translates to:
  /// **'Oil Percent'**
  String get oilPercent;

  /// No description provided for @shareOptionOpened.
  ///
  /// In en, this message translates to:
  /// **'Share Option Opened'**
  String get shareOptionOpened;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @theBestCar.
  ///
  /// In en, this message translates to:
  /// **'The best car insurance balances comprehensive coverage with affordable premiums. Always read the fine print and understand what\'s covered before signing up.'**
  String get theBestCar;

  /// No description provided for @vehicleName.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name'**
  String get vehicleName;

  /// No description provided for @vehicleStatusSummary.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Status Summary'**
  String get vehicleStatusSummary;

  /// No description provided for @weatherYou.
  ///
  /// In en, this message translates to:
  /// **'Whether you\'re buying your first car or switching providers, these tips will ensure you get the best coverage at the right price.'**
  String get weatherYou;

  /// No description provided for @noSavedItemsInCategory.
  ///
  /// In en, this message translates to:
  /// **'noSavedItemsInCategory'**
  String get noSavedItemsInCategory;

  /// No description provided for @maintanenceNearService.
  ///
  /// In en, this message translates to:
  /// **'maintanenceNearService'**
  String get maintanenceNearService;

  /// No description provided for @rescheduleBooking.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Booking'**
  String get rescheduleBooking;

  /// No description provided for @currentBookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Current Booking Details'**
  String get currentBookingDetails;

  /// No description provided for @rescheduleBookingNote.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Booking Note'**
  String get rescheduleBookingNote;

  /// No description provided for @selectNewDate.
  ///
  /// In en, this message translates to:
  /// **'Select New Date'**
  String get selectNewDate;

  /// No description provided for @selectNewTime.
  ///
  /// In en, this message translates to:
  /// **'Select New Time'**
  String get selectNewTime;

  /// No description provided for @reasonForRescheduling.
  ///
  /// In en, this message translates to:
  /// **'Reason For Rescheduling'**
  String get reasonForRescheduling;

  /// No description provided for @rescheduleReasonHint.
  ///
  /// In en, this message translates to:
  /// **'rescheduleReasonHint'**
  String get rescheduleReasonHint;

  /// No description provided for @newAppointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'New Appointment Details'**
  String get newAppointmentDetails;

  /// No description provided for @newDate.
  ///
  /// In en, this message translates to:
  /// **'New Date'**
  String get newDate;

  /// No description provided for @newTime.
  ///
  /// In en, this message translates to:
  /// **'New Time'**
  String get newTime;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'vehicle'**
  String get vehicle;

  /// No description provided for @confirmReschedule.
  ///
  /// In en, this message translates to:
  /// **'Confirm Reschedule'**
  String get confirmReschedule;

  /// No description provided for @noAdditionalCharges.
  ///
  /// In en, this message translates to:
  /// **'noAdditionalCharges'**
  String get noAdditionalCharges;

  /// No description provided for @helpOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'Help is on the way'**
  String get helpOnTheWay;

  /// No description provided for @aiVoice.
  ///
  /// In en, this message translates to:
  /// **'AI Voice Diagnosis'**
  String get aiVoice;

  /// No description provided for @startScan.
  ///
  /// In en, this message translates to:
  /// **'Start Scan'**
  String get startScan;

  /// No description provided for @recordStart.
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get recordStart;

  /// No description provided for @uploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Audio uploaded successfully'**
  String get uploadSuccess;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Audio upload failed'**
  String get uploadFailed;

  /// No description provided for @analyzingSound.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your sound...'**
  String get analyzingSound;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get tryAgain;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
