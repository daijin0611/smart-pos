# Tech Stack

## Core
- Java 17
- Spring Boot 3.2.0
- Maven (multi-module)

## Database & ORM
- MySQL 8.x
- MyBatis-Plus 3.5.11
- Druid connection pool 1.2.20

## Security
- Spring Security
- JWT (java-jwt 4.3.0)

## Caching
- Redis (Lettuce client)

## API Documentation
- Knife4j 4.3.0 (OpenAPI 3)
- Swagger annotations

## Utilities
- Lombok 1.18.34
- MapStruct 1.6.3 (object mapping)
- Hutool 5.8.18
- Jakarta Validation

## Deployment
- Docker support
- Profiles: dev, test, prod

## Common Commands

```bash
# Build entire project
mvn clean package

# Build skipping tests
mvn clean package -DskipTests

# Run application (dev profile)
mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=dev

# Docker build
mvn docker:build

# Docker push
mvn docker:push
```

## API Documentation
- Swagger UI: `/swagger-ui.html`
- API Docs: `/v3/api-docs`
- Druid Monitor: `/druid/*`
