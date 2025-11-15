### Data Models

Back to README: [../README.md](../README.md)

Models live under `lib/Models/**`. They represent request/response payloads and UI graph data.

### Authentication models

- `lib/Models/Authentication/login_user_response_model.dart`
- `lib/Models/Authentication/create_signicat_session_model.dart`
- `lib/Models/Authentication/create_signicat_token_model.dart`

### Daily Tracker models

- Example paths: `lib/Models/DailyTracker/Bleeding/bleeding_tag_count_model.dart`, `lib/Models/DailyTracker/Mood/mood_model.dart`, etc.

### Insights models

- Graphs and time-of-day representations: `lib/Models/Insights/**`

### Journeys and Ekvipedia

- Course, lessons, and progress: `lib/Models/EkviJourneys/**`, Ekvipedia entries: `lib/Models/Ekvipedia/**`

### Reminders

- Medication/Contraception/Period reminders: `lib/Models/Reminders/**`

### Parsing and equality

- Patterns vary by file; most models use plain Dart classes with typed fields. Where serialization occurs, services often parse JSON using `dart:convert` (see `lib/Network/api_base_helper.dart`).

Evidence of JSON handling:

```149:179:lib/Network/api_base_helper.dart
var jsonResponse;
try { jsonResponse = jsonDecode(response.body); } on FormatException { jsonResponse = response.body; }
switch (response.statusCode) { case 200: return jsonResponse; /* ... */ }
```

### Example payload mapping

- Endpoint constants in `lib/Network/api_links.dart` describe resource paths for each feature. Services under `lib/Services/**` call these URLs and translate responses to models.

### Missing info

- Individual field lists and validation logic per model file are extensive; refer to each file under `lib/Models/**` for exact structures.
