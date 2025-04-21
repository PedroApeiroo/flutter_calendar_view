import 'package:calendar_view/calendar_view.dart';
import 'package:calendar_view/src/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const height = 1440.0;
const width = 500.0;
const heightPerMinute = 1.0;
const startHour = 0;

void main() {
  final now = DateTime.now().withoutTime;

  group('MergeEventArrangerTest', () {
    test('Events which does not overlap.', () {
      final events = [
        CalendarEventData(
          title: 'Event 1',
          date: now,
          startTime: now.add(Duration(hours: 1)),
          endTime: now.add(Duration(hours: 2)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 2',
          date: now,
          startTime: now.add(Duration(hours: 2, minutes: 15)),
          endTime: now.add(Duration(hours: 3)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 3',
          date: now,
          startTime: now.add(Duration(hours: 3, minutes: 15)),
          endTime: now.add(Duration(hours: 4)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 4',
          date: now,
          startTime: now.add(Duration(hours: 4, minutes: 15)),
          endTime: now.add(Duration(hours: 5)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, events.length);
    });

    test('Only start time is overlapping', () {
      final events = [
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(Duration(hours: 10)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    test('Only end time is overlapping', () {
      final events = [
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(Duration(hours: 10)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    test('Event1 is smaller than event 2 and overlapping', () {
      final events = [
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(Duration(hours: 14)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    test('Event2 is smaller than event 1 and overlapping', () {
      final events = [
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(Duration(hours: 14)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    test('Both events are of same duration and occurs at the same time', () {
      final events = [
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
        CalendarEventData(
          title: 'Event 5',
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(Duration(hours: 13)),
          category: Category(name: 'Default Category', id: '', color: Colors.blue),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    // Los siguientes grupos siguen igual, actualízalos igual si quieres mantener consistencia
  });
}
