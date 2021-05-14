enum MedicineTime {
  BEFORE_MORNING,
  AFTER_MORNING,
  BEFORE_NOON,
  AFTER_NOON,
  BEFORE_EVENING,
  AFTER_EVENING,
  BEDTIME,
}

String formatTime(int time) {
  return time >= 10 ? "$time" : "0$time";
}
