# KNOWN LIMITATIONS

## The Last Shortcut

**Date:** 2026-09-22

### Environment Limitations

| Limitation | Impact | Workaround |
|------------|--------|------------|
| No Godot in PATH | Must use /tmp/opencode/godot_bin/ | PATH set in .bashrc |
| No Android SDK | Cannot build APK | Deferred to Milestone 10 |
| No Java/Gradle | Cannot build Android | Deferred to Milestone 10 |
| No .NET/Mono | Cannot build desktop export | Deferred to Milestone 10 |
| Headless mode only | Cannot test interactive gameplay | Documented as NOT TESTED |
| aarch64 architecture | x86_64 Godot binary non-functional | Use arm64 binary |

### Technical Limitations

| Limitation | Impact | Workaround |
|------------|--------|------------|
| .tscn sub_resource parsing issues | Meshes created via script instead | Create resources in _ready() |
| BoxMesh inline in .tscn fails | Vehicle visual created in code | MeshInstance3D created in script |
| Headless mode mesh errors | Non-blocking warnings only | Does not affect gameplay logic |
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
