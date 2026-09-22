# THE LAST SHORTCUT

3D gray-box vertical slice. Drive a fragile delivery vehicle through a collapsing city block. Choose safe roads or destructive shortcuts.

## Overview

The player drives a delivery vehicle through a compact 3D district. The district collapses behind them. The player must deliver a package before time runs out, choosing between a safe route and a destructive shortcut.

## Features

- Arcade vehicle movement with acceleration, braking, and steering
- Destructible barrier opening a dangerous shortcut
- Repair station with time penalty
- Delivery destination detection with timer
- Score calculation (time bonus, damage penalty, shortcut bonus)
- Local save with best score and time tracking
- Screen-shake toggle
- Camera smoothing and look-ahead
- Impact feedback on collisions

## Controls

| Action | Key |
|--------|-----|
| Accelerate | W / Up Arrow |
| Brake | S / Down Arrow |
| Steer Left | A / Left Arrow |
| Steer Right | D / Right Arrow |
| Restart | R |
| Pause | Escape |

## Requirements

- Godot 4.3.stable.official.77dcf97d8
- GL Compatibility renderer
- No external dependencies

## Run

1. Open Godot 4.3.stable.official.77dcf97d8
2. Import project.godot
3. Press F5 to play

## Project Structure

```
THE-LAST-SHORTCUT/
├── project.godot
├── icon.svg
├── scenes/
│   ├── main/main.tscn
│   ├── player/vehicle.tscn
│   ├── levels/district_full.tscn
│   ├── save/save_manager.tscn
├── scripts/
│   ├── core/main.gd
│   ├── player/vehicle.gd
│   ├── level/district.gd
│   ├── save/save_manager.gd
├── assets/
│   ├── materials/vehicle.tres
├── docs/
│   ├── PROJECTSTATUS.md
│   ├── TECHSTACK.md
│   ├── TODO.md
│   ├── KNOWNLIMITATIONS.md
│   ├── TESTRESULTS.md
│   └── FINALREPORT.md
└── README.md
```

## Technology

- Engine: Godot 4.3
- Scripting: GDScript
- Renderer: GL Compatibility (Mobile)
- Platform: Android (primary), Desktop (secondary)

## Status

- Structural validation: VERIFIED
- Code-review audit: VERIFIED
- Interactive gameplay: NOT TESTED
- Godot graphical editor: NOT TESTED
- Android export: NOT TESTED
- Desktop export: NOT TESTED
- Performance: NOT TESTED
- Release readiness: NOT READY

The implementation is present, but the project is not release-ready. See `docs/TESTRESULTS.md` for evidence and `docs/FINALREPORT.md` for the current report.
