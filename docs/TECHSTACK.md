# TECH STACK

## The Last Shortcut

**Date:** 2026-09-22

### Engine

| Item | Value |
|------|-------|
| Engine | Godot 4.3 |
| Version | 4.3.stable.official.77dcf97d8 |
| Binary | Godot_v4.3-stable_linux.arm64 |
| Renderer | GL Compatibility (Mobile) |
| Scripting | GDScript (typed where practical) |

### Platform Targets

| Platform | Status |
|----------|--------|
| Android (primary) | NOT TESTED - no Android SDK or device available |
| Desktop (secondary) | NOT TESTED - no .NET/Mono build tools available |

### Project Configuration

| Setting | Value |
|---------|-------|
| Main scene | res://scenes/main/main.tscn |
| Rendering method | gl_compatibility |
| Rendering method (mobile) | gl_compatibility |
| Window width | 1280 |
| Window height | 720 |
| Stretch mode | canvas_items |
| Stretch aspect | expand |
| Orientation | Sensor landscape |
| VRAM compression | ETC2/ASTC |

### Input Map

| Action | Physical Key 1 | Physical Key 2 |
|--------|---------------|---------------|
| accelerate | Key.W (16777237) | Key.UP (1073742049) |
| brake | Key.S (16777236) | Key.DOWN (1073742048) |
| steer_left | Key.A (16777234) | Key.LEFT (16777235) |
| steer_right | Key.D (16777235) | Key.RIGHT (16777234) |
| restart | Key.R (82) | - |
| pause | Key.ESCAPE (4194305) | - |

### Dependencies

None. No external plugins or dependencies used.
