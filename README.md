# Earth-Final-Season
Final Project for the Apple Developer Academy

![Earth Final Season](path-to-image.png)

## Overview

**Earth: Final Season** is a reality show—except it's not on TV. You play as the host, an alien controlling influential figures to spread chaos, destruction, and pollution to maximize audience ratings. The game combines strategy and decision-making with a satirical twist.

## Gameplay

- **Swipe left or right**: Each direction represents a decision impacting the planet.
- **Tap buttons**: Choose specific actions based on events.
- **Balance Indicators**: Keep **Ill Being**, **Environmental Degradation**, and **Social Political Instability** in check.
- **Maximize Audience**: The show must go on.

## Objectives

- Keep chaos indicators balanced.
- Maintain a high audience rating.
- Extend the show's duration as long as possible.
- Experience unique endings based on choices and hidden factors.

## Progression

- **No linear story**: Every session is different.
- **Runs mechanic**: The game ends when you lose, but each playthrough is unique.
- **Multiple Endings**: Custom conclusions based on decisions and game state.

## Game Over Conditions

- Any indicator reaching max or zero.
- Special characters triggering unique failures.

## Future Features

- A post-game timeline of key events.
- Different scenarios and historical periods.
- Adjustable difficulty levels.

## Available on the App Store

[![Download on the App Store](path-to-app-store-badge.png)](app-store-link)

## Developer Features

Earth: Final Season is built with a focus on performance, modularity, and scalability using modern Apple technologies:

- **SwiftUI**: Declarative UI framework for seamless and dynamic interfaces.
- **Core ML**: Powers AI-driven decisions for procedural event generation.
- **Metal**: Handles advanced rendering and effects for an immersive experience.
- **Swift Package Manager**: Streamlines dependency management.
- **CloudKit**: Enables cloud-based storage and game synchronization.
- **Combine**: Manages reactive programming and data flow.
- **MVVM Architecture**: Ensures clean code separation and scalability.

## Development Guidelines

### Git Workflow

- **Main**: Stable branch, only merges from `develop`.
- **Develop**: Latest tested version, merges feature branches.
- **Feature Branches**: Named `feature/idTask-title`, e.g., `feature/304-create-login-view`.

### Architecture

- **MVVM (Model-View-ViewModel)**
- Organized by feature: Each feature has its own View, ViewModel, and Model.


