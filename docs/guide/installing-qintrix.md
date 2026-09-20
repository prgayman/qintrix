# Installing Qintrix

This page gives a client everything needed to install and run Qintrix from source without opening external websites.

Qintrix is a Flutter desktop application. Installation has four parts:

1. prepare the operating system tools
2. install Flutter
3. get the Qintrix project ready
4. run Qintrix and confirm the first launch works

## Before You Start

Make sure you have:

- the Qintrix source code on your machine
- the Flutter SDK archive or an existing Flutter installation available on your machine
- a user account with permission to install software
- internet access for package downloads during setup
- enough disk space for Flutter, build tools, and the Qintrix project

Qintrix can run on:

- macOS
- Windows
- Linux

## Installation Overview

Use this order:

1. install the desktop development tools for your operating system
2. install the Flutter SDK
3. enable Flutter desktop support
4. verify the environment with `flutter doctor`
5. install Qintrix dependencies with `flutter pub get`
6. run the application on your desktop device

## Flutter Version Requirement

Qintrix currently targets a Dart SDK version compatible with:

```txt
Dart SDK ^3.11.1
```

Use a Flutter release that includes Dart 3.11.1 or a compatible newer 3.11.x Dart SDK.

Official Flutter resources:

- [Flutter installation guide](https://docs.flutter.dev/install)
- [Flutter SDK archive](https://docs.flutter.dev/development/tools/sdk/releases)

If Flutter is not already installed on the target machine, download the Flutter SDK from the official Flutter installation page or the Flutter SDK archive before continuing. The Qintrix source package does not include the Flutter SDK itself.

## macOS Setup

Use this section if you are installing Qintrix on macOS.

### 1. Install Xcode

Download Xcode from the official Apple page:

- [Xcode download and information](https://developer.apple.com/xcode)

Install Xcode on the Mac. After installation:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

If the machine asks you to accept the license, complete that step before continuing.

### 2. Install Flutter SDK

Place the Flutter SDK in a permanent folder, for example:

```bash
mkdir -p ~/development
cd ~/development
```

Copy or extract the Flutter SDK into:

```bash
~/development/flutter
```

Then add Flutter to your shell path. If you use `zsh`, add this line to `~/.zshrc`:

```bash
export PATH="$HOME/development/flutter/bin:$PATH"
```

Reload the shell:

```bash
source ~/.zshrc
```

### 3. Enable macOS Desktop Support

Run:

```bash
flutter config --enable-macos-desktop
```

### 4. Verify The Setup

Run:

```bash
flutter doctor
```

Before moving on, make sure Flutter reports that the macOS toolchain is ready or only shows minor optional warnings.

## Windows Setup

Use this section if you are installing Qintrix on Windows.

### 1. Install Visual Studio

Download Visual Studio from the official Microsoft page:

- [Visual Studio downloads](https://visualstudio.microsoft.com/downloads/)

Install Visual Studio with the `Desktop development with C++` workload.

During installation, make sure these Windows build components are available:

- MSVC C++ build tools
- CMake tools for Windows
- Windows 10 SDK or Windows 11 SDK
- the standard C++ toolchain included with the desktop workload

### 2. Install Flutter SDK

Extract the Flutter SDK into a stable folder such as:

```txt
C:\src\flutter
```

Add the Flutter `bin` directory to the system `Path`:

```txt
C:\src\flutter\bin
```

After updating the environment variables, open a new terminal window.

### 3. Enable Windows Desktop Support

Run:

```bash
flutter config --enable-windows-desktop
```

### 4. Verify The Setup

Run:

```bash
flutter doctor
```

Resolve any missing Windows desktop requirements before continuing.

## Linux Setup

Use this section if you are installing Qintrix on Linux.

### 1. Install Build Tools And Desktop Libraries

Install the compiler and desktop packages needed for Flutter Linux builds. The exact package names vary by distribution, but you typically need:

- `clang`
- `cmake`
- `ninja-build`
- `pkg-config`
- GTK 3 development libraries
- standard C++ development libraries

Reference pages:

- [Flutter Linux install guide](https://docs.flutter.dev/install/linux/desktop)

Example for Ubuntu or Debian-based systems:

```bash
sudo apt update
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

Example for Fedora-based systems:

```bash
sudo dnf install -y clang cmake ninja-build pkgconf-pkg-config gtk3-devel xz-devel
```

### 2. Install Flutter SDK

Extract the Flutter SDK into a permanent folder, for example:

```bash
mkdir -p ~/development
cd ~/development
```

Place Flutter in:

```bash
~/development/flutter
```

Add Flutter to your shell path by adding this line to your shell profile such as `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$HOME/development/flutter/bin:$PATH"
```

Reload the shell:

```bash
source ~/.bashrc
```

Use `source ~/.zshrc` instead if you use `zsh`.

### 3. Enable Linux Desktop Support

Run:

```bash
flutter config --enable-linux-desktop
```

### 4. Verify The Setup

Run:

```bash
flutter doctor
```

Fix any missing Linux desktop dependencies before continuing.

## Confirm Flutter Is Ready

No matter which operating system you use, these commands should work before you try to run Qintrix:

```bash
flutter --version
flutter doctor
flutter devices
flutter config --list
```

You are ready for the Qintrix installation steps when:

- `flutter --version` prints the installed version
- `flutter doctor` does not show major blocking errors
- `flutter devices` lists your desktop target
- your desktop platform is enabled

Official desktop setup references:

- [Flutter macOS desktop setup](https://docs.flutter.dev/install/macos/desktop)
- [Flutter Windows desktop setup](https://docs.flutter.dev/install/windows/desktop)
- [Flutter Linux desktop setup](https://docs.flutter.dev/install/linux/desktop)

## Prepare The Qintrix Project

### 1. Open The Project Folder

Move into the Qintrix source code directory:

```bash
cd /path/to/qintrix
```

### 2. Install Project Dependencies

Run:

```bash
flutter pub get
```

This downloads the Dart and Flutter packages required by the project.

### 3. Optional Validation

These commands are useful before the first run:

Check for analyzer issues:

```bash
flutter analyze
```

Run the test suite:

```bash
flutter test
```

## Run Qintrix

Use the command that matches your operating system:

```bash
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

If Flutter already selects the correct desktop device automatically, this also works:

```bash
flutter run
```

## First Launch Checklist

When Qintrix opens for the first time, confirm all of the following:

- the application window opens successfully
- the Dashboard page is visible
- the Server page can be opened
- the local server can be started from the Server page
- the Printers, Apps, Jobs, Logs, and Settings pages are available
- no startup error blocks normal use

On the first launch, Qintrix may also create local settings files and initialize its local data automatically.

## If The App Does Not Start

Use this checklist:

### Flutter command is not found

The Flutter SDK path is not added correctly. Re-check your shell or system `Path` configuration and open a new terminal.

### Desktop device does not appear

Run:

```bash
flutter doctor
flutter devices
```

If the desktop device is missing, the platform tools are not installed correctly or desktop support is not enabled.

### `flutter pub get` fails

Check:

- internet access
- terminal permissions
- whether the project folder path is correct

### Build fails on macOS

Check:

- Xcode is installed
- Xcode command line tools are selected
- the first launch tasks were completed

### Build fails on Windows

Check:

- Visual Studio is installed
- desktop C++ components were included
- the terminal was reopened after changing `Path`

### Build fails on Linux

Check:

- required compiler tools are installed
- GTK development libraries are installed
- the current user can build desktop applications

## Quick Start

If the machine is already prepared, the short version is:

```bash
cd /path/to/qintrix
flutter pub get
flutter run -d macos
```

Replace `macos` with `windows` or `linux` when needed.
