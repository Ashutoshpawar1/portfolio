# Project Flow & Management

This document explains the current flow of the Ashutosh Portfolio and how the code is organized.

## 🌊 Current Application Flow
The `HomePage` acts as the main orchestrator, assembling the following sections in order:

1.  **Home (HeroSection)**: The landing view with parallax effects and main call-to-action.
2.  **About (AboutMeSection)**: Personal introduction and background.
3.  **Projects (ProjectsSection)**: Infinite auto-scrolling carousel of project cards.
4.  **Skills (SkillsSection)**: Glassmorphism cards with animated progress bars and icons.
5.  **Experience (ExperienceSection)**: Career timeline and professional history.
6.  **Tools (ToolWaveSection)**: Visual representation of the developer's tech stack.
7.  **Footer (SiteFooter)**: Contact links and copyright information.

## 📂 Code Organization
Each section above is managed as a separate widget in `lib/features/home/widgets/`. This provides several benefits:
- **Scalability**: New sections can be added easily without bloating `home_page.dart`.
- **Maintainability**: Bugs can be isolated to specific section files.
- **Collaboration**: Multiple developers can work on different sections simultaneously without merge conflicts.

## 🔧 Future Management Suggestions
- **Dynamic Content**: Transition from hardcoded data to a centralized data repository in `lib/data/`.
- **Enhanced Navigation**: Connect the Top Menu to the sections using `GlobalKey` and `ScrollController` offsets.
- **Section Controllers**: For complex sections (like Tools), consider using a dedicated `GetxController` to manage local animations and states.
