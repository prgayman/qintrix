#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <cwchar>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

namespace {

constexpr wchar_t kWindowClassName[] = L"FLUTTER_RUNNER_WIN32_WINDOW";
constexpr wchar_t kWindowTitle[] = L"Qintrix";
constexpr wchar_t kBackgroundLaunchArgument[] = L"--background-launch";

bool IsBackgroundLaunch() {
  const int argc = __argc;
  wchar_t** argv = __wargv;

  for (int index = 1; index < argc; index++) {
    if (wcscmp(argv[index], kBackgroundLaunchArgument) == 0) {
      return true;
    }
  }

  return false;
}

bool FocusExistingInstance() {
  const HWND existing_window = FindWindow(kWindowClassName, kWindowTitle);
  if (existing_window == nullptr) {
    return false;
  }

  if (IsIconic(existing_window)) {
    ShowWindow(existing_window, SW_RESTORE);
  } else {
    ShowWindow(existing_window, SW_SHOW);
  }

  SetForegroundWindow(existing_window);
  return true;
}

}  // namespace

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  if (IsBackgroundLaunch()) {
    if (FindWindow(kWindowClassName, kWindowTitle) != nullptr) {
      return EXIT_SUCCESS;
    }
  } else if (FocusExistingInstance()) {
    return EXIT_SUCCESS;
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1180, 760);
  if (!window.Create(kWindowTitle, origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
