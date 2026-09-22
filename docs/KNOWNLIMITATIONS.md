# KNOWN LIMITATIONS

## The Last Shortcut

**Date:** 2026-09-22

### Environment Limitations

| Limitation | Impact | Workaround |
|------------|--------|------------|
| No Godot in PATH | Must use /tmp/opencode/godot_bin/ | PATH set in .bashrc |
| No graphical Godot session | Cannot test editor launch or interactive gameplay | Status remains NOT TESTED |
| No Android SDK/ADB/Java/Gradle | Cannot build or test an APK | Deferred |
| No desktop export toolchain verified | Cannot verify a desktop package | Deferred |
| No performance measurement | Cannot assess mobile or desktop performance | Deferred |
| Headless mode only | Cannot test interactive gameplay | Documented as NOT TESTED |
| aarch64 architecture | x86_64 Godot binary non-functional | Use arm64 binary |

### Technical Limitations

| Limitation | Impact | Workaround |
|------------|--------|------------|
| .tscn sub_resource parsing issues | Meshes created via script instead | Create resources in _ready() |
| BoxMesh inline in .tscn fails | Vehicle visual created in code | MeshInstance3D created in script |
| Headless dummy-renderer warnings | Rendering diagnostics only; no gameplay conclusion | Graphical test required |
| No interactive testing | All gameplay = NOT TESTED | Will test when environment allows |
| No Android device | Cannot verify mobile performance | Will test when device available |

### Untested Features

- All interactive vehicle movement (acceleration, braking, steering)
- Collision detection in live gameplay
- Barrier destruction and shortcut opening
- Damage application and vehicle health
- Repair station interaction and time penalty
- Timer countdown and warnings
- Delivery success/failure states
- Results screen and score calculation
- Best score persistence across sessions
- Save file corruption handling (code reviewed but not executed)
- Screen-shake toggle functionality
- Window resizing behavior
- Repeated restart stability
- Pause/resume functionality
