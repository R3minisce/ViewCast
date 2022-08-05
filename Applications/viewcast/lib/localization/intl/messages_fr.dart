// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(data) =>
      "La modification ne peut pas être exécutée dûe à des conflits avec les événements suivants: \n ${data}";

  static String m1(label) => "Evénements de ${label}";

  static String m2(label) => "Groupes de ${label}";

  static String m3(label) => "Modifier le label de ${label}";

  static String m4(event) => "Modifier ${event}";

  static String m5(label) => "Modifier le groupe ${label}";

  static String m6(username) => "Modifier le profil de ${username}";

  static String m7(label) => "Modifier ${label}";

  static String m9(label) => "Ecrans de ${label}";

  static String m10(max) => "La valeur doit être inférieure ou égale à ${max}";

  static String m11(maxLength) =>
      "La valeur doit avoir une longueur inférieure ou égale à ${maxLength}";

  static String m12(min) => "La valeur doit être supérieure ou égale à ${min}.";

  static String m13(minLength) =>
      "La valeur doit avoir une longueur supérieure ou égale à ${minLength}";

  static String m15(username) => "${username} doit-il être administrateur ?";

  static String m16(username) => "Les groupes de ${username}";

  static String m17(view) => "Les fichiers de ${view}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCastSnackError":
            MessageLookupByLibrary.simpleMessage("Ce label est déjà utilisé."),
        "addCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast ajouté avec succès."),
        "addDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Label de l\'écran déjà utilisé."),
        "addDisplaySnackSucess":
            MessageLookupByLibrary.simpleMessage("Ecran créé avec succès."),
        "addEventConflicts": m0,
        "addEventSnackError":
            MessageLookupByLibrary.simpleMessage("Label déjà utilisé."),
        "addEventSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Evénement modifié avec succès."),
        "addGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Label du groupe déjà utilisé."),
        "addGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Groupe ajouté avec succès."),
        "addUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Nom d\'utilisateur déjà utilisé."),
        "addUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Utilisateur ajouté avec succès."),
        "addViewSnackError":
            MessageLookupByLibrary.simpleMessage("Label déjà utilisé."),
        "addViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View ajoutée avec succès."),
        "adminPanel":
            MessageLookupByLibrary.simpleMessage("panneau d\'administration"),
        "cancel": MessageLookupByLibrary.simpleMessage("annuler"),
        "cannotBeZERO": MessageLookupByLibrary.simpleMessage(
            "Les 2 valeurs ne peuvent être 0."),
        "cannotHappenBefore": MessageLookupByLibrary.simpleMessage(
            "L\'heure de démarrage doit se produire avant l\'heure de fin."),
        "castEvents": m1,
        "castGroups": m2,
        "castLabel": MessageLookupByLibrary.simpleMessage("label du cast"),
        "castRowEvents": MessageLookupByLibrary.simpleMessage("événements"),
        "castRowGroups": MessageLookupByLibrary.simpleMessage("groupes"),
        "castRowLabel": MessageLookupByLibrary.simpleMessage("label du cast"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("confirmer mot de passe"),
        "connect": MessageLookupByLibrary.simpleMessage("se connecter"),
        "connectDisplay":
            MessageLookupByLibrary.simpleMessage("connecter un écran"),
        "connectSnackError":
            MessageLookupByLibrary.simpleMessage("Label de l\'écran invalide."),
        "copyEventSnackSucess": MessageLookupByLibrary.simpleMessage(
            "Evénement copié avec succès."),
        "create": MessageLookupByLibrary.simpleMessage("Créer"),
        "createCast":
            MessageLookupByLibrary.simpleMessage("Créer un nouveau cast"),
        "createDisplay":
            MessageLookupByLibrary.simpleMessage("Créer un nouvel écran"),
        "createEvent":
            MessageLookupByLibrary.simpleMessage("Créer un événement"),
        "createGroup":
            MessageLookupByLibrary.simpleMessage("Créer un nouveau groupe"),
        "createUser":
            MessageLookupByLibrary.simpleMessage("Créer un nouvel utilisateur"),
        "createView":
            MessageLookupByLibrary.simpleMessage("Créer une nouvelle view"),
        "creationDate":
            MessageLookupByLibrary.simpleMessage("date de création"),
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite un numéro de carte de crédit valide."),
        "currentLives": MessageLookupByLibrary.simpleMessage("Casts en cours"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une chaîne de date valide."),
        "delete": MessageLookupByLibrary.simpleMessage("supprimer"),
        "deleteDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur s\'est produite lors de la suppression. Veuillez réessayer plus tard."),
        "deleteDisplaySnackSuccess":
            MessageLookupByLibrary.simpleMessage("Ecran supprimé avec succès."),
        "deleteEventSnackSucess": MessageLookupByLibrary.simpleMessage(
            "Evénement supprimé avec succès."),
        "deleteFileSnackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur est survenue pendant la suppression. Veuillez réessayer plus tard."),
        "deleteFileSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Fichier supprimé avec succès."),
        "deleteGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur s\'est produite lors de la suppression. Veuillez réessayer plus tard."),
        "deleteGroupSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Groupe supprimé avec succès."),
        "deleteUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur est survenue pendant la suppression. Veuillez réessayer plus tard."),
        "deleteUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Utilisateur supprimé avec succès."),
        "deleteViewSnackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur est survenue pendant la suppression. Veuillez réessayer plus tard."),
        "deleteViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View supprimée avec succès."),
        "displayName":
            MessageLookupByLibrary.simpleMessage("label de l\'écran"),
        "edit": MessageLookupByLibrary.simpleMessage("Modifier"),
        "editCastSnackError":
            MessageLookupByLibrary.simpleMessage("Ce label est déjà utilisé."),
        "editCastSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Cast modifié avec succès."),
        "editDisplay": m3,
        "editDisplaySnackError": MessageLookupByLibrary.simpleMessage(
            "Label de l\'écran déjà utilisé."),
        "editDisplaySnackSucess":
            MessageLookupByLibrary.simpleMessage("Ecran modifié avec succès."),
        "editEvent": m4,
        "editEventSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Evénement modifié avec succès."),
        "editGroup": m5,
        "editGroupSnackError": MessageLookupByLibrary.simpleMessage(
            "Label du groupe déjà utilisé."),
        "editGroupSnackSuccess":
            MessageLookupByLibrary.simpleMessage("Group successfully edited."),
        "editUser": m6,
        "editUserSnackError": MessageLookupByLibrary.simpleMessage(
            "Nom d\'utilisateur déjà utilisé."),
        "editUserSnackSuccess": MessageLookupByLibrary.simpleMessage(
            "Utilisateur modifié avec succès."),
        "editView": m7,
        "editViewSnackError":
            MessageLookupByLibrary.simpleMessage("Label déjà utilisé."),
        "editViewSnackSuccess":
            MessageLookupByLibrary.simpleMessage("View modifiée avec succès."),
        "email": MessageLookupByLibrary.simpleMessage("email"),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse e-mail valide."),
        "error": MessageLookupByLibrary.simpleMessage(
            "Une erreur s\'est produite. Veuillez réessayer plus tard."),
        "eventDate": MessageLookupByLibrary.simpleMessage("date"),
        "eventDays": MessageLookupByLibrary.simpleMessage("jours"),
        "eventEndHour": MessageLookupByLibrary.simpleMessage("heure de fin"),
        "eventFreq": MessageLookupByLibrary.simpleMessage("fréquence (s)"),
        "eventLabel":
            MessageLookupByLibrary.simpleMessage("label de l\'événement"),
        "eventListEmpty": MessageLookupByLibrary.simpleMessage(
            "La liste est vide. Ajoutez d\'abord des événements."),
        "eventName":
            MessageLookupByLibrary.simpleMessage("label de l\'événement"),
        "eventStartHour":
            MessageLookupByLibrary.simpleMessage("heure de démarrage"),
        "eventView": MessageLookupByLibrary.simpleMessage("view"),
        "fileManagement":
            MessageLookupByLibrary.simpleMessage("Gestion des fichiers"),
        "fileSizeExt": MessageLookupByLibrary.simpleMessage(
            "Les fichiers doivent faire moins de 4MB et avoir une des extensions suivantes:.jpg, .png, .jpeg, .gif."),
        "files": MessageLookupByLibrary.simpleMessage("fichier(s)"),
        "forgottenPassword":
            MessageLookupByLibrary.simpleMessage("mot de passe oublié ?"),
        "frequency": MessageLookupByLibrary.simpleMessage("Fréquence : "),
        "friday": MessageLookupByLibrary.simpleMessage("Vendredi"),
        "generatePass":
            MessageLookupByLibrary.simpleMessage("générer mot de passe"),
        "groupDisplayName": m9,
        "groupDisplays": MessageLookupByLibrary.simpleMessage("écrans"),
        "groupLabel": MessageLookupByLibrary.simpleMessage("label du groupe"),
        "groupListEmpty": MessageLookupByLibrary.simpleMessage(
            "La liste est vide. Ajoutez d\'abord des groupes."),
        "groupName": MessageLookupByLibrary.simpleMessage("label du groupe"),
        "invalidAuth": MessageLookupByLibrary.simpleMessage(
            "Nom d\'utilisateur ou mot de passe invalide."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse IP valide."),
        "leave": MessageLookupByLibrary.simpleMessage("quittez"),
        "manageFiles":
            MessageLookupByLibrary.simpleMessage("Gérer vos fichiers"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "La valeur ne correspond pas au modèle."),
        "maxErrorText": m10,
        "maxLengthErrorText": m11,
        "minErrorText": m12,
        "minLengthErrorText": m13,
        "minuteField":
            MessageLookupByLibrary.simpleMessage("Champs des minutes : "),
        "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
        "monday": MessageLookupByLibrary.simpleMessage("Lundi"),
        "mustBeAuth": MessageLookupByLibrary.simpleMessage(
            "Vous devez être connecté pour voir cette page."),
        "navCasts": MessageLookupByLibrary.simpleMessage("casts"),
        "navDashboard": MessageLookupByLibrary.simpleMessage("tableau de bord"),
        "navDisconnect": MessageLookupByLibrary.simpleMessage("se déconnecter"),
        "navDisplays": MessageLookupByLibrary.simpleMessage("écrans"),
        "navEvents": MessageLookupByLibrary.simpleMessage("événements"),
        "navGroups": MessageLookupByLibrary.simpleMessage("groupes"),
        "navLives": MessageLookupByLibrary.simpleMessage("directs"),
        "navUsers": MessageLookupByLibrary.simpleMessage("utilisateurs"),
        "navViews": MessageLookupByLibrary.simpleMessage("views"),
        "noDisplay": MessageLookupByLibrary.simpleMessage("Aucun écran !"),
        "noName": MessageLookupByLibrary.simpleMessage(
            "Aucun label n\'a été donné !"),
        "notEnoughPerms": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas les permissions nécessaires pour accéder à cette page."),
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "La valeur doit être numérique."),
        "password": MessageLookupByLibrary.simpleMessage("mot de passe"),
        "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe ne sont pas identiques."),
        "powered": MessageLookupByLibrary.simpleMessage("Réalisé par RLR"),
        "recurrentMode": MessageLookupByLibrary.simpleMessage("mode récurrent"),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ ne peut pas être vide."),
        "returnToAuth": MessageLookupByLibrary.simpleMessage(
            "aller à la page d\'authentification"),
        "saturday": MessageLookupByLibrary.simpleMessage("Samedi"),
        "search": MessageLookupByLibrary.simpleMessage("recherche"),
        "secondField":
            MessageLookupByLibrary.simpleMessage("Champs des secondes : "),
        "seconds": MessageLookupByLibrary.simpleMessage("secondes"),
        "selectEndDate": MessageLookupByLibrary.simpleMessage(
            "sélectionner les paramètres pour la date de fin"),
        "selectEvent":
            MessageLookupByLibrary.simpleMessage("Sélection d\'événements"),
        "selectGroup":
            MessageLookupByLibrary.simpleMessage("Sélection des groupes"),
        "selectStartDate": MessageLookupByLibrary.simpleMessage(
            "sélectionner les paramètres pour la date de démarrage"),
        "selectView":
            MessageLookupByLibrary.simpleMessage("sélectionner une view"),
        "shouldBeAdmin": MessageLookupByLibrary.simpleMessage(
            "L\'utilisateur doit-il être administrateur ?"),
        "shouldBeAdminName": m15,
        "signIn": MessageLookupByLibrary.simpleMessage("se connecter"),
        "snackError": MessageLookupByLibrary.simpleMessage(
            "Une erreur s\'est produite. Veuillez réessayer plus tard."),
        "snackSuccessCast":
            MessageLookupByLibrary.simpleMessage("Cast supprimé avec succès."),
        "standardMode": MessageLookupByLibrary.simpleMessage("mode standard"),
        "sunday": MessageLookupByLibrary.simpleMessage("Dimanche"),
        "thursday": MessageLookupByLibrary.simpleMessage("Jeudi"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Mardi"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Ce champ nécessite une adresse URL valide."),
        "userAdmin": MessageLookupByLibrary.simpleMessage("administrateur"),
        "userGroups": MessageLookupByLibrary.simpleMessage("groupes"),
        "userGroupsName": m16,
        "username": MessageLookupByLibrary.simpleMessage("nom d\'utilisateur"),
        "validate": MessageLookupByLibrary.simpleMessage("valider"),
        "viewFiles": MessageLookupByLibrary.simpleMessage("fichiers"),
        "viewFilesName": m17,
        "viewName": MessageLookupByLibrary.simpleMessage("label de la view"),
        "waiting": MessageLookupByLibrary.simpleMessage(
            "En attente du prochain cast..."),
        "warning": MessageLookupByLibrary.simpleMessage("Attention !"),
        "warningCast": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer ce cast ?"),
        "warningDeleteDisplay": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer cet écran ?"),
        "warningDeleteEvent": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer cet événement ?"),
        "warningDeleteFile": MessageLookupByLibrary.simpleMessage(
            "Êtes-vous sûr de vouloir supprimer ce fichier ?"),
        "warningDeleteGroup": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer cet événement ?"),
        "warningDeleteUser": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer cet utilisateur ?"),
        "warningDeleteView": MessageLookupByLibrary.simpleMessage(
            "Êtes-vous sûr de vouloir supprimer cette view ?"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Mercredi")
      };
}
