# Demo de Prisma

Demo de Prisma con relaciones entre tablas del curso DATW 2026

## Films

Ejemplo de API de películas, géneros, reviews y usuarios (perfil)

### Relación entre tablas

- películas -- n:n --> géneros

- [películas -- n:n --> usuarios]
- películas -- 1:n --> reviews
- usuarios -- 1:n --> reviews

- usuarios -- 1:1 --> perfil

### Endpoints

- [GET] /api/películas
- [GET] /api/películas/:id
- [POST] /api/películas [Admin]
- [PATCH] /api/películas/:id [Admin]
- [DELETE]/api/películas/:id [Admin]

---

- [POST] /api/users/registro
- [POST] /api/users/login
- [GET] /api/users/:id
- [PATCH] /api/users/:id [Owner]
- [DELETE] /api/users/:id [Owner, Admin]

---

- [GET] /api/reviews [User]
- [GET] /api/reviews/:id [User]
- [POST] /api/reviews [User]
- [PATCH] /api/reviews/:id [Owner]
- [DELETE] /api/reviews/:id [Owner, Admin]
