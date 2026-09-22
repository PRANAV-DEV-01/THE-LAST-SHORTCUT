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
| Renderer | GL Compatibility (configured; graphical session unavailable) |
| Graphical session | Unavailable: no DISPLAY; Wayland cursor library unavailable |

### Test Results

| Test | Date | Environment | Result | Evidence | Warnings or errors | Workaround |
|------|------|-------------|--------|----------|--------------------|------------|
| Fresh launch | 2026-09-22 | Headless arm64 | PASS | Godot starts and exits with code 0 | Repeated dummy-renderer mesh warnings | Non-blocking; interactive rendering not exercised |
| Project parses | 2026-09-22 | Headless arm64 | PASS | No parser or missing-resource errors reported | None | Headless project load only |
| Scene launches | 2026-09-22 | Headless arm64 | PASS | Main scene starts and the process exits with code 0 | Repeated dummy-renderer mesh warnings | Does not verify gameplay |
| Headless mesh warnings | 2026-09-22 | Headless arm64 | WARNING | Dummy renderer emitted `Parameter "m" is null` mesh warnings | Rendering-only diagnostics | Graphical test required |
| Godot graphical editor launch | 2026-09-22 | Godot 4.3, Linux aarch64, no graphical display | FAIL | `--editor --path /root/THE-LAST-SHORTCUT` exited before the editor or game window opened | `X11 Display is not available`; Wayland cursor library missing; `Unable to create DisplayServer` | Provide a graphical X11/Wayland session |
| Runtime readiness audit | 2026-09-22 | Code review | PASS | All node paths verified, no `@onready` null refs | None | See below |
| Main scene in `project.godot` | 2026-09-22 | Code review | PASS | `run/main_scene=res://scenes/main/main.tscn` | None | - |
| Main instances district and vehicle | 2026-09-22 | Code review | PASS | `main.tscn` instances `district_full.tscn`, which instances `vehicle.tscn` | None | - |
| Camera active | 2026-09-22 | Code review | PASS | Vehicle creates `Camera3D` with `current=true` in `_ready()` | None | - |
| Input actions exist | 2026-09-22 | Code review | PASS | `accelerate`, `brake`, `steer_left`, `steer_right`, `restart`, `pause` in `project.godot` | None | - |
| Collision nodes valid | 2026-09-22 | Code review | PASS | Vehicle has `CollisionShape3D`; district has `Area3D` nodes with shapes | None | - |
| Scene paths valid | 2026-09-22 | Code review | PASS | All `ext_resource` paths resolve to existing files | None | - |
| SaveManager no duplicate | 2026-09-22 | Code review | PASS | Single `SaveManager` instance in `main.tscn` | None | - |
| No null `@onready` refs | 2026-09-22 | Code review | PASS | ResultsLabel created in `_ready()` before use; no `@onready` for dynamic nodes | None | - |
| `_setup_save` in `_ready` | 2026-09-22 | Code review | PASS | Called before timer and signals setup | None | - |
| Restart not double-triggered | 2026-09-22 | Code review | PASS | Only in `_unhandled_input`, removed from `_input` | None | - |
| Main scene launch | 2026-09-22 | Graphical session unavailable | NOT TESTED | Blocked by graphical editor launch failure | No game window opened | Provide a graphical session |
| Vehicle movement (WASD) | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or input device | Provide a graphical session |
| Vehicle movement (arrow keys) | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or input device | Provide a graphical session |
| Collision physics | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or physics observation | Provide a graphical session |
| Camera behavior | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or camera observation | Provide a graphical session |
| District navigation | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or route observation | Provide a graphical session |
| Barrier interaction (initial block) | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or collision observation | Provide a graphical session |
| Barrier interaction (break/open) | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or collision observation | Provide a graphical session |
| Damage applied on barrier hit | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or HUD/log observation | Provide a graphical session |
| Shortcut opens after barrier break | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or route observation | Provide a graphical session |
| Repair station interaction | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or route observation | Provide a graphical session |
| Timer countdown | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or timer observation | Provide a graphical session |
| Delivery success | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or destination observation | Provide a graphical session |
| Delivery failure | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or timer observation | Provide a graphical session |
| Restart | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or input device | Provide a graphical session |
| Pause | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or input device | Provide a graphical session |
| Results display | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or UI observation | Provide a graphical session |
| Save: fresh file | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or save observation | Provide a graphical session |
| Save: load | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or save observation | Provide a graphical session |
| Save: missing file | 2026-09-22 | Headless arm64 | VERIFIED | `SAVE: no existing save file, using defaults` in logs | None | SaveManager resets to defaults |
| Save: corrupt file | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or test data | Provide a graphical session and test data |
| Window resize | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window | Provide a graphical session |
| Repeated restarts | 2026-09-22 | Graphical session unavailable | NOT TESTED | Not performed | No game window or input device | Provide a graphical session |
| Android export | 2026-09-22 | N/A | NOT TESTED | Not performed | No Android SDK | Deferred |
| Desktop export | 2026-09-22 | N/A | NOT TESTED | Not performed | No desktop export toolchain verified | Deferred |
| Mobile performance | 2026-09-22 | N/A | NOT TESTED | Not performed | No device | Deferred |
| Desktop performance | 2026-09-22 | N/A | NOT TESTED | Not performed | No performance measurement | Deferred |

### Graphical QA Attempt

Command:

`Godot_v4.3-stable_linux.arm64 --editor --path /root/THE-LAST-SHORTCUT`

Result: **FAIL** before the editor or game window opened.

Environment errors:

- `X11 Display is not available`
- `libwayland-cursor.so.0: cannot open shared object file: No such file or directory`
- `Could not initialize the Wayland thread`
- `Unable to create DisplayServer, all display drivers failed`
- Allocator and static-string shutdown errors were reported after the failed display-server startup.

Because no graphical window opened, WASD, arrow-key, physics, camera, navigation, barrier, delivery, timer, restart, pause, and save/load interactions were not performed. They remain `NOT TESTED`, not `PASS`.

### Validation Command

`Godot_v4.3-stable_linux.arm64 --path /root/THE-LAST-SHORTCUT --headless --quit-after 2`

The command exited with code 0. No parser or missing-resource errors were reported. The dummy renderer emitted repeated `Parameter "m" is null` mesh warnings; these are recorded as a warning and are not gameplay evidence.

### Summary

| Result | Count |
|--------|-------|
| PASS | 14 |
| FAIL | 1 |
| WARNING | 1 |
| NOT TESTED | 26 |
| VERIFIED | 1 |

### Headless Mode Notes

The headless run verifies project/script/resource loading and a clean process exit only. It does not verify movement, collision, input, camera behavior, delivery logic, UI behavior, save/load behavior, or rendering in a graphical session.

Interactive gameplay features require a graphical Godot editor/session and remain NOT TESTED.
