// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../calendar_view.dart';

@immutable

/// {@macro calendar_event_data_doc}
class CalendarEventData<T extends Object?> {
  /// Specifies date on which all these events are.
  final DateTime date;

  /// Defines the start time of the event.
  /// [endTime] and [startTime] will defines time on same day.
  /// This is required when you are using [CalendarEventData] for [DayView] or [WeekView]
  final DateTime? startTime;

  /// Defines the end time of the event.
  /// [endTime] and [startTime] defines time on same day.
  /// This is required when you are using [CalendarEventData] for [DayView]
  final DateTime? endTime;

  /// Title of the event.
  final String title;

  /// Description of the event.
  final String? description;

  /// Ubication of the event.
  final String? ubication;

  /// Category of the event.
  final Category? category;

  /// Reminder for the event.
  final String? reminder;

  /// Defines if the event should repeat.
  final bool repeat;

  /// Defines the active repeater type (e.g., daily, weekly, monthly).
  final int activeRepeater;

  /// Defines the active weekdays for weekly repetition.
  final List<int>? activeWeekDays;

  /// Defines color of event.
  /// This color will be used in default widgets provided by plugin.
  final Color color;

  /// Event on [date].
  final T? event;

  final DateTime? _endDate;

  /// Define style of title.
  final TextStyle? titleStyle;

  /// Define style of description.
  final TextStyle? descriptionStyle;

  /// Define reoccurrence settings
  final RecurrenceSettings? recurrenceSettings;

  /// Id of the event
  final String id;

  /// {@macro calendar_event_data_doc}
  CalendarEventData({
    required this.id,
    required this.title,
    required DateTime date,
    this.description,
    this.ubication,
    required this.category,
    this.reminder,
    this.repeat = false,
    this.activeRepeater = 0,
    this.activeWeekDays,
    this.event,
    this.color = Colors.blue,
    this.startTime,
    this.endTime,
    this.titleStyle,
    this.descriptionStyle,
    this.recurrenceSettings,
    DateTime? endDate,
  })  : _endDate = endDate?.withoutTime,
        date = date.withoutTime;

  DateTime get endDate => _endDate ?? date;

  /// If this flag returns true that means event is occurring on multiple
  /// days and is not a full day event.
  ///
  bool get isRangingEvent {
    final diff = endDate.withoutTime.difference(date.withoutTime).inDays;

    return diff > 0 && !isFullDayEvent;
  }

  /// Returns if the events is full day event or not.
  ///
  /// If it returns true that means the events is full day. but also it can
  /// span across multiple days.
  ///
  bool get isFullDayEvent {
    return (startTime == null ||
        endTime == null ||
        (startTime!.isDayStart && endTime!.isDayStart));
  }

  bool get isRecurringEvent {
    return recurrenceSettings != null &&
        recurrenceSettings!.frequency != RepeatFrequency.doNotRepeat;
  }

  Duration get duration {
    if (isFullDayEvent) return Duration(days: 1);

    final now = DateTime.now();

    final end = now.copyFromMinutes(endTime!.getTotalMinutes);
    final start = now.copyFromMinutes(startTime!.getTotalMinutes);

    if (end.isDayStart) {
      final difference =
          end.add(Duration(days: 1) - Duration(seconds: 1)).difference(start);

      return difference + Duration(seconds: 1);
    } else {
      return end.difference(start);
    }
  }

  /// Returns a boolean that defines whether current event is occurring on
  /// [currentDate] or not.
  ///
  bool occursOnDate(DateTime currentDate) {
    return currentDate == date ||
        currentDate == endDate ||
        (currentDate.isBefore(endDate.withoutTime) &&
            currentDate.isAfter(date.withoutTime));
  }

