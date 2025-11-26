# 🎮 Tic Tac Toe – Flutter AI Project

This repository contains a Flutter Tic Tac Toe game where you play against an AI with multiple difficulty levels (Easy / Medium / Hard).

This README explains:

1. ✅ How to set up Flutter (follow the video).
2. 📥 How to download this project from GitHub.
3. 🧩 How to open the project in Flutter (Android Studio).
4. 📱 How to select/create a device and simulate the app.
5. ▶️ How to run the app on the chosen device.

---

## 1️⃣ Set Up Flutter (Follow the Video)

Before running this project, please **install Flutter and Android Studio** by following this video:

📺 **Video (Flutter + Android Studio setup and run):**  
https://youtu.be/mMeQhLGD-og?si=qE0gvtCaCHo8z6v_

While following the video, make sure you:

- 🧩 Install **Flutter SDK**.
- 🧰 Install **Android Studio** with:
  - Android SDK
  - Platform tools
  - Build tools
- 📱 Set up at least **one Android Virtual Device (AVD)** or be ready to plug in a real Android phone.
- ✅ Confirm everything is okay by running `flutter doctor` as shown in the video.

Once you can run a simple Flutter app (as in the video), you are ready to use **this** project.

---

## 2️⃣ Download This Project from GitHub (ZIP)

1. Go to this project’s GitHub page (the link I submitted).  
2. On the main repository page, click the green **Code** button.
3. In the dropdown, click **Download ZIP**.
4. Save the ZIP file to your computer (e.g. `Downloads`).
5. After downloading, **extract/unzip** the ZIP file:
   - On Windows: Right‑click → **Extract All...** → choose a folder (for example: `C:\Users\YourName\Documents\tic_tac_toe_flutter`).
   - On macOS: Double‑click the ZIP to extract it into a folder.

You now have a **normal folder** on your machine containing the Flutter project.

---

## 3️⃣ Open the Project in Flutter (Android Studio)

Follow this after you have Flutter + Android Studio installed (as in the video).

1. 🚀 Open **Android Studio**.
2. On the welcome screen, click **Open**  
   (or if another project is already open: **File → Open…**).
3. Navigate to the **folder you just extracted** from the ZIP:
   - This is the folder that contains `pubspec.yaml`, `lib/`, `android/`, etc.
4. Select that folder and click **OK / Open**.
5. If Android Studio asks whether to **Trust this project**, click **Trust** ✅.
6. Wait for Android Studio to finish indexing and loading the project.

Now the Flutter project from GitHub is open in Android Studio.

---

## 4️⃣ Get Dependencies (Pub Get)

1. In the **Project** panel, open the file `pubspec.yaml`.
2. At the top‑right of the editor, click **Pub get** (or **Get dependencies**).
3. Wait until it finishes successfully (no errors).

This will download all Flutter packages used by the project (like `audioplayers`).

---

## 5️⃣ Check Assets (Automatically Included)

The project already includes the required assets:

- 🎵 `assets/sounds/click.wav`
- 🎵 `assets/sounds/win.wav`
- 🎨 `assets/images/tic_tac_toe_logo.png`

These are already referenced correctly in `pubspec.yaml`, so **no changes are needed** as long as the project is used as downloaded.

---

## 6️⃣ Choose / Create a Device to Simulate the App

Before running the app, you must select a device to simulate it on (emulator or real phone).

### Use an Android Emulator (AVD)

1. On the **right side panel** in Android Studio, find and click **Device Manager** (phone icon).
2. In Device Manager:
   - Either **select an existing device**, or
   - Click **Create Device** to create a new AVD (e.g. Pixel).
3. After you have a device listed, click the **Play ▶ button** next to the chosen device.
4. Wait for the emulator to boot up (you should see the Android home screen).


## 7️⃣ Select the Preferred Device in the Top Panel

At the **top of Android Studio**, you will see a **device selector dropdown** (usually next to the Run and Debug icons).

1. Click the **device dropdown**.
2. By default, it may be set to something like:
   - `Chrome (web)`  
   - `Windows (desktop)` 
   or another non‑mobile target.
3. Change it to the **Android device/emulator** you want to use, for example:
   - `Pixel 4 API 33` (emulator), or
   - Your phone model name.

✅ Make sure the selected device here matches the emulator/phone you want to simulate the program on.

---

## 8️⃣ Run the Flutter App

Once the device is selected:

1. Ensure `lib/main.dart` is open (the entry point of the app).
2. Look at the top toolbar:
   - You should see a **green Run button ▶** next to the **bug icon** (which is for Debug).
3. **Important:**  
   - First confirm the **running device** (top dropdown) is your **Android emulator or real phone**, **not** website/desktop.
4. Now click the **green Run ▶ button** (next to the bug logo).

Android Studio will:

- Build the Flutter project.
- Install the app on the selected device.
- Launch the app automatically.

---

## 9️⃣ Using the Tic Tac Toe App

Once the app opens on the device:

1. **Welcome / Name Screen** 🎉  
   - Enter your name in the text field.  
   - Tap **Continue**.

2. **Setup Screen** ⚙️  
   - Choose:
     - Difficulty: **Easy**, **Medium**, or **Hard**.
     - Who starts: **You** or **Computer**.
     - Your piece: **X** or **O**.
     - Color styles for X and O.
   - Tap **Start Game**.

3. **Game Screen** 🕹️  
   - Play Tic Tac Toe vs the computer.
   - Scoreboard tracks:
     - Player wins
     - Computer wins
     - Draws
   - A line is animated across three‑in‑a‑row when someone wins.
   - Tap **Restart Game** to reset the board.
   - Tap the **back arrow** to go back to the setup screen.

---

## 🔟 Troubleshooting

- If the app doesn’t run:
  - Re‑check that the **device dropdown** is set to an **Android device**, not Chrome/web/desktop.
  - Make sure the **emulator is running** (you can see the Android home screen).
  - Run **Pub get** again in `pubspec.yaml`.

- If Flutter/Android Studio isn’t set up correctly:
  - Re‑watch and follow the setup video:  
    https://youtu.be/mMeQhLGD-og?si=qE0gvtCaCHo8z6v_
  - Run `flutter doctor` and fix any reported issues as in the video.

