// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class CustomLocalizations {
  CustomLocalizations();

  static CustomLocalizations? _current;

  static CustomLocalizations get current {
    assert(_current != null,
        'No instance of CustomLocalizations was loaded. Try to initialize the CustomLocalizations delegate before accessing CustomLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<CustomLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = CustomLocalizations();
      CustomLocalizations._current = instance;

      return instance;
    });
  }

  static CustomLocalizations of(BuildContext context) {
    final instance = CustomLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of CustomLocalizations present in the widget tree. Did you add CustomLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static CustomLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  /// `This field cannot be empty.`
  String get requiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'requiredErrorText',
      desc: 'Error Text for required field',
      args: [],
    );
  }

  /// `Value must be greater than or equal to {min}.`
  String minErrorText(Object min) {
    return Intl.message(
      'Value must be greater than or equal to $min.',
      name: 'minErrorText',
      desc: 'Error Text for required field',
      args: [min],
    );
  }

  /// `Value must have a length greater than or equal to {minLength}`
  String minLengthErrorText(Object minLength) {
    return Intl.message(
      'Value must have a length greater than or equal to $minLength',
      name: 'minLengthErrorText',
      desc: 'Error Text for required field',
      args: [minLength],
    );
  }

  /// `Value must be less than or equal to {max}`
  String maxErrorText(Object max) {
    return Intl.message(
      'Value must be less than or equal to $max',
      name: 'maxErrorText',
      desc: 'Error Text for required field',
      args: [max],
    );
  }

  /// `Value must have a length less than or equal to {maxLength}`
  String maxLengthErrorText(Object maxLength) {
    return Intl.message(
      'Value must have a length less than or equal to $maxLength',
      name: 'maxLengthErrorText',
      desc: 'Error Text for required field',
      args: [maxLength],
    );
  }

  /// `This field requires a valid email address.`
  String get emailErrorText {
    return Intl.message(
      'This field requires a valid email address.',
      name: 'emailErrorText',
      desc: 'Error Text for email field',
      args: [],
    );
  }

  /// `This field requires a valid integer.`
  String get integerErrorText {
    return Intl.message(
      'This field requires a valid integer.',
      name: 'integerErrorText',
      desc: 'Error Text for integer validator',
      args: [],
    );
  }

  /// `This field value must be equal to {value}.`
  String equalErrorText(Object value) {
    return Intl.message(
      'This field value must be equal to $value.',
      name: 'equalErrorText',
      desc: 'Error Text for equal validator',
      args: [value],
    );
  }

  /// `This field value must not be equal to {value}.`
  String notEqualErrorText(Object value) {
    return Intl.message(
      'This field value must not be equal to $value.',
      name: 'notEqualErrorText',
      desc: 'Error Text for not-equal validator',
      args: [value],
    );
  }

  /// `This field requires a valid URL address.`
  String get urlErrorText {
    return Intl.message(
      'This field requires a valid URL address.',
      name: 'urlErrorText',
      desc: 'Error Text for URL field',
      args: [],
    );
  }

  /// `Value does not match pattern.`
  String get matchErrorText {
    return Intl.message(
      'Value does not match pattern.',
      name: 'matchErrorText',
      desc: 'Error Text for pattern field',
      args: [],
    );
  }

  /// `Value must be numeric.`
  String get numericErrorText {
    return Intl.message(
      'Value must be numeric.',
      name: 'numericErrorText',
      desc: 'Error Text for numeric field',
      args: [],
    );
  }

  /// `This field requires a valid credit card number.`
  String get creditCardErrorText {
    return Intl.message(
      'This field requires a valid credit card number.',
      name: 'creditCardErrorText',
      desc: 'Error Text for credit card field',
      args: [],
    );
  }

  /// `This field requires a valid IP.`
  String get ipErrorText {
    return Intl.message(
      'This field requires a valid IP.',
      name: 'ipErrorText',
      desc: 'Error Text for IP address field',
      args: [],
    );
  }

  /// `This field requires a valid date string.`
  String get dateStringErrorText {
    return Intl.message(
      'This field requires a valid date string.',
      name: 'dateStringErrorText',
      desc: 'Error Text for date string field',
      args: [],
    );
  }

  /// `username`
  String get username {
    return Intl.message(
      'username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPassword {
    return Intl.message(
      'confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `leave`
  String get leave {
    return Intl.message(
      'leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `sign in`
  String get signIn {
    return Intl.message(
      'sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Username or password invalid.`
  String get invalidAuth {
    return Intl.message(
      'Username or password invalid.',
      name: 'invalidAuth',
      desc: '',
      args: [],
    );
  }

  /// `forgotten password?`
  String get forgottenPassword {
    return Intl.message(
      'forgotten password?',
      name: 'forgottenPassword',
      desc: '',
      args: [],
    );
  }

  /// `connect display`
  String get connectDisplay {
    return Intl.message(
      'connect display',
      name: 'connectDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Powered by RLR`
  String get powered {
    return Intl.message(
      'Powered by RLR',
      name: 'powered',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again later.`
  String get error {
    return Intl.message(
      'An error occurred. Please try again later.',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the next cast...`
  String get waiting {
    return Intl.message(
      'Waiting for the next cast...',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Create a new cast`
  String get createCast {
    return Intl.message(
      'Create a new cast',
      name: 'createCast',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Events selection`
  String get selectEvent {
    return Intl.message(
      'Events selection',
      name: 'selectEvent',
      desc: '',
      args: [],
    );
  }

  /// `Groups selection`
  String get selectGroup {
    return Intl.message(
      'Groups selection',
      name: 'selectGroup',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get warning {
    return Intl.message(
      'Warning!',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this cast?`
  String get warningCast {
    return Intl.message(
      'Are you sure you want to delete this cast?',
      name: 'warningCast',
      desc: '',
      args: [],
    );
  }

  /// `Cast successfully deleted.`
  String get snackSuccessCast {
    return Intl.message(
      'Cast successfully deleted.',
      name: 'snackSuccessCast',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get snackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'snackError',
      desc: '',
      args: [],
    );
  }

  /// `{label}'s groups`
  String castGroups(Object label) {
    return Intl.message(
      '$label\'s groups',
      name: 'castGroups',
      desc: '',
      args: [label],
    );
  }

  /// `{label}'s events`
  String castEvents(Object label) {
    return Intl.message(
      '$label\'s events',
      name: 'castEvents',
      desc: '',
      args: [label],
    );
  }

  /// `create`
  String get create {
    return Intl.message(
      'create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `cast label`
  String get castRowLabel {
    return Intl.message(
      'cast label',
      name: 'castRowLabel',
      desc: '',
      args: [],
    );
  }

  /// `groups`
  String get castRowGroups {
    return Intl.message(
      'groups',
      name: 'castRowGroups',
      desc: '',
      args: [],
    );
  }

  /// `events`
  String get castRowEvents {
    return Intl.message(
      'events',
      name: 'castRowEvents',
      desc: '',
      args: [],
    );
  }

  /// `validate`
  String get validate {
    return Intl.message(
      'validate',
      name: 'validate',
      desc: '',
      args: [],
    );
  }

  /// `Cast successfully added.`
  String get addCastSnackSuccess {
    return Intl.message(
      'Cast successfully added.',
      name: 'addCastSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Cast label already used.`
  String get addCastSnackError {
    return Intl.message(
      'Cast label already used.',
      name: 'addCastSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Cast successfully edited.`
  String get editCastSnackSuccess {
    return Intl.message(
      'Cast successfully edited.',
      name: 'editCastSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Cast label already used.`
  String get editCastSnackError {
    return Intl.message(
      'Cast label already used.',
      name: 'editCastSnackError',
      desc: '',
      args: [],
    );
  }

  /// `The list is empty. Try adding some groups first.`
  String get groupListEmpty {
    return Intl.message(
      'The list is empty. Try adding some groups first.',
      name: 'groupListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No label was given!`
  String get noName {
    return Intl.message(
      'No label was given!',
      name: 'noName',
      desc: '',
      args: [],
    );
  }

  /// `No displays!`
  String get noDisplay {
    return Intl.message(
      'No displays!',
      name: 'noDisplay',
      desc: '',
      args: [],
    );
  }

  /// `cast label`
  String get castLabel {
    return Intl.message(
      'cast label',
      name: 'castLabel',
      desc: '',
      args: [],
    );
  }

  /// `The list is empty. Try adding some events first.`
  String get eventListEmpty {
    return Intl.message(
      'The list is empty. Try adding some events first.',
      name: 'eventListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `dashboard`
  String get navDashboard {
    return Intl.message(
      'dashboard',
      name: 'navDashboard',
      desc: '',
      args: [],
    );
  }

  /// `lives`
  String get navLives {
    return Intl.message(
      'lives',
      name: 'navLives',
      desc: '',
      args: [],
    );
  }

  /// `displays`
  String get navDisplays {
    return Intl.message(
      'displays',
      name: 'navDisplays',
      desc: '',
      args: [],
    );
  }

  /// `groups`
  String get navGroups {
    return Intl.message(
      'groups',
      name: 'navGroups',
      desc: '',
      args: [],
    );
  }

  /// `users`
  String get navUsers {
    return Intl.message(
      'users',
      name: 'navUsers',
      desc: '',
      args: [],
    );
  }

  /// `views`
  String get navViews {
    return Intl.message(
      'views',
      name: 'navViews',
      desc: '',
      args: [],
    );
  }

  /// `events`
  String get navEvents {
    return Intl.message(
      'events',
      name: 'navEvents',
      desc: '',
      args: [],
    );
  }

  /// `casts`
  String get navCasts {
    return Intl.message(
      'casts',
      name: 'navCasts',
      desc: '',
      args: [],
    );
  }

  /// `disconnect`
  String get navDisconnect {
    return Intl.message(
      'disconnect',
      name: 'navDisconnect',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `admin panel`
  String get adminPanel {
    return Intl.message(
      'admin panel',
      name: 'adminPanel',
      desc: '',
      args: [],
    );
  }

  /// `display label`
  String get displayName {
    return Intl.message(
      'display label',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `connect`
  String get connect {
    return Intl.message(
      'connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Invalid display label.`
  String get connectSnackError {
    return Intl.message(
      'Invalid display label.',
      name: 'connectSnackError',
      desc: '',
      args: [],
    );
  }

  /// `creation date`
  String get creationDate {
    return Intl.message(
      'creation date',
      name: 'creationDate',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this display?`
  String get warningDeleteDisplay {
    return Intl.message(
      'Are you sure you want to delete this display?',
      name: 'warningDeleteDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Display successfully deleted.`
  String get deleteDisplaySnackSuccess {
    return Intl.message(
      'Display successfully deleted.',
      name: 'deleteDisplaySnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get deleteDisplaySnackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'deleteDisplaySnackError',
      desc: '',
      args: [],
    );
  }

  /// `Create a new display`
  String get createDisplay {
    return Intl.message(
      'Create a new display',
      name: 'createDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Edit {label}'s label`
  String editDisplay(Object label) {
    return Intl.message(
      'Edit $label\'s label',
      name: 'editDisplay',
      desc: '',
      args: [label],
    );
  }

  /// `Display successfully created.`
  String get addDisplaySnackSucess {
    return Intl.message(
      'Display successfully created.',
      name: 'addDisplaySnackSucess',
      desc: '',
      args: [],
    );
  }

  /// `Display label already used.`
  String get addDisplaySnackError {
    return Intl.message(
      'Display label already used.',
      name: 'addDisplaySnackError',
      desc: '',
      args: [],
    );
  }

  /// `Display successfully edited.`
  String get editDisplaySnackSucess {
    return Intl.message(
      'Display successfully edited.',
      name: 'editDisplaySnackSucess',
      desc: '',
      args: [],
    );
  }

  /// `'Display label already used.`
  String get editDisplaySnackError {
    return Intl.message(
      '\'Display label already used.',
      name: 'editDisplaySnackError',
      desc: '',
      args: [],
    );
  }

  /// `event label`
  String get eventLabel {
    return Intl.message(
      'event label',
      name: 'eventLabel',
      desc: '',
      args: [],
    );
  }

  /// `Both value cannot be 0.`
  String get cannotBeZERO {
    return Intl.message(
      'Both value cannot be 0.',
      name: 'cannotBeZERO',
      desc: '',
      args: [],
    );
  }

  /// `Start time must happen before end time.`
  String get cannotHappenBefore {
    return Intl.message(
      'Start time must happen before end time.',
      name: 'cannotHappenBefore',
      desc: '',
      args: [],
    );
  }

  /// `Frequency : `
  String get frequency {
    return Intl.message(
      'Frequency : ',
      name: 'frequency',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `select starting date settings`
  String get selectStartDate {
    return Intl.message(
      'select starting date settings',
      name: 'selectStartDate',
      desc: '',
      args: [],
    );
  }

  /// `select ending date settings`
  String get selectEndDate {
    return Intl.message(
      'select ending date settings',
      name: 'selectEndDate',
      desc: '',
      args: [],
    );
  }

  /// `select a view`
  String get selectView {
    return Intl.message(
      'select a view',
      name: 'selectView',
      desc: '',
      args: [],
    );
  }

  /// `event label`
  String get eventName {
    return Intl.message(
      'event label',
      name: 'eventName',
      desc: '',
      args: [],
    );
  }

  /// `date`
  String get eventDate {
    return Intl.message(
      'date',
      name: 'eventDate',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get eventDays {
    return Intl.message(
      'days',
      name: 'eventDays',
      desc: '',
      args: [],
    );
  }

  /// `starting hour`
  String get eventStartHour {
    return Intl.message(
      'starting hour',
      name: 'eventStartHour',
      desc: '',
      args: [],
    );
  }

  /// `ending hour`
  String get eventEndHour {
    return Intl.message(
      'ending hour',
      name: 'eventEndHour',
      desc: '',
      args: [],
    );
  }

  /// `view`
  String get eventView {
    return Intl.message(
      'view',
      name: 'eventView',
      desc: '',
      args: [],
    );
  }

  /// `frequency (s)`
  String get eventFreq {
    return Intl.message(
      'frequency (s)',
      name: 'eventFreq',
      desc: '',
      args: [],
    );
  }

  /// `Event successfully copied.`
  String get copyEventSnackSucess {
    return Intl.message(
      'Event successfully copied.',
      name: 'copyEventSnackSucess',
      desc: '',
      args: [],
    );
  }

  /// `Label already used.`
  String get addEventSnackError {
    return Intl.message(
      'Label already used.',
      name: 'addEventSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this event?`
  String get warningDeleteEvent {
    return Intl.message(
      'Are you sure you want to delete this event?',
      name: 'warningDeleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Event successfully deleted.`
  String get deleteEventSnackSucess {
    return Intl.message(
      'Event successfully deleted.',
      name: 'deleteEventSnackSucess',
      desc: '',
      args: [],
    );
  }

  /// `Create a new view`
  String get createView {
    return Intl.message(
      'Create a new view',
      name: 'createView',
      desc: '',
      args: [],
    );
  }

  /// `Edit {label}`
  String editView(Object label) {
    return Intl.message(
      'Edit $label',
      name: 'editView',
      desc: '',
      args: [label],
    );
  }

  /// `View successfully added.`
  String get addViewSnackSuccess {
    return Intl.message(
      'View successfully added.',
      name: 'addViewSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Label already used.`
  String get addViewSnackError {
    return Intl.message(
      'Label already used.',
      name: 'addViewSnackError',
      desc: '',
      args: [],
    );
  }

  /// `View successfully modified.`
  String get editViewSnackSuccess {
    return Intl.message(
      'View successfully modified.',
      name: 'editViewSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Label already used.`
  String get editViewSnackError {
    return Intl.message(
      'Label already used.',
      name: 'editViewSnackError',
      desc: '',
      args: [],
    );
  }

  /// `group label`
  String get groupName {
    return Intl.message(
      'group label',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `view label`
  String get viewName {
    return Intl.message(
      'view label',
      name: 'viewName',
      desc: '',
      args: [],
    );
  }

  /// `displays`
  String get groupDisplays {
    return Intl.message(
      'displays',
      name: 'groupDisplays',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this group?`
  String get warningDeleteGroup {
    return Intl.message(
      'Are you sure you want to delete this group?',
      name: 'warningDeleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Group successfully deleted.`
  String get deleteGroupSnackSuccess {
    return Intl.message(
      'Group successfully deleted.',
      name: 'deleteGroupSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get deleteGroupSnackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'deleteGroupSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Create a new group`
  String get createGroup {
    return Intl.message(
      'Create a new group',
      name: 'createGroup',
      desc: '',
      args: [],
    );
  }

  /// `Edit {label} group`
  String editGroup(Object label) {
    return Intl.message(
      'Edit $label group',
      name: 'editGroup',
      desc: '',
      args: [label],
    );
  }

  /// `Group successfully added.`
  String get addGroupSnackSuccess {
    return Intl.message(
      'Group successfully added.',
      name: 'addGroupSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Group label already used.`
  String get addGroupSnackError {
    return Intl.message(
      'Group label already used.',
      name: 'addGroupSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Group successfully edited.`
  String get editGroupSnackSuccess {
    return Intl.message(
      'Group successfully edited.',
      name: 'editGroupSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Group label already used.`
  String get editGroupSnackError {
    return Intl.message(
      'Group label already used.',
      name: 'editGroupSnackError',
      desc: '',
      args: [],
    );
  }

  /// `group label`
  String get groupLabel {
    return Intl.message(
      'group label',
      name: 'groupLabel',
      desc: '',
      args: [],
    );
  }

  /// `{label}'s displays`
  String groupDisplayName(Object label) {
    return Intl.message(
      '$label\'s displays',
      name: 'groupDisplayName',
      desc: '',
      args: [label],
    );
  }

  /// `You must be authenticated to see this page.`
  String get mustBeAuth {
    return Intl.message(
      'You must be authenticated to see this page.',
      name: 'mustBeAuth',
      desc: '',
      args: [],
    );
  }

  /// `return to authentication page`
  String get returnToAuth {
    return Intl.message(
      'return to authentication page',
      name: 'returnToAuth',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `generate password`
  String get generatePass {
    return Intl.message(
      'generate password',
      name: 'generatePass',
      desc: '',
      args: [],
    );
  }

  /// `User successfully added.`
  String get addUserSnackSuccess {
    return Intl.message(
      'User successfully added.',
      name: 'addUserSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Username already used.`
  String get addUserSnackError {
    return Intl.message(
      'Username already used.',
      name: 'addUserSnackError',
      desc: '',
      args: [],
    );
  }

  /// `User successfully edited.`
  String get editUserSnackSuccess {
    return Intl.message(
      'User successfully edited.',
      name: 'editUserSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Username already used.`
  String get editUserSnackError {
    return Intl.message(
      'Username already used.',
      name: 'editUserSnackError',
      desc: '',
      args: [],
    );
  }

  /// `groups`
  String get userGroups {
    return Intl.message(
      'groups',
      name: 'userGroups',
      desc: '',
      args: [],
    );
  }

  /// `admin`
  String get userAdmin {
    return Intl.message(
      'admin',
      name: 'userAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this user?`
  String get warningDeleteUser {
    return Intl.message(
      'Are you sure you want to delete this user?',
      name: 'warningDeleteUser',
      desc: '',
      args: [],
    );
  }

  /// `User successfully deleted.`
  String get deleteUserSnackSuccess {
    return Intl.message(
      'User successfully deleted.',
      name: 'deleteUserSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get deleteUserSnackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'deleteUserSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Create a new user`
  String get createUser {
    return Intl.message(
      'Create a new user',
      name: 'createUser',
      desc: '',
      args: [],
    );
  }

  /// `Edit {username}'s profile`
  String editUser(Object username) {
    return Intl.message(
      'Edit $username\'s profile',
      name: 'editUser',
      desc: '',
      args: [username],
    );
  }

  /// `Should the user be admin ?`
  String get shouldBeAdmin {
    return Intl.message(
      'Should the user be admin ?',
      name: 'shouldBeAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Should {username} be admin ?`
  String shouldBeAdminName(Object username) {
    return Intl.message(
      'Should $username be admin ?',
      name: 'shouldBeAdminName',
      desc: '',
      args: [username],
    );
  }

  /// `{username}'s groups`
  String userGroupsName(Object username) {
    return Intl.message(
      '$username\'s groups',
      name: 'userGroupsName',
      desc: '',
      args: [username],
    );
  }

  /// `You don't have enough permission to see this page.`
  String get notEnoughPerms {
    return Intl.message(
      'You don\'t have enough permission to see this page.',
      name: 'notEnoughPerms',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this file?`
  String get warningDeleteFile {
    return Intl.message(
      'Are you sure you want to delete this file?',
      name: 'warningDeleteFile',
      desc: '',
      args: [],
    );
  }

  /// `File deleted successfully.`
  String get deleteFileSnackSuccess {
    return Intl.message(
      'File deleted successfully.',
      name: 'deleteFileSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get deleteFileSnackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'deleteFileSnackError',
      desc: '',
      args: [],
    );
  }

  /// `Files must be less than 4MB and have one of the following extensions :.jpg, .png, .jpeg, .gif.`
  String get fileSizeExt {
    return Intl.message(
      'Files must be less than 4MB and have one of the following extensions :.jpg, .png, .jpeg, .gif.',
      name: 'fileSizeExt',
      desc: '',
      args: [],
    );
  }

  /// `files`
  String get viewFiles {
    return Intl.message(
      'files',
      name: 'viewFiles',
      desc: '',
      args: [],
    );
  }

  /// `file management`
  String get fileManagement {
    return Intl.message(
      'file management',
      name: 'fileManagement',
      desc: '',
      args: [],
    );
  }

  /// `manage your files`
  String get manageFiles {
    return Intl.message(
      'manage your files',
      name: 'manageFiles',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this view?`
  String get warningDeleteView {
    return Intl.message(
      'Are you sure you want to delete this view?',
      name: 'warningDeleteView',
      desc: '',
      args: [],
    );
  }

  /// `View successfully deleted.`
  String get deleteViewSnackSuccess {
    return Intl.message(
      'View successfully deleted.',
      name: 'deleteViewSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting. Please try again.`
  String get deleteViewSnackError {
    return Intl.message(
      'An error occurred while deleting. Please try again.',
      name: 'deleteViewSnackError',
      desc: '',
      args: [],
    );
  }

  /// `View {view}'s files`
  String viewFilesName(Object view) {
    return Intl.message(
      'View $view\'s files',
      name: 'viewFilesName',
      desc: '',
      args: [view],
    );
  }

  /// `Create a new event`
  String get createEvent {
    return Intl.message(
      'Create a new event',
      name: 'createEvent',
      desc: '',
      args: [],
    );
  }

  /// `Edit {event}`
  String editEvent(Object event) {
    return Intl.message(
      'Edit $event',
      name: 'editEvent',
      desc: '',
      args: [event],
    );
  }

  /// `Event successfully added.`
  String get addEventSnackSuccess {
    return Intl.message(
      'Event successfully added.',
      name: 'addEventSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The modification cannot be executed due to conflicts with the following events: \n {data}`
  String addEventConflicts(Object data) {
    return Intl.message(
      'The modification cannot be executed due to conflicts with the following events: \n $data',
      name: 'addEventConflicts',
      desc: '',
      args: [data],
    );
  }

  /// `Event successfully modified.`
  String get editEventSnackSuccess {
    return Intl.message(
      'Event successfully modified.',
      name: 'editEventSnackSuccess',
      desc: '',
      args: [],
    );
  }

  /// `standard mode`
  String get standardMode {
    return Intl.message(
      'standard mode',
      name: 'standardMode',
      desc: '',
      args: [],
    );
  }

  /// `recurrent mode`
  String get recurrentMode {
    return Intl.message(
      'recurrent mode',
      name: 'recurrentMode',
      desc: '',
      args: [],
    );
  }

  /// `file(s)`
  String get files {
    return Intl.message(
      'file(s)',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Minutes field : `
  String get minuteField {
    return Intl.message(
      'Minutes field : ',
      name: 'minuteField',
      desc: '',
      args: [],
    );
  }

  /// `Seconds field : `
  String get secondField {
    return Intl.message(
      'Seconds field : ',
      name: 'secondField',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Current casts`
  String get currentLives {
    return Intl.message(
      'Current casts',
      name: 'currentLives',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'messages'),
      Locale.fromSubtags(languageCode: 'nl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<CustomLocalizations> load(Locale locale) =>
      CustomLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
