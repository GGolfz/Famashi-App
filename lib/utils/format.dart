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

String? formatTimeTypeToString(int timeType) {
  return {
    0: "Before morning",
    1: "After morning",
    2: "Before noon",
    3: "After noon",
    4: "Before evening",
    5: "After evening",
    6: "Bedtime",
  }[timeType];
}

int? formatTimeTypeToInt(String timeType) {
  return {
    "Before morning": 0,
    "After morning": 1,
    "Before noon": 2,
    "After noon": 3,
    "Before evening": 4,
    "After evening": 5,
    "Bedtime": 6,
  }[timeType];
}
