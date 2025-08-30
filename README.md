# H & H Axis

![Project Screenshot](folder.jpg)

## Overview

H-Axis is a modern web application built using the following technologies:

### Backend

- **Laravel** (PHP framework)

### Frontend

- **Vue.js** (JavaScript framework)
- **Vite** (Frontend build tool)

### Development Tools

- **Laravel Sail** (Docker-based local development)
- **Pest** (Testing framework)
- **PHPUnit** (Testing framework)
- **Composer** (PHP dependency manager)
- **ESLint** (JavaScript/TypeScript linter)

## Getting Started

### Prerequisites

- Docker
- Composer
- Node.js & npm (or pnpm)

### Installation

1. Clone the repository:
    ```bash
    git clone <repo-url>
    cd h-axis
    ```
2. Install PHP dependencies:
    ```bash
    composer install
    ```
3. Install JavaScript dependencies:
    ```bash
    npm install
    # or
    pnpm install
    ```
4. Copy the example environment file and update as needed:
    ```bash
    cp .env.example .env
    ```
5. Start the development environment:
    ```bash
    ./vendor/bin/sail up
    ```

## Project Structure

- `app/` - Laravel application code
- `resources/spa/` - Vue.js SPA source code
- `public/` - Public assets and entry point
- `routes/` - Laravel route definitions
- `database/` - Migrations, factories, seeders
- `tests/` - Test suites

## License

This project is licensed under the MIT License.
