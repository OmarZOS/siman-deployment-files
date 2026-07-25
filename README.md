# SIMAN - Cloud-Based File Management System

## Overview

**SIMAN** (Amazigh word meaning "two souls") is a cloud-based file management system inspired by the concept of legacy - preserving documents that hold undeniable importance even if not needed in everyday life. The name honors our parents and where we came from, reflecting the system's purpose of preserving and managing valuable documents.

---

## Architecture

### System Components

```
┌─────────────────────────────────────────────────────────────┐
│                    SIMAN System Architecture                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────┐ │
│  │   MySQL     │    │   Auth      │    │   File System   │ │
│  │   Database  │◄──►│   Service   │◄──►│   Service       │ │
│  │  (siman-db) │    │ (siman-auth)│    │  (siman-fs)     │ │
│  └─────────────┘    └─────────────┘    └─────────────────┘ │
│        │                  │                     │           │
│        └──────────────────┼─────────────────────┘           │
│                           │                                 │
│                   ┌───────▼───────┐                         │
│                   │  Docker       │                         │
│                   │  Network      │                         │
│                   │ (siman-net)   │                         │
│                   └───────────────┘                         │
└─────────────────────────────────────────────────────────────┘
```

### Core Services

| Service | Container Name | Port | Purpose |
|---------|---------------|------|---------|
| **MySQL Database** | `siman-db` | 3306 | Primary data storage for all documents, metadata, and system data |
| **Authentication Service** | `siman-auth` | 9090 | JWT-based authentication and authorization |
| **File System Service** | `siman-fs` | 9099 | File storage, retrieval, and management operations |

---

## Database Schema

![Database Schema](3rd_party_software/my-sql/siman.png)

The MySQL database (`Archive`) contains all core tables for:
- Document management
- User authentication
- Access control
- File metadata
- Audit trails
- System configuration

---

## Technology Stack

### Backend Services
- **Runtime**: Python 3.x with FastAPI/Uvicorn
- **Database**: MySQL 8.0
- **Authentication**: JWT-based auth service
- **File Storage**: Custom file system service
- **Containerization**: Docker & Docker Compose

### Development Tools
- **ORM**: SQLAlchemy with `sqlacodegen`
- **API Framework**: FastAPI
- **Database Migration**: MySQL initialization scripts

---

## Configuration

### Environment Variables (.env)

```env
# MySQL Configuration
MYSQL_DATABASE=Archive
MYSQL_USER=dev_user
MYSQL_ROOT_PASSWORD=dev_password
MYSQL_PASSWORD=dev_password
MYSQL_PORT=3306

# Authentication Service
ACCESS_TOKEN_EXPIRE_MINUTES=10
DEFAULT_ADMIN_USERNAME=siman_api
DEFAULT_ADMIN_PASSWORD=qAeofp5464fs&z!
ALGORITHM=HS256
SECRET_KEY=qsdfsqfgqsf12fgazz65fzf&3!
AUTH_PORT=9090

# File System Service
FS_BASE_STORAGE=/fs/cache
FS_CACHE_STORAGE=/fs/cache
```

### Third-Party Software
Each 3rd party service contains `.env` files with specific configuration needed to launch its containers.

---

## Deployment

### Prerequisites
- Docker (latest version)
- Docker Compose

### Quick Start

sudo docker compose up -d

```

### Makefile Commands
The deployment specifications are defined in each tag in the `Makefile`:
- `make` - Deploy all services
- `make up` - Start services
- `make down` - Stop services
- `make logs` - View logs
- `make clean` - Clean up containers and volumes

---

## Service Details

### 1. MySQL Database (siman-db)

**Purpose**: Primary data storage for all system data

**Configuration**:
- Image: `mysql:latest`
- Database: `Archive`
- Volume: `./data/sql:/var/lib/mysql` (persistent storage)
- Init Script: `./database.sql` runs on first startup

**Access**:
```bash
# Connect to database
sudo docker exec -it siman-db mysql -u root Archive -p

