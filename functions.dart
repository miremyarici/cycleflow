import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<DateTime> getCurrentWeekDays() {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return List.generate(7, (i) => monday.add(Duration(days: i)));
}

List<DateTime> findPeriodStartDates(List<DateTime> allPeriodDates) {
  if (allPeriodDates.isEmpty) return [];

  final sorted = List<DateTime>.from(allPeriodDates)..sort();
  List<DateTime> startDates = [sorted.first];

  for (int i = 1; i < sorted.length; i++) {
    final diff = sorted[i].difference(sorted[i - 1]).inDays;
    if (diff > 1) {
      startDates.add(sorted[i]);
    }
  }

  return startDates;
}

int calculateAverageCycleLength(List<DateTime> periodStartDates) {
  if (periodStartDates.length < 2) return 28;

  final sorted = List<DateTime>.from(periodStartDates)..sort();
  List<int> gaps = [];

  for (int i = 1; i < sorted.length; i++) {
    gaps.add(sorted[i].difference(sorted[i - 1]).inDays);
  }

  final validGaps = gaps.where((g) => g >= 15 && g <= 45).toList();
  if (validGaps.isEmpty) return 28;

  final average = validGaps.reduce((a, b) => a + b) / validGaps.length;
  return average.round();
}

int calculateCurrentDay(
  DateTime lastPeriodStart,
  int cycleLength,
) {
  final daysSinceStart = DateTime.now().difference(lastPeriodStart).inDays;
  return (daysSinceStart % cycleLength) + 1;
}

String calculateCurrentPhase(
  int currentDay,
  int periodLength,
) {
  if (currentDay <= periodLength) return 'Menstrual Phase';
  if (currentDay <= 13) return 'Follicular Phase';
  if (currentDay <= 16) return 'Ovulation Phase';
  return 'Luteal Phase';
}

int calculateAveragePeriodLength(List<DateTime> allPeriodDates) {
  if (allPeriodDates.isEmpty) return 5;

  final sorted = List<DateTime>.from(allPeriodDates)..sort();
  List<int> periodLengths = [];
  int currentLength = 1;

  for (int i = 1; i < sorted.length; i++) {
    final diff = sorted[i].difference(sorted[i - 1]).inDays;
    if (diff == 1) {
      currentLength++;
    } else {
      periodLengths.add(currentLength);
      currentLength = 1;
    }
  }
  periodLengths.add(currentLength);

  if (periodLengths.isEmpty) return 5;
  final average = periodLengths.reduce((a, b) => a + b) / periodLengths.length;
  return average.round();
}

double calculateProgress(
  int currentDay,
  int cycleLength,
) {
  if (cycleLength == 0) return 0.0;
  return currentDay / cycleLength;
}

List<String> getEmotionsForPhase(String phase) {
  switch (phase.toLowerCase()) {
    case 'menstrual':
      return ['Tired', 'Sensitive', 'Introspective', 'Low Energy'];
    case 'follicular':
      return ['Energetic', 'Creative', 'Optimistic', 'Motivated'];
    case 'ovulation':
      return ['Confident', 'Social', 'Attractive', 'High Energy'];
    case 'luteal':
      return ['Focused', 'Organized', 'Impatient', 'Sensitive'];
    default:
      return ['Balanced'];
  }
}

bool isPeriodDay(
  DateTime day,
  List<DateTime> periodDates,
) {
  if (periodDates == null) return false;
  for (final d in periodDates) {
    if (d == null) continue;
    if (d.year == day.year && d.month == day.month && d.day == day.day) {
      return true;
    }
  }
  return false;
}

double calculateCycleProgress(
  int currentDay,
  int cycleLength,
) {
  if (cycleLength == null || cycleLength <= 0) return 0.0;
  if (currentDay == null || currentDay <= 0) return 0.0;
  final progress = currentDay / cycleLength;
  if (progress > 1.0) return 1.0;
  return progress;
}

List<String> getActivitiesForPhase(String phase) {
  switch (phase.toLowerCase()) {
    case 'menstrual phase':
      return ['Yoga', 'Light Walking', 'Meditation', 'Reading'];
    case 'follicular phase':
      return ['Hiking', 'Light Cardio', 'Creative Projects', 'Socializing'];
    case 'ovulation phase':
      return ['HIIT', 'Strength Training', 'Public Speaking', 'Dating'];
    case 'luteal phase':
      return ['Pilates', 'Cleaning', 'Planning', 'Steady Cardio'];
    default:
      return ['Walking', 'Stretching'];
  }
}