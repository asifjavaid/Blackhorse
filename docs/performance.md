### Performance

Back to README: [../README.md](../README.md)

### Guidance

- Use Provider selectors to minimize rebuilds.
- Prefer const widgets and split large widgets into smaller parts.
- Avoid heavy synchronous work in `build` or `initState`; defer to Services.
- Optimize images and use SVGs where appropriate (`flutter_svg`).

### Tooling

- Flutter DevTools (CPU, Memory, Widget rebuilds).
- `flutter run --profile` and frame analysis.

### Assets/loading

- Keep images under `assets/images/` optimized; use vector icons in `assets/icons/`.

### Known areas

- Charts (`fl_chart`, `syncfusion_flutter_charts`) and lists (`flutter_staggered_grid_view`) can be heavy; virtualize or limit item counts where possible.
