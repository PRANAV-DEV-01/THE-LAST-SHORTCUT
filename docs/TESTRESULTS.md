# TEST RESULTS

## The Last Shortcut

**Date:** 2026-09-22

### Environment Info

| Item | Value |
|------|-------|
| Godot version | 4.3.stable.official.77dcf97d8 |
| Binary | Godot_v4.3-stable_linux.arm64 |
| Architecture | aarch64 |
| OS | Ubuntu 26.04.1 LTS |
| Renderer | GL Compatibility (headless) |

### Test Results

| Test | Date | Environment | Result | Evidence | Error | Workaround |
|------|------|-------------|--------|----------|-------|------------|
| Fresh launch | 2026-09-22 | Headless arm64 | PASS | Godot starts without parse errors | None | - |
| Project opens | 2026-09-22 | Headless arm64 | PASS | No parser errors, no missing resources | None | - |
| Scene launches | 2026-09-22 | Headless arm64 | PASS | Scene loads, exit code 0 | None | - |
| Runtime readiness audit | 2026-09-22 | Code review | PASS | All node paths verified, no @onready null refs | None | See below |
| Main scene in project.godot | 2026-09-22 | Code review | PASS | run/main_scene=res://scenes/main/main.tscn | None | - |
| Main instances district and vehicle | 2026-09-22 | Code review | PASS | main.tscn instances district_full.tscn which instances vehicle.tscn | None | - |
| Camera active | 2026-09-22 | Code review | PASS | Vehicle creates Camera3D with current=true in _ready() | None | - |
| Input actions exist | 2026-09-22 | Code review | PASS | accelerate, brake, steer_left, steer_right, restart, pause in project.godot | None | - |
| Collision nodes valid | 2026-09-22 | Code review | PASS | Vehicle has CollisionShape3D; district has Area3D with shapes | None | - |
| Scene paths valid | 2026-09-22 | Code review | PASS | All ext_resource paths resolve to existing files | None | - |
| SaveManager no duplicate | 2026-09-22 | Code review | PASS | Single SaveManager instance in main.tscn | None | - |
| No null @onready refs | 2026-09-22 | Code review | PASS | ResultsLabel created in _ready() before use; no @onready for dynamic nodes | None | - |
| _setup_save in _ready | 2026-09-22 | Code review | PASS | Called before timer and signals setup | None | - |
| Restart not double-triggered | 2026-09-22 | Code review | PASS | Only in _unhandled_input, removed from _input | None | - |
| New run | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Vehicle movement | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Vehicle collision | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Barrier initial block | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Vehicle break barrier | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Damage applied | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Shortcut opens | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Repair station | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Timer countdown | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Delivery success | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Delivery failure | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Restart | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Pause | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Results display | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Save: fresh file | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Save: load | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Save: missing file | 2026-09-22 | Headless arm64 | VERIFIED | "SAVE: no existing save file, using defaults" in logs | None | SaveManager resets to defaults |
| Save: corrupt file | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires test data |
| Window resize | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Repeated restarts | 2026-09-22 | Headless arm64 | NOT TESTED | - | - | Requires interactive session |
| Android export | 2026-09-22 | N/A | NOT TESTED | - | No Android SDK | Deferred |
| Desktop export | 2026-09-22 | N/A | NOT TESTED | - | No .NET/Mono | Deferred |
| Mobile performance | 2026-09-22 | N/A | NOT TESTED | - | No device | Deferred |

### Summary

| Result | Count |
|--------|-------|
| PASS | 3 |
| FAIL | 0 |
| NOT TESTED | 25 |
| VERIFIED | 1 |

### Headless Mode Notes

The project was tested using Godot's headless mode (`--headless --quit-after`). This verifies:
- Project configuration parses correctly
- All scripts compile without errors
- All referenced resources exist
- No missing-resource errors occur

Interactive gameplay features (movement, collision, delivery, etc.) require a graphical session and cannot be tested in headless mode.