# Create development user
CREATE USER 'dev_user'@'%' IDENTIFIED BY 'dev_password';
GRANT ALL PRIVILEGES ON *.* TO 'dev_user'@'%';
FLUSH PRIVILEGES;
```

### 2. Authentication Service (siman-auth)

**Purpose**: JWT-based authentication and authorization

**Configuration**:
- Image: `omarzos/emastan-auth:latest`
- Port: `9090`
- Database: SQLite (auth_db_data.db)
- Environment: JWT settings, admin credentials

**Features**:
- User registration and login
- JWT token generation and validation
- Role-based access control
- Admin user creation

### 3. File System Service (siman-fs)

**Purpose**: File storage, retrieval, and management

**Configuration**:
- Image: `omarzos/emagrad-fs:latest`
- Port: `9099`
- Storage: Configurable base and cache storage paths

**Features**:
- File upload/download
- File metadata management
- Caching for performance
- Storage optimization

---

## Docker Compose Configuration

### Network
- **Network Name**: `siman-net`
- **Driver**: Bridge
- All services communicate through this internal network

### Resource Limits
| Service | CPU Limit | Memory Limit |
|---------|-----------|--------------|
| MySQL | Unlimited | Unlimited |
| Auth Service | 0.5 CPU | 256 MB |
| FS Service | 0.5 CPU | 512 MB |

---

## Development

### Generate Models
```bash
# Get MySQL container IP
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' siman-db

# Generate SQLAlchemy models
sqlacodegen --outfile=api_server/core/models.py \
  mysql+pymysql://dev_user:dev_password@<MYSQL_IP>/Archive
```

### Development Database Access
```bash
# Connect to MySQL container
sudo docker exec -it siman-db mysql -u root Archive -p

# Or connect from host using MySQL client
mysql -h 127.0.0.1 -P 3306 -u dev_user -p Archive
```

---

## Monitoring & Maintenance

### Health Checks
```bash
# Check service status
sudo docker ps

# View logs
sudo docker logs siman-db
sudo docker logs siman-auth
sudo docker logs siman-fs

# Monitor resource usage
docker stats
```

### Backup & Restore
```bash
# Backup database
sudo docker exec siman-db mysqldump -u root -p Archive > backup.sql

# Restore database
cat backup.sql | sudo docker exec -i siman-db mysql -u root -p Archive
```

---

## Troubleshooting

### Common Issues

1. **Database Connection Issues**
```bash
# Check if MySQL is running
sudo docker ps | grep siman-db

# Restart MySQL
sudo docker restart siman-db
```

2. **Authentication Errors**
```bash
# Check auth service logs
sudo docker logs siman-auth

# Reset admin credentials in .env
DEFAULT_ADMIN_USERNAME=siman_api
DEFAULT_ADMIN_PASSWORD=your_new_password
```

3. **File Service Issues**
```bash
# Check storage permissions
sudo docker exec siman-fs ls -la /fs/cache

# Restart file service
sudo docker restart siman-fs
```

---

## Cloud Deployment

### Migration Instructions
1. **AWS**: Use ECS with Fargate or EKS
2. **Azure**: Use AKS or Container Instances
3. **GCP**: Use GKE or Cloud Run
4. **DigitalOcean**: Use Kubernetes or App Platform

### Key Considerations
- Replace Docker Compose with Kubernetes manifests
- Use managed database services (RDS, Cloud SQL, etc.)
- Implement horizontal scaling for services
- Set up load balancing and API gateways
- Configure persistent storage volumes

---

## Security Best Practices

1. **Environment Variables**: Never commit `.env` files to version control
2. **Secrets Management**: Use Docker secrets or HashiCorp Vault
3. **SSL/TLS**: Enable HTTPS for all services in production
4. **Firewall**: Restrict access to ports 9090 and 9099
5. **Database Security**: Use strong passwords and restrict access
6. **Regular Updates**: Keep Docker images updated

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

---


## Acknowledgments

- Inspired by the Amazigh concept of "Siman" - preserving legacy
