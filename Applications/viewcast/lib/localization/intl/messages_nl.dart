// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(data) =>
      "De wijziging kan niet worden uitgevoerd wegens conflicten met de volgende gebeurtenissen: \n ${data}";

  static String m1(label) => "${label}\'s gebeurtenissen";

  static String m2(label) => "${label}\'s groepen";

  static String m3(label) => "Bewerk ${label}\'s label";

  static String m4(event) => "Bewerk ${event}";

  static String m5(label) => "Bewerk ${label} groep";

  static String m6(username) => "Wijzig ${username}\'s profiel";

  static String m7(label) => "Bewerk ${label}";

  static String m9(label) => "${label}\'s displays";

  static String m10(max) =>
      "De waarde moet kleiner zijn dan of gelijk aan of gelijk aan ${max}";

  static String m11(maxLength) =>
      "De waarde moet kleiner zijn dan of gelijk aan ${maxLength}";

  static String m12(min) =>
      "De waarde moet groter zijn dan of gelijk aan ${min}.";

  static String m13(minLength) =>
      "De waarde moet een lengte hebben groter dan of gelijk aan ${minLength}";

  static String m15(username) => "Moet ${username} admin zijn ?";

  static String m16(username) => "${username}\'s groepen";

  static String m17(view) => "Bekijk ${view}\'s bestanden";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCastSnackError":
            MessageLookupByLibrary.simpleMessage("Cast label al gebruikt."),
        "addCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast succesvol toegevoegd."),
        "addDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Etiket reeds gebruikt weergeven."),
        "addDisplaySnackSucess":
            MessageLookupByLibrary.simpleMessage("Weergave succesvol gemaakt."),
        "addEventConflicts": m0,
        "addEventSnackError":
            MessageLookupByLibrary.simpleMessage("Etiket al gebruikt."),
        "addEventSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Evenement succesvol toegevoegd."),
        "addGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Groepsetiket reeds gebruikt."),
        "addGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Groep succesvol toegevoegd."),
        "addUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Gebruikersnaam reeds gebruikt."),
        "addUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Gebruiker succesvol toegevoegd."),
        "addViewSnackError":
            MessageLookupByLibrary.simpleMessage("Etiket al gebruikt."),
        "addViewSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Weergave succesvol toegevoegd."),
        "adminPanel": MessageLookupByLibrary.simpleMessage("beheerpaneel"),
        "cancel": MessageLookupByLibrary.simpleMessage("annuleren"),
        "cannotBeZERO": MessageLookupByLibrary.simpleMessage(
            "Beide waarden kunnen niet 0 zijn."),
        "cannotHappenBefore": MessageLookupByLibrary.simpleMessage(
            "De begintijd moet voor de eindtijd liggen."),
        "castEvents": m1,
        "castGroups": m2,
        "castLabel": MessageLookupByLibrary.simpleMessage("gegoten label"),
        "castRowEvents": MessageLookupByLibrary.simpleMessage("evenementen"),
        "castRowGroups": MessageLookupByLibrary.simpleMessage("groepen"),
        "castRowLabel": MessageLookupByLibrary.simpleMessage("gegoten label"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("wachtwoord bevestigen"),
        "connect": MessageLookupByLibrary.simpleMessage("connect"),
        "connectDisplay":
            MessageLookupByLibrary.simpleMessage("display aansluiten"),
        "connectSnackError":
            MessageLookupByLibrary.simpleMessage("Ongeldig display label."),
        "copyEventSnackSucess": MessageLookupByLibrary.simpleMessage(
            "Gebeurtenis succesvol gekopieerd."),
        "create": MessageLookupByLibrary.simpleMessage("maken"),
        "createCast": MessageLookupByLibrary.simpleMessage(
            "Maak een nieuwe rolverdeling"),
        "createDisplay":
            MessageLookupByLibrary.simpleMessage("Maak een nieuw scherm"),
        "createEvent":
            MessageLookupByLibrary.simpleMessage("Maak een nieuwe gebeurtenis"),
        "createGroup":
            MessageLookupByLibrary.simpleMessage("Maak een nieuwe groep"),
        "createUser": MessageLookupByLibrary.simpleMessage(
            "Een nieuwe gebruiker aanmaken"),
        "createView":
            MessageLookupByLibrary.simpleMessage("Maak een nieuw beeld"),
        "creationDate": MessageLookupByLibrary.simpleMessage("aanmaakdatum"),
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geldig kredietkaartnummer."),
        "currentLives":
            MessageLookupByLibrary.simpleMessage("Huidige afgietsels"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geldige datumreeks."),
        "delete": MessageLookupByLibrary.simpleMessage("verwijderen"),
        "deleteDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "deleteDisplaySnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Weergave succesvol verwijderd."),
        "deleteEventSnackSucess": MessageLookupByLibrary.simpleMessage(
            "Gebeurtenis succesvol verwijderd."),
        "deleteFileSnackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "deleteFileSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Bestand succesvol verwijderd."),
        "deleteGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "deleteGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Groep succesvol verwijderd."),
        "deleteUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "deleteUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Gebruiker succesvol verwijderd."),
        "deleteViewSnackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "deleteViewSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Weergave succesvol verwijderd."),
        "displayName": MessageLookupByLibrary.simpleMessage("displaylabel"),
        "edit": MessageLookupByLibrary.simpleMessage("Bewerken"),
        "editCastSnackError":
            MessageLookupByLibrary.simpleMessage("Cast label al gebruikt."),
        "editCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast succesvol bewerkt."),
        "editDisplay": m3,
        "editDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Etiket reeds gebruikt weergeven."),
        "editDisplaySnackSucess": MessageLookupByLibrary.simpleMessage(
            "Weergave succesvol gewijzigd."),
        "editEvent": m4,
        "editEventSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Gebeurtenis succesvol gewijzigd."),
        "editGroup": m5,
        "editGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Groepsetiket reeds gebruikt."),
        "editGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Groep succesvol bewerkt."),
        "editUser": m6,
        "editUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Gebruikersnaam reeds gebruikt."),
        "editUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Gebruiker succesvol bewerkt."),
        "editView": m7,
        "editViewSnackError":
            MessageLookupByLibrary.simpleMessage("Etiket al gebruikt."),
        "editViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Bekijk succesvol gewijzigd."),
        "email": MessageLookupByLibrary.simpleMessage("e-mail"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geldig e-mailadres."),
        "error": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden. Probeer het later nog eens."),
        "eventDate": MessageLookupByLibrary.simpleMessage("datum"),
        "eventDays": MessageLookupByLibrary.simpleMessage("dagen"),
        "eventEndHour": MessageLookupByLibrary.simpleMessage("laatste uur"),
        "eventFreq": MessageLookupByLibrary.simpleMessage("frequentie (s)"),
        "eventLabel": MessageLookupByLibrary.simpleMessage("evenementlabel"),
        "eventListEmpty": MessageLookupByLibrary.simpleMessage(
            "De lijst is leeg. Probeer eerst enkele evenementen toe te voegen."),
        "eventName": MessageLookupByLibrary.simpleMessage("evenementlabel"),
        "eventStartHour": MessageLookupByLibrary.simpleMessage("startuur"),
        "eventView": MessageLookupByLibrary.simpleMessage("view"),
        "fileManagement":
            MessageLookupByLibrary.simpleMessage("bestandsbeheer"),
        "fileSizeExt": MessageLookupByLibrary.simpleMessage(
            "De bestanden moeten kleiner zijn dan 4 MB en een van de volgende extensies hebben: .jpg, .png, .jpeg, .gif."),
        "files": MessageLookupByLibrary.simpleMessage("bestand(en)"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord vergeten?"),
        "frequency": MessageLookupByLibrary.simpleMessage("Frequentie : "),
        "friday": MessageLookupByLibrary.simpleMessage("Vrijdag"),
        "generatePass":
            MessageLookupByLibrary.simpleMessage("wachtwoord genereren"),
        "groupDisplayName": m9,
        "groupDisplays": MessageLookupByLibrary.simpleMessage("displays"),
        "groupLabel": MessageLookupByLibrary.simpleMessage("groepslabel"),
        "groupListEmpty": MessageLookupByLibrary.simpleMessage(
            "De lijst is leeg. Probeer eerst enkele groepen toe te voegen."),
        "groupName": MessageLookupByLibrary.simpleMessage("groepslabel"),
        "invalidAuth": MessageLookupByLibrary.simpleMessage(
            "Gebruikersnaam of wachtwoord ongeldig."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geldig IP-adres."),
        "leave": MessageLookupByLibrary.simpleMessage("vertrekken"),
        "manageFiles":
            MessageLookupByLibrary.simpleMessage("beheer uw bestanden"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "De waarde komt niet overeen met het model."),
        "maxErrorText": m10,
        "maxLengthErrorText": m11,
        "minErrorText": m12,
        "minLengthErrorText": m13,
        "minuteField": MessageLookupByLibrary.simpleMessage("Minutenvelden : "),
        "minutes": MessageLookupByLibrary.simpleMessage("minuten"),
        "monday": MessageLookupByLibrary.simpleMessage("Maandag"),
        "mustBeAuth": MessageLookupByLibrary.simpleMessage(
            "U moet geauthenticeerd zijn om deze pagina te zien."),
        "navCasts": MessageLookupByLibrary.simpleMessage("casts"),
        "navDashboard": MessageLookupByLibrary.simpleMessage("dashboard"),
        "navDisconnect": MessageLookupByLibrary.simpleMessage("loskoppelen"),
        "navDisplays": MessageLookupByLibrary.simpleMessage("displays"),
        "navEvents": MessageLookupByLibrary.simpleMessage("evenementen"),
        "navGroups": MessageLookupByLibrary.simpleMessage("groepen"),
        "navLives": MessageLookupByLibrary.simpleMessage("levens"),
        "navUsers": MessageLookupByLibrary.simpleMessage("gebruikers"),
        "navViews": MessageLookupByLibrary.simpleMessage("views"),
        "noDisplay":
            MessageLookupByLibrary.simpleMessage("Geen beeldschermen!"),
        "noName":
            MessageLookupByLibrary.simpleMessage("Er werd geen label gegeven!"),
        "notEnoughPerms": MessageLookupByLibrary.simpleMessage(
            "Je hebt niet genoeg toestemming om deze pagina te zien."),
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "De waarde moet numeriek zijn."),
        "password": MessageLookupByLibrary.simpleMessage("wachtwoord"),
        "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
            "De wachtwoorden komen niet overeen."),
        "powered": MessageLookupByLibrary.simpleMessage("Aangedreven door RLR"),
        "recurrentMode":
            MessageLookupByLibrary.simpleMessage("terugkerende modus"),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld kan niet leeg zijn."),
        "returnToAuth": MessageLookupByLibrary.simpleMessage(
            "terug naar de authenticatiepagina"),
        "saturday": MessageLookupByLibrary.simpleMessage("Zaterdag"),
        "search": MessageLookupByLibrary.simpleMessage("zoeken"),
        "secondField": MessageLookupByLibrary.simpleMessage("Tweede velden : "),
        "seconds": MessageLookupByLibrary.simpleMessage("seconden"),
        "selectEndDate": MessageLookupByLibrary.simpleMessage(
            "selecteer einddatum instellingen"),
        "selectEvent":
            MessageLookupByLibrary.simpleMessage("Selectie evenementen"),
        "selectGroup": MessageLookupByLibrary.simpleMessage("Groepen selectie"),
        "selectStartDate": MessageLookupByLibrary.simpleMessage(
            "kies begindatum instellingen"),
        "selectView": MessageLookupByLibrary.simpleMessage("een mening kiezen"),
        "shouldBeAdmin": MessageLookupByLibrary.simpleMessage(
            "Moet de gebruiker een admin zijn?"),
        "shouldBeAdminName": m15,
        "signIn": MessageLookupByLibrary.simpleMessage("zich aanmelden"),
        "snackError": MessageLookupByLibrary.simpleMessage(
            "Er is een fout opgetreden tijdens het verwijderen. Gelieve opnieuw te proberen."),
        "snackSuccessCast":
            MessageLookupByLibrary.simpleMessage("Cast succesvol verwijderd."),
        "standardMode": MessageLookupByLibrary.simpleMessage("standaardmodus"),
        "sunday": MessageLookupByLibrary.simpleMessage("Zondag"),
        "thursday": MessageLookupByLibrary.simpleMessage("Donderdag"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Dinsdag"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Dit veld vereist een geldige URL."),
        "userAdmin": MessageLookupByLibrary.simpleMessage("admin"),
        "userGroups": MessageLookupByLibrary.simpleMessage("groepen"),
        "userGroupsName": m16,
        "username": MessageLookupByLibrary.simpleMessage("gebruikersnaam"),
        "validate": MessageLookupByLibrary.simpleMessage("valideren"),
        "viewFiles": MessageLookupByLibrary.simpleMessage("bestanden"),
        "viewFilesName": m17,
        "viewName": MessageLookupByLibrary.simpleMessage("etiket bekijken"),
        "waiting": MessageLookupByLibrary.simpleMessage(
            "Wachtend op de volgende worp..."),
        "warning": MessageLookupByLibrary.simpleMessage("Waarschuwing!"),
        "warningCast": MessageLookupByLibrary.simpleMessage(
            "Weet je zeker dat je deze worp wilt verwijderen?"),
        "warningDeleteDisplay": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u dit scherm wilt verwijderen?"),
        "warningDeleteEvent": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u deze gebeurtenis wilt verwijderen?"),
        "warningDeleteFile": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u dit bestand wilt verwijderen?"),
        "warningDeleteGroup": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u deze groep wilt verwijderen?"),
        "warningDeleteUser": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u deze gebruiker wilt verwijderen?"),
        "warningDeleteView": MessageLookupByLibrary.simpleMessage(
            "Weet u zeker dat u dit uitzicht wilt verwijderen?"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Woensdag")
      };
}
