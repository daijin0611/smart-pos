# Project Structure

## Module Layout
```
pos-java/
├── pos-common/    # Shared DTOs, VOs, enums, utils, constants
├── pos-server/    # Business logic: entities, mappers, services
└── pos-web/       # Controllers, configs, filters, application entry
```

## Module Dependencies
`pos-web` → `pos-server` → `pos-common`

## Package Conventions

### pos-common (`org.haut.common`)
- `domain/dto/` - Request DTOs (grouped by feature: order, vip, system, etc.)
- `domain/vo/` - Response VOs
- `domain/query/` - Query parameter objects
- `enums/` - Business enumerations
- `constant/` - Constants and Redis keys
- `exception/` - Custom exceptions
- `utils/` - Utility classes

### pos-server (`org.haut.server`)
Each feature module follows:
```
{feature}/
├── entity/     # Database entities (@TableName)
├── mapper/     # MyBatis mapper interfaces
└── service/
    ├── {Feature}Service.java      # Interface extends IService<Entity>
    └── impl/{Feature}ServiceImpl.java
```

Mapper XML files: `resources/mapper/{feature}/*.xml`

### pos-web (`org.haut`)
- `controller/{feature}/` - REST controllers
- `config/` - Spring configurations
- `filter/` - Request filters (CORS, JWT)
- `interceptor/` - Request interceptors
- `advice/` - Global exception handlers

## Naming Conventions
- Entity: `{Name}Entity` or `{Name}` (e.g., `OrderInfoEntity`, `VipInfo`)
- DTO: `{Name}DTO`, `{Name}CreateDTO`, `{Name}UpdateDTO`
- VO: `{Name}VO`, `JsonVO<T>` for responses
- Query: `{Name}Query`, `{Name}PageQuery`
- Service: `{Name}Service` / `{Name}ServiceImpl`
- Mapper: `{Name}Mapper`
- Controller: `{Name}Controller`

## Code Patterns
- Use `@RequiredArgsConstructor` for dependency injection
- Use `@Validated` with `@RequestBody` for input validation
- Wrap responses in `JsonVO<T>`
- Use `@Schema` annotations for API documentation
- Use `@Accessors(chain = true)` for fluent setters
- Logical delete via `isDelete` field (0=exists, 1=deleted)
