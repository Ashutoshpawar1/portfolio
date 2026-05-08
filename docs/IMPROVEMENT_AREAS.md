# 🚀 Areas for Improvement

This document identifies specific files and logic in the portfolio project that are candidates for refactoring or enhancement to improve code quality, maintainability, and user experience.

## 1. Experience Section (Data Modularity)
- **Target File**: `lib/features/home/widgets/experience_section.dart`
- **Issue**: The `TimelineItem` widgets are currently hardcoded with static text. This makes it difficult to update the career history without modifying the UI code.
- **Improvement**: 
    - Create an `ExperienceModel` class.
    - Create a list of experience data in a central file.
    - Refactor `ExperienceSection` to use `ListView.builder` or a `Column` with a `map()` function to render items dynamically.

## 2. Tools Section (Widget Decomposition)
- **Target File**: `lib/features/home/widgets/tool_wave_section.dart`
- **Issue**: This file contains over 1,000 lines of code. It handles layout, animations (waves), and data all in one place.
- **Improvement**: 
    - Extract the wave animation logic into a dedicated widget (e.g., `WaveBackground`).
    - Extract individual category layouts into smaller widgets (e.g., `ToolCategoryGrid`).
    - Extract individual tool item logic into a reusable `ToolIconItem` widget.

## 3. Global Navigation (Scroll Synchronization)
- **Target Files**: `lib/controllers/home_controller.dart`, `lib/utils/components/menu_overlay.dart`
- **Issue**: The top menu buttons (About, Projects, etc.) are currently static and do not navigate the user to the corresponding section on the page.
- **Improvement**: 
    - Add a `ScrollController` to the `HomeController`.
    - Assign `GlobalKey`s to each section wrapper in `HomePage`.
    - Implement a `scrollToSection(String id)` method in the controller.
    - Update `MenuOverlay` to call this method, providing a seamless user experience.

## 4. Centralized Data Layer
- **Target Location**: `lib/data/` (New Directory)
- **Issue**: Project and skill data are scattered across constants or hardcoded in widgets.
- **Improvement**: 
    - Move `appProjects` from `app_strings.dart` to `lib/data/portfolio_data.dart`.
    - Define all skills, tools, and experience data in this new central data layer. This allows for easier content updates and potential future integration with a CMS or Backend.

## 5. Standardized Entrance Animations
- **Target Files**: All widgets in `lib/features/home/widgets/`
- **Issue**: Each section manages its own `flutter_animate` logic, which might lead to slight inconsistencies in timing or offsets.
- **Improvement**: 
    - Create a shared `EntranceAnimation` wrapper widget.
    - Standardize the "Fade + Slide Up" effect across the entire portfolio to ensure a cohesive professional feel.
