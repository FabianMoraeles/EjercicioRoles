-- Tabla empresas
CREATE TABLE "empresas" (
    "id" SERIAL PRIMARY KEY,
    "nombre" VARCHAR(100) NOT NULL,
    "correo" VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla usuarios
CREATE TABLE "usuarios" (
    "id" SERIAL PRIMARY KEY,
    "nombre" VARCHAR(100) NOT NULL,
    "correo" VARCHAR(100) NOT NULL,
    "rol" VARCHAR(50) NOT NULL,
    "empresa_id" INT NOT NULL,
    CONSTRAINT "fk_usuarios_empresas" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id")
);

-- Tabla productos
CREATE TABLE "productos" (
    "id" SERIAL PRIMARY KEY,
    "nombre" VARCHAR(100) NOT NULL,
    "descripcion" TEXT,
    "precio" NUMERIC(10,2) NOT NULL,
    "stock" INT,
    "empresa_id" INT NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "fk_productos_empresas" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id")
);

-- Tabla pedidos
CREATE TABLE "pedido" (
    "id" SERIAL PRIMARY KEY,
    "usuario_id" INT NOT NULL,
    "empresa_id" INT NOT NULL,
    "fecha" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "estado" VARCHAR(50),
    CONSTRAINT "fk_pedido_usuarios" FOREIGN KEY ("usuario_id") REFERENCES "usuarios"("id"),
    CONSTRAINT "fk_pedido_empresas" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id")
);

-- Tabla detalle_pedido
CREATE TABLE "detalle_pedido" (
    "id" SERIAL PRIMARY KEY,
    "orden_id" INT NOT NULL,
    "producto_id" INT NOT NULL,
    "cantidad" INT NOT NULL,
    "precio_unitario" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "fk_detalle_orden_pedido" FOREIGN KEY ("orden_id") REFERENCES "pedido"("id"),
    CONSTRAINT "fk_detalle_producto" FOREIGN KEY ("producto_id") REFERENCES "productos"("id")
);

-- Tabla pagos
CREATE TABLE "pagos" (
    "id" SERIAL PRIMARY KEY,
    "orden_id" INT NOT NULL,
    "empresa_id" INT NOT NULL,
    "fecha_pago" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "monto" NUMERIC(10,2),
    "metodo_pago" VARCHAR(50),
    CONSTRAINT "fk_pagos_pedido" FOREIGN KEY ("orden_id") REFERENCES "pedido"("id"),
    CONSTRAINT "fk_pagos_empresas" FOREIGN KEY ("empresa_id") REFERENCES "empresas"("id")
);
