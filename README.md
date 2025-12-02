### **1. Folder structure and dependancy installation**
```md

<!-- ====== FOLDER STRUCTURE SECTION ====== -->

lib/
│
├── app/
│   ├── app.dart              # Root Flutter app
│   ├── theme.dart            # App-wide theme
│   └── router.dart           # go_router configuration
│
├── features/
│   ├── feed/                 # Infinite scroll news feed
│   │   ├── controllers/
│   │   ├── providers.dart
│   │   ├── data/
│   │   └── presentation/
│   │       ├── feed_page.dart
│   │       └── widgets/
│
│   ├── discover/             # Discover page & widgets
│   │   ├── providers.dart
│   │   └── presentation/
│   │       ├── discover_page.dart
│   │       └── widgets/
│
│   ├── notifications/        # Notifications screen
│   │   └── presentation/
│   │       └── notifications_page.dart
│
│   ├── search/
│   │   └── presentation/search_page.dart
│
│   └── profile/
│       └── presentation/profile_page.dart
│
├── data/
│   └── models/               # Entity models (NewsItemEntity)
│
└── features/shell/           # Bottom nav + swipe container
    ├── home_shell_page.dart
    └── navigation_providers.dart


````
### **1. Install dependencies**

```sh
flutter pub get
````

### **2. Run on connected device/emulator**

```sh
flutter run
```

### **3. Build release APK (to install on phone)**

```sh
flutter build apk --release
```

APK path:

```
build/app/outputs/flutter-apk/app-release.apk
```

Transfer this to mobile → Install → Works offline too.


---

# 🧑‍💻 **How to Add a New Feature**

<div class="section">

### **Step 1: Create feature folder**

Inside `/lib/features/`, create:

```
/your_feature/
   /data
   /providers.dart
   /controllers
   /presentation
       /your_page.dart
       /widgets/
```

### **Step 2: Add route**

In `app/router.dart`:

```dart
GoRoute(
  path: '/your-feature',
  builder: (context, state) => const YourFeaturePage(),
),
```

### **Step 3: Create Riverpod providers**

In `providers.dart`:

```dart
final yourFeatureProvider = StateProvider<int>((ref) => 0);
```

### **Step 4: Add UI screens**

Inside `presentation/your_feature_page.dart`.

### **Step 5: (Optional) Add navigation button**

```dart
context.push('/your-feature');
```

</div>

---

# 🧩 **How Infinite Feed Works**

<div class="section">

* Feed uses:

  * `ListView.builder`
  * `itemExtent = fullScreenHeight`
  * `PageScrollPhysics`
  * `cacheExtent` for memory optimization
* Riverpod triggers:

  * `loadInitial()`
  * `loadMore()`
* Fake infinite generator:

  * cycles template news
  * randomizes layout type
  * random timestamps
  * can swap to real API later

</div>

---

# 🎨 **UI Elements Included**

<div class="section">
✔ Full-screen feed pages  
✔ Photo-dominant news  
✔ Text-dominant news  
✔ Story-style full image  
✔ Gallery slider with animated indicator  
✔ Transparent AppBar  
✔ Discover categories & topics  
✔ Notification cards (Instagram-style grouping)  
✔ Fully swipe-enabled bottom navigation  
</div>

---

# 🤝 **Contributing**

<div class="section">
To add new UI views, follow the feature pattern and keep business logic inside:

* `controllers/`
* `providers.dart`
* `data/models/`

UI should remain “dumb”, logic-free, and reactive via `WidgetRef`.

</div>

---

# 📄 License

MIT or anything you prefer.

---

# 💬 Need More?

I can also generate:

* Screenshots section
* Animated GIFs
* API integration stubs
* Data mocks
* Unit test template
* CI/CD workflow

Just tell me 🚀
