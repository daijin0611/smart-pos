# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Java 17-based Point of Sale (POS) system built with Spring Boot 3.5.0. It's a multi-module Maven project designed for retail/hospitality businesses with support for stores, VIP customers, orders, payments, and inventory management.

## Build and Development Commands

### Maven Commands
```bash
# Build entire project
mvn clean package

# Build skipping tests
mvn clean package -DskipTests

# Run application (dev profile)
mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=dev

# Run application with specific profile
mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=test

# Docker build
mvn docker:build

# Docker push
mvn docker:push
```

### Running the Application
- Default port: 8080
- Context path: `/api`
- Swagger UI: `http://localhost:8080/api/swagger-ui.html`
- API Docs: `http://localhost:8080/api/v3/api-docs`
- Druid Monitor: `http://localhost:8080/api/druid/*` (username: druid, password: druid)

## Architecture Overview

### Module Structure
- **pos-common/**: Shared utilities, DTOs, VOs, enums, response wrappers
- **pos-server/**: Business logic layer (Services, Entities, MyBatis mappers)
- **pos-web/**: REST API layer (Controllers, Configuration, Application entry point)
- **sql/**: Database schema and migration scripts

### Technology Stack
- **Core**: Java 17, Spring Boot 3.5.0
- **Database**: MySQL 8.2.0 with MyBatis-Plus 3.5.11
- **Connection Pool**: Druid 1.2.20
- **Cache**: Redis
- **Security**: Spring Security + JWT 4.3.0
- **API Docs**: Knife4j 4.3.0 (Swagger)
- **Utilities**: Lombok 1.18.34, MapStruct 1.6.3, Hutool 5.8.18

### Layered Architecture
1. **Controller Layer** (`pos-web`): REST API endpoints with Swagger documentation
2. **Service Layer** (`pos-server`): Business logic extending `IService<T>`
3. **Mapper Layer** (`pos-server`): Database access extending `BaseMapper<T>`
4. **Entity Layer** (`pos-server`): Database models with `@TableName` annotations

## Key Business Modules
- **system**: Users, roles, permissions, organizations
- **order**: Order management and processing
- **payment**: Payment processing (supports multiple payment types)
- **vip**: VIP customer management
- **stock**: Inventory and stock management
- **room**: Room/area management (hospitality features)
- **server**: Service items management
- **kpi**: Key performance indicators
- **statistics**: Analytics and reporting
- **task**: Scheduled tasks
- **ai**: AI-related functionality

## Development Conventions

### Code Structure Patterns
- **Controllers**: Use `@RestController`, `@Tag`, `@Operation` for Swagger docs
- **Services**: Extend `IService<T>` from MyBatis-Plus
- **Mappers**: Extend `BaseMapper<T>` from MyBatis-Plus
- **Responses**: Use `JsonVO<T>` wrapper with `ResultStatus` enum
- **Logging**: Use `@Slf4j` from Lombok

### Naming Conventions
- **Classes**: PascalCase (e.g., `SysUserController`)
- **Methods**: camelCase (e.g., `getUserById`)
- **Variables**: camelCase (e.g., `userId`)
- **Database**: snake_case (e.g., `sys_user`)

### Git Commit Convention
- Format: `模块名[类型] 描述`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `build`
- Chinese commit messages preferred
- Max 50 characters for description
- Do not add informations that are not related to the commit

## Environment Profiles
- **dev**: Development environment (default)
- **test**: Testing environment
- **prod**: Production environment

## Database
- Schema located in `/sql/` directory
- Contains `pos_data.sql` with initial data
- Recent migration: `V1.0.1__add_print_width_to_sys_org.sql` for store print width configuration

## Testing
- Uses Spring Boot Test starter
- Run tests: `mvn test`
- Run specific module tests: `mvn test -pl pos-server`

## Docker Support
- Dockerfile available with openjdk:17 base image
- docker-compose.yml for orchestration
- Application runs on port 8080 with `/api` context path