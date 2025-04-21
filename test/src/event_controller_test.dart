import 'package:calendar_view/calendar_view.dart';
import 'package:calendar_view/src/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('event controller ...', (tester) async {
    final controller = EventController();

    final now = DateTime.now();
    controller.add(CalendarEventData<String>(
        title: 'none',
        date: now,
        category: Category(name: 'Default Category', id: '', color: Colors.blue),
        startTime: now,
        endTime: now.add(Duration(hours: 1))),);
    controller.add(CalendarEventData<String>(
      title: 'All Day',
      date: DateTime.now().withoutTime,
      category: Category(name: 'Default Category', id: '', color: Colors.blue)
    ));

    expect(controller.getFullDayEvent(now).length, equals(1));
    expect(controller.getEventsOnDay(now).length, equals(2));
    expect(controller.allEvents.length, equals(2));
    controller.clear();
    expect(controller.allEvents.length, equals(0));
  });
}
