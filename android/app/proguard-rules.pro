# Keep Ably SDK classes and models (referenced via reflection)
-keep class io.ably.** { *; }
-dontwarn io.ably.**

# Lombok annotations/classes are not present at runtime; ignore missing
-dontwarn lombok.**

# Keep annotations (general safety)
-keepattributes *Annotation*

# Keep Firebase/Play services models when used via reflection (defensive)
-dontwarn com.google.errorprone.annotations.**
-dontwarn org.checkerframework.**

# Kotlin metadata
-keepclassmembers class kotlin.Metadata { *; }
-dontwarn kotlin.**

# OkHttp/Okio (common in networking stacks)
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep enums used in switches
-keepclassmembers enum * { **[] $VALUES; public *; }
