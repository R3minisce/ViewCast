// For API requests

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:viewcast/models/cast.dart';
import 'package:viewcast/models/event.dart';
import 'package:viewcast/services/api_config.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/user_service.dart';

class EventService {
  List<Event> parseEvents(Uint8List responseBody) {
    List<Event> events = [];
    var response = jsonDecode(utf8.decode(responseBody));

    response.forEach(
      (event) {
        Event temp = Event();
        temp.fromJson(event);
        events.add(temp);
      },
    );
    return events;
  }

  Future<List<Event>> getEvents() async {
    var uri = Uri.http("$apiIP:$apiPort", eventEndpoint);

    final response = await Client().get(uri);
    return parseEvents(response.bodyBytes);
  }

  Future<List<Event>> getEventsByUser(String uuid) async {
    var uri = Uri.http("$apiIP:$apiPort", eventEndpoint + "user/$uuid");

    final response = await Client().get(uri);
    return parseEvents(response.bodyBytes);
  }

  Future<List<Event>> getEventsWithoutCast() async {
    var uri = Uri.http("$apiIP:$apiPort", eventEndpoint + "available");

    final response = await Client().get(uri);
    return parseEvents(response.bodyBytes);
  }

  Future<Event> getEvent(int eventId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$eventEndpoint$eventId');
    final response = await Client().get(uri);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Event event = Event();
    event.fromJson(parsed);
    return event;
  }

  static void notifyUpdateEvent(int eventId) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$updateEventEndpoint$eventId');
    Client().get(uri);
  }

  static void notifyDeleteEvent(int eventId) async {
    var uri = Uri.http("$orchIP:$orchPortHttp", '$deleteEventEndpoint$eventId');
    Client().delete(uri);
  }

  static Future<Event?> addEvent(dynamic event) async {
    var uri = Uri.http("$apiIP:$apiPort", eventEndpoint);
    final Response response = await post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event),
    );

    if (response.statusCode != 201) return null;
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    Event eventObj = Event();
    eventObj.fromJson(parsed);
    return eventObj;
  }

  static Future<bool> updateEvent(dynamic event, int id) async {
    var uri = Uri.http("$apiIP:$apiPort", '$eventEndpoint$id');
    final Response response = await put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event),
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  static Future<bool> deleteEvent(int eventId) async {
    var uri = Uri.http("$apiIP:$apiPort", '$eventEndpoint$eventId');
    final Response response = await delete(uri);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    return true;
  }
}

final eventProvider = Provider((ref) => EventService());

final getEventsProvider = FutureProvider.autoDispose<List<Event>>((ref) async {
  ref.watch(refreshEvent);
  final eventService = ref.read(eventProvider);
  return await eventService.getEvents();
});

final getEventsByUserProvider =
    FutureProvider.family.autoDispose<List<Event>, String>((ref, uuid) async {
  ref.watch(refreshEvent);
  final eventService = ref.read(eventProvider);
  return await eventService.getEventsByUser(uuid);
});

final getEventsAvailableProvider =
    FutureProvider.autoDispose<List<Event>>((ref) async {
  ref.watch(refreshEvent);
  final eventService = ref.read(eventProvider);
  return await eventService.getEventsWithoutCast();
});

final getEventProvider =
    FutureProvider.family.autoDispose<Event, int>((ref, idEvent) async {
  final eventService = ref.read(eventProvider);
  return await eventService.getEvent(idEvent);
});

final editEvent = StateProvider<bool>((ref) => false);
final selectedEvent = StateProvider<Event?>((ref) => null);
final refreshEvent = StateProvider<int>((ref) => 0);
final searchEventProvider = StateProvider<String>((ref) => "");

final filteredEvents = FutureProvider.autoDispose<List<Event>>((ref) async {
  final filter = ref.watch(searchEventProvider);
  final user = ref.watch(currentUserProvider).state;
  if (user != null) {
    final events = (user.admin!)
        ? await ref.watch(getEventsProvider.future)
        : await ref.watch(getEventsByUserProvider.call(user.uuid!).future) +
            await ref.watch(getEventsAvailableProvider.future);
    return events
        .where((event) =>
            event.name!.toLowerCase().contains(filter.state.toLowerCase()))
        .toList();
  }
  return [];
});

final filteredAvailableEvents =
    FutureProvider.autoDispose<List<Event>>((ref) async {
  final filter = ref.watch(searchEventProvider);
  List<Event> events = await ref.watch(getEventsAvailableProvider.future);

  final cast = ref.watch(selectedCast);
  if (cast.state != null) {
    Cast castFull =
        await ref.watch(getCastProvider.call(cast.state!.id!).future);
    if (castFull.events!.isEmpty || !events.contains(castFull.events!.first)) {
      events.addAll(castFull.events!.toList());
    }
  }

  return events
      .where((event) =>
          event.name!.toLowerCase().contains(filter.state.toLowerCase()))
      .toList();
});
