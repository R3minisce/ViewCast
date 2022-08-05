// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(data) =>
      "The modification cannot be executed due to conflicts with the following events: \n ${data}";

  static String m1(label) => "${label}\'s events";

  static String m2(label) => "${label}\'s groups";

  static String m3(label) => "Edit ${label}\'s label";

  static String m4(event) => "Edit ${event}";

  static String m5(label) => "Edit ${label} group";

  static String m6(username) => "Edit ${username}\'s profile";

  static String m7(label) => "Edit ${label}";

  static String m8(value) => "This field value must be equal to ${value}.";

  static String m9(label) => "${label}\'s displays";

  static String m10(max) => "Value must be less than or equal to ${max}";

  static String m11(maxLength) =>
      "Value must have a length less than or equal to ${maxLength}";

  static String m12(min) => "Value must be greater than or equal to ${min}.";

  static String m13(minLength) =>
      "Value must have a length greater than or equal to ${minLength}";

  static String m14(value) => "This field value must not be equal to ${value}.";

  static String m15(username) => "Should ${username} be admin ?";

  static String m16(username) => "${username}\'s groups";

  static String m17(view) => "View ${view}\'s files";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCastSnackError":
            MessageLookupByLibrary.simpleMessage("Cast label already used."),
        "addCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast successfully added."),
        "addDisplaySnackError":
            MessageLookupByLibrary.simpleMessage("Display label already used."),
        "addDisplaySnackSucess": MessageLookupByLibrary.simpleMessage(
            "Display successfully created."),
        "addEventConflicts": m0,
        "addEventSnackError":
            MessageLookupByLibrary.simpleMessage("Label already used."),
        "addEventSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Event successfully added."),
        "addGroupSnackError":
            MessageLookupByLibrary.simpleMessage("Group label already used."),
        "addGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Group successfully added."),
        "addUserSnackError":
            MessageLookupByLibrary.simpleMessage("Username already used."),
        "addUserSnackSuccess":
            MessageLookupByLibrary.simpleMessage("User successfully added."),
        "addViewSnackError":
            MessageLookupByLibrary.simpleMessage("Label already used."),
        "addViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View successfully added."),
        "adminPanel": MessageLookupByLibrary.simpleMessage("admin panel"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "cannotBeZERO":
            MessageLookupByLibrary.simpleMessage("Both value cannot be 0."),
        "cannotHappenBefore": MessageLookupByLibrary.simpleMessage(
            "Start time must happen before end time."),
        "castEvents": m1,
        "castGroups": m2,
        "castLabel": MessageLookupByLibrary.simpleMessage("cast label"),
        "castRowEvents": MessageLookupByLibrary.simpleMessage("events"),
        "castRowGroups": MessageLookupByLibrary.simpleMessage("groups"),
        "castRowLabel": MessageLookupByLibrary.simpleMessage("cast label"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("confirm password"),
        "connect": MessageLookupByLibrary.simpleMessage("connect"),
        "connectDisplay":
            MessageLookupByLibrary.simpleMessage("connect display"),
        "connectSnackError":
            MessageLookupByLibrary.simpleMessage("Invalid display label."),
        "copyEventSnackSucess":
            MessageLookupByLibrary.simpleMessage("Event successfully copied."),
        "create": MessageLookupByLibrary.simpleMessage("create"),
        "createCast": MessageLookupByLibrary.simpleMessage("Create a new cast"),
        "createDisplay":
            MessageLookupByLibrary.simpleMessage("Create a new display"),
        "createEvent":
            MessageLookupByLibrary.simpleMessage("Create a new event"),
        "createGroup":
            MessageLookupByLibrary.simpleMessage("Create a new group"),
        "createUser": MessageLookupByLibrary.simpleMessage("Create a new user"),
        "createView": MessageLookupByLibrary.simpleMessage("Create a new view"),
        "creationDate": MessageLookupByLibrary.simpleMessage("creation date"),
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid credit card number."),
        "currentLives": MessageLookupByLibrary.simpleMessage("Current casts"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid date string."),
        "delete": MessageLookupByLibrary.simpleMessage("delete"),
        "deleteDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "deleteDisplaySnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Display successfully deleted."),
        "deleteEventSnackSucess":
            MessageLookupByLibrary.simpleMessage("Event successfully deleted."),
        "deleteFileSnackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "deleteFileSnackSuccess":
            MessageLookupByLibrary.simpleMessage("File deleted successfully."),
        "deleteGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "deleteGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Group successfully deleted."),
        "deleteUserSnackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "deleteUserSnackSuccess":
            MessageLookupByLibrary.simpleMessage("User successfully deleted."),
        "deleteViewSnackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "deleteViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View successfully deleted."),
        "displayName": MessageLookupByLibrary.simpleMessage("display label"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editCastSnackError":
            MessageLookupByLibrary.simpleMessage("Cast label already used."),
        "editCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast successfully edited."),
        "editDisplay": m3,
        "editDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "\'Display label already used."),
        "editDisplaySnackSucess": MessageLookupByLibrary.simpleMessage(
            "Display successfully edited."),
        "editEvent": m4,
        "editEventSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Event successfully modified."),
        "editGroup": m5,
        "editGroupSnackError":
            MessageLookupByLibrary.simpleMessage("Group label already used."),
        "editGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Group successfully edited."),
        "editUser": m6,
        "editUserSnackError":
            MessageLookupByLibrary.simpleMessage("Username already used."),
        "editUserSnackSuccess":
            MessageLookupByLibrary.simpleMessage("User successfully edited."),
        "editView": m7,
        "editViewSnackError":
            MessageLookupByLibrary.simpleMessage("Label already used."),
        "editViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View successfully modified."),
        "email": MessageLookupByLibrary.simpleMessage("email"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid email address."),
        "equalErrorText": m8,
        "error": MessageLookupByLibrary.simpleMessage(
            "An error occurred. Please try again later."),
        "eventDate": MessageLookupByLibrary.simpleMessage("date"),
        "eventDays": MessageLookupByLibrary.simpleMessage("days"),
        "eventEndHour": MessageLookupByLibrary.simpleMessage("ending hour"),
        "eventFreq": MessageLookupByLibrary.simpleMessage("frequency (s)"),
        "eventLabel": MessageLookupByLibrary.simpleMessage("event label"),
        "eventListEmpty": MessageLookupByLibrary.simpleMessage(
            "The list is empty. Try adding some events first."),
        "eventName": MessageLookupByLibrary.simpleMessage("event label"),
        "eventStartHour": MessageLookupByLibrary.simpleMessage("starting hour"),
        "eventView": MessageLookupByLibrary.simpleMessage("view"),
        "fileManagement":
            MessageLookupByLibrary.simpleMessage("file management"),
        "fileSizeExt": MessageLookupByLibrary.simpleMessage(
            "Files must be less than 4MB and have one of the following extensions :.jpg, .png, .jpeg, .gif."),
        "files": MessageLookupByLibrary.simpleMessage("file(s)"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("forgotten password?"),
        "frequency": MessageLookupByLibrary.simpleMessage("Frequency : "),
        "friday": MessageLookupByLibrary.simpleMessage("Friday"),
        "generatePass":
            MessageLookupByLibrary.simpleMessage("generate password"),
        "groupDisplayName": m9,
        "groupDisplays": MessageLookupByLibrary.simpleMessage("displays"),
        "groupLabel": MessageLookupByLibrary.simpleMessage("group label"),
        "groupListEmpty": MessageLookupByLibrary.simpleMessage(
            "The list is empty. Try adding some groups first."),
        "groupName": MessageLookupByLibrary.simpleMessage("group label"),
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid integer."),
        "invalidAuth": MessageLookupByLibrary.simpleMessage(
            "Username or password invalid."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid IP."),
        "leave": MessageLookupByLibrary.simpleMessage("leave"),
        "manageFiles":
            MessageLookupByLibrary.simpleMessage("manage your files"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Value does not match pattern."),
        "maxErrorText": m10,
        "maxLengthErrorText": m11,
        "minErrorText": m12,
        "minLengthErrorText": m13,
        "minuteField": MessageLookupByLibrary.simpleMessage("Minutes field : "),
        "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
        "monday": MessageLookupByLibrary.simpleMessage("Monday"),
        "mustBeAuth": MessageLookupByLibrary.simpleMessage(
            "You must be authenticated to see this page."),
        "navCasts": MessageLookupByLibrary.simpleMessage("casts"),
        "navDashboard": MessageLookupByLibrary.simpleMessage("dashboard"),
        "navDisconnect": MessageLookupByLibrary.simpleMessage("disconnect"),
        "navDisplays": MessageLookupByLibrary.simpleMessage("displays"),
        "navEvents": MessageLookupByLibrary.simpleMessage("events"),
        "navGroups": MessageLookupByLibrary.simpleMessage("groups"),
        "navLives": MessageLookupByLibrary.simpleMessage("lives"),
        "navUsers": MessageLookupByLibrary.simpleMessage("users"),
        "navViews": MessageLookupByLibrary.simpleMessage("views"),
        "noDisplay": MessageLookupByLibrary.simpleMessage("No displays!"),
        "noName": MessageLookupByLibrary.simpleMessage("No label was given!"),
        "notEnoughPerms": MessageLookupByLibrary.simpleMessage(
            "You don\'t have enough permission to see this page."),
        "notEqualErrorText": m14,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Value must be numeric."),
        "password": MessageLookupByLibrary.simpleMessage("password"),
        "passwordNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match."),
        "powered": MessageLookupByLibrary.simpleMessage("Powered by RLR"),
        "recurrentMode": MessageLookupByLibrary.simpleMessage("recurrent mode"),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("This field cannot be empty."),
        "returnToAuth": MessageLookupByLibrary.simpleMessage(
            "return to authentication page"),
        "saturday": MessageLookupByLibrary.simpleMessage("Saturday"),
        "search": MessageLookupByLibrary.simpleMessage("search"),
        "secondField": MessageLookupByLibrary.simpleMessage("Seconds field : "),
        "seconds": MessageLookupByLibrary.simpleMessage("seconds"),
        "selectEndDate":
            MessageLookupByLibrary.simpleMessage("select ending date settings"),
        "selectEvent": MessageLookupByLibrary.simpleMessage("Events selection"),
        "selectGroup": MessageLookupByLibrary.simpleMessage("Groups selection"),
        "selectStartDate": MessageLookupByLibrary.simpleMessage(
            "select starting date settings"),
        "selectView": MessageLookupByLibrary.simpleMessage("select a view"),
        "shouldBeAdmin":
            MessageLookupByLibrary.simpleMessage("Should the user be admin ?"),
        "shouldBeAdminName": m15,
        "signIn": MessageLookupByLibrary.simpleMessage("sign in"),
        "snackError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while deleting. Please try again."),
        "snackSuccessCast":
            MessageLookupByLibrary.simpleMessage("Cast successfully deleted."),
        "standardMode": MessageLookupByLibrary.simpleMessage("standard mode"),
        "sunday": MessageLookupByLibrary.simpleMessage("Sunday"),
        "thursday": MessageLookupByLibrary.simpleMessage("Thursday"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "This field requires a valid URL address."),
        "userAdmin": MessageLookupByLibrary.simpleMessage("admin"),
        "userGroups": MessageLookupByLibrary.simpleMessage("groups"),
        "userGroupsName": m16,
        "username": MessageLookupByLibrary.simpleMessage("username"),
        "validate": MessageLookupByLibrary.simpleMessage("validate"),
        "viewFiles": MessageLookupByLibrary.simpleMessage("files"),
        "viewFilesName": m17,
        "viewName": MessageLookupByLibrary.simpleMessage("view label"),
        "waiting": MessageLookupByLibrary.simpleMessage(
            "Waiting for the next cast..."),
        "warning": MessageLookupByLibrary.simpleMessage("Warning!"),
        "warningCast": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this cast?"),
        "warningDeleteDisplay": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this display?"),
        "warningDeleteEvent": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this event?"),
        "warningDeleteFile": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this file?"),
        "warningDeleteGroup": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this group?"),
        "warningDeleteUser": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this user?"),
        "warningDeleteView": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this view?"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Wednesday")
      };
}