  /// Returns event data in [Map<String, dynamic>] format.
  ///
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "event": event,
        "title": title,
        "description": description,
        "ubication": ubication,
        "category": category,
        "reminder": reminder,
        "repeat": repeat,
        "activeRepeater": activeRepeater,
        "activeWeekDays": activeWeekDays,
        "endDate": endDate,
        "recurrenceSettings": recurrenceSettings,
      };

  /// Returns new object of [CalendarEventData] with the updated values defined
  /// as the arguments.
  ///
  CalendarEventData<T> copyWith({
    String? id,
    String? title,
    String? description,
    String? ubication,
    Category? category,
    String? reminder,
    bool? repeat,
    int? activeRepeater,
    List<int>? activeWeekDays,
    T? event,
    Color? color,
    DateTime? startTime,
    DateTime? endTime,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    DateTime? endDate,
    DateTime? date,
    RecurrenceSettings? recurrenceSettings,
  }) {
    return CalendarEventData(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      description: description ?? this.description,
      ubication: ubication ?? this.ubication,
      category: category ?? this.category,
      reminder: reminder ?? this.reminder,
      repeat: repeat ?? this.repeat,
      activeRepeater: activeRepeater ?? this.activeRepeater,
      activeWeekDays: activeWeekDays ?? this.activeWeekDays,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      endDate: endDate ?? this.endDate,
      event: event ?? this.event,
      titleStyle: titleStyle ?? this.titleStyle,
      recurrenceSettings: recurrenceSettings ?? this.recurrenceSettings,
    );
  }

  @override
  String toString() => '${toJson()}';

  @override
  bool operator ==(Object other) {
    return other is CalendarEventData<T> &&
        date.compareWithoutTime(other.date) &&
        endDate.compareWithoutTime(other.endDate) &&
        ((event == null && other.event == null) ||
            (event != null && other.event != null && event == other.event)) &&
        ((startTime == null && other.startTime == null) ||
            (startTime != null &&
                other.startTime != null &&
                startTime!.hasSameTimeAs(other.startTime!))) &&
        ((endTime == null && other.endTime == null) ||
            (endTime != null &&
                other.endTime != null &&
                endTime!.hasSameTimeAs(other.endTime!))) &&
        title == other.title &&
        color == other.color &&
        titleStyle == other.titleStyle &&
        descriptionStyle == other.descriptionStyle &&
        description == other.description &&
        ubication == other.ubication &&
        category == other.category &&
        reminder == other.reminder &&
        repeat == other.repeat &&
        activeRepeater == other.activeRepeater &&
        _listEquals(activeWeekDays, other.activeWeekDays);
  }

  // Helper function to compare two lists
  bool _listEquals<E>(List<E>? a, List<E>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null || a.length != b.length) return false;
    if (a.isEmpty) return true;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      ubication.hashCode ^
      category.hashCode ^
      reminder.hashCode ^
      repeat.hashCode ^
      activeRepeater.hashCode ^
      activeWeekDays.hashCode ^
      descriptionStyle.hashCode ^
      titleStyle.hashCode ^
      color.hashCode ^
      title.hashCode ^
      date.hashCode;
}

/// {@template calendar_event_data_doc}
/// Stores all the events on [date].
///
/// If [startTime] and [endTime] both are 0 or either of them is null, then
/// event will be considered a full day event.
///
/// - [date] and [endDate] are used to define dates only. So, If you
/// are providing any time information with these two arguments,
/// it will be ignored.
///
/// - [startTime] and [endTime] are used to define the time span of the event.
/// So, If you are providing any day information (year, month, day), it will
/// be ignored. It will also, consider only hour and minutes as time. So,
/// seconds, milliseconds and microseconds will be ignored as well.
///
/// - [startTime] and [endTime] can not span more then one day. For example,
/// If start time is 11th Nov 11:30 PM and end time is 12th Nov 1:30 AM, it
/// will not be considered as valid time. Because for [startTime] and [endTime],
/// day will be ignored so, 11:30 PM ([startTime]) occurs after
/// 1:30 AM ([endTime]). Events with invalid time will throw
/// [AssertionError] in debug mode and will be ignored in release mode
/// in [DayView] and [WeekView].
/// {@endtemplate}
