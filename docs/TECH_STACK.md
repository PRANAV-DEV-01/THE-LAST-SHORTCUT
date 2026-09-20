# Technology Stack

## Engine

- Godot: 4.0
- Renderer: Mobile
- Project type: 3D gray-box prototype
- Primary target: Android
- Secondary target: Desktop

## Programming

- Language: Typed GDScript planned for later milestones
- Input: Named Godot InputMap actions planned for later milestones
- Save format: Versioned local JSON planned for later milestones

## Save Field Names

Use these snake_case fields:

- `save_version`
- `best_score`
- `best_time`
- `screen_shake`

## Stability Rules

- Keep Godot 4.0 fixed during the milestone.
- Document and retest any future engine upgrade.
- Use the Mobile renderer.
- Do not add plugins or external dependencies during the prototype phase.
- Do not claim Android export, performance, or device compatibility until tested.
