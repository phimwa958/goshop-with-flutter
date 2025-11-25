# GoShop - Full Stack E-commerce Application

This repository contains a full-stack e-commerce application consisting of a Go backend and a Flutter frontend.

    git clone https://github.com/phimwa958/goshop-with-flutter
    cd goshop-with-flutter
    ```

## 🛠 Tech Stack

### Backend
-   **Language**: Go (Golang)
-   **Framework**: Gin-gonic
-   **Database**: PostgreSQL
-   **Caching**: Redis
-   **ORM**: Gorm
-   **Architecture**: Domain-Driven Design (DDD)
-   **Documentation**: Swagger

### Frontend
-   **Framework**: Flutter
-   **Language**: Dart
-   **State Management**: Provider
-   **Routing**: Go Router
-   **Platforms**: iOS, Android, Web, Windows, Linux, macOS

## ✨ Feature Overview

-   **User Authentication**: Secure login and registration.
-   **Product Catalog**: Browse products with pagination and search.
-   **Shopping Cart**: Add items, manage quantities.
-   **Order Management**: Place orders, view history, cancel orders.
-   **Profile Management**: Update user details and password.
-   **Cross-Platform**: Seamless experience across mobile, web, and desktop.
-   **Accessibility**: Screen reader support and keyboard navigation.

## 🔑 Environment Variables

The backend requires the following environment variables. You can configure these in `pkg/config/config.yaml` or via Docker environment variables.

| Variable | Description | Default |
| :--- | :--- | :--- |
| `environment` | Application environment | `production` |
| `http_port` | HTTP server port | `8888` |
| `grpc_port` | gRPC server port | `8889` |
| `auth_secret` | JWT secret key | `######` |
| `database_uri` | PostgreSQL connection URI | `postgres://username:password@host:5432/database` |
| `redis_uri` | Redis connection URI | `localhost:6379` |
| `redis_password` | Redis password | |
| `redis_db` | Redis database index | `0` |

## 🐳 Docker Instructions

The project includes a `docker-compose.yaml` file to easily set up the backend environment (Go API, PostgreSQL, Redis).

```bash
# Build and start containers
docker-compose up --build

# Run in background
docker-compose up -d

# Stop containers
docker-compose down
```

## 📚 API Documentation

Once the backend is running, you can access the Swagger API documentation at:

`http://localhost:8888/swagger/index.html`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the repository.
2.  Create your feature branch.
3.  Commit your changes.
4.  Push to the branch.
5.  Open a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

- **Backend Original Author**: [quangdangfit](https://github.com/quangdangfit) – Creator of the original backend structure  
- **Flutter Framework** – For providing a powerful cross-platform UI toolkit  
- **Go (Golang)** – For its performance, simplicity, and reliability in backend development  
- **Gin-gonic** – A fast and flexible web framework for Go  
- **Gorm** – ORM that simplifies database interactions  
- **PostgreSQL** – A robust and scalable database solution  
- **Redis** – For high-performance caching and session management  
- **Swagger** – For easy and interactive API documentation  
- **Dart / Provider / Go Router** – Core tools enabling smooth Flutter frontend development  
- The open-source community behind Go, Flutter, and all supporting libraries  
- All contributors and maintainers whose tools and packages made this project possible  

> [!NOTE]
> For more detailed backend documentation, see [backend/README_BACKEND.md](backend/README_BACKEND.md).
> For more detailed frontend documentation, see [goshop_flutter/README.md](goshop_flutter/README.md).
