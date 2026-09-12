-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS modulo_ventas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE modulo_ventas;

-- 1. Tabla de Usuarios (Roles: Vendedor, Admin)
CREATE TABLE usuarios (
    usuario_id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('VENDEDOR', 'ADMIN') NOT NULL,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO'
) ENGINE=InnoDB;

-- 2. Tabla de Clientes
CREATE TABLE clientes (
    cliente_id VARCHAR(50) PRIMARY KEY,
    documento_identidad VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20)
) ENGINE=InnoDB;

-- 3. Tabla de Productos
CREATE TABLE productos (
    producto_id VARCHAR(50) PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    meses_garantia INT DEFAULT 0,
    stock INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- 4. Tabla de Ventas (Cabecera)
CREATE TABLE ventas (
    venta_id VARCHAR(50) PRIMARY KEY,
    cliente_id VARCHAR(50) NOT NULL,
    vendedor_id VARCHAR(50) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12, 2) NOT NULL,
    estado ENUM('PENDIENTE', 'COMPLETADA', 'CANCELADA') DEFAULT 'PENDIENTE',
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id) ON DELETE RESTRICT,
    FOREIGN KEY (vendedor_id) REFERENCES usuarios(usuario_id) ON DELETE RESTRICT,
    INDEX idx_fecha (fecha),
    INDEX idx_vendedor (vendedor_id)
) ENGINE=InnoDB;

-- 5. Tabla de Detalles de Venta
CREATE TABLE venta_detalles (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id VARCHAR(50) NOT NULL,
    producto_id VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES ventas(venta_id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 6. Tabla de Pagos
CREATE TABLE pagos (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id VARCHAR(50) NOT NULL UNIQUE,
    transaccion_pasarela VARCHAR(100) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    estado_pago ENUM('APROBADO', 'RECHAZADO', 'REEMBOLSADO') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venta_id) REFERENCES ventas(venta_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ==========================================
-- DATOS DE PRUEBA (SEEDS)
-- ==========================================

-- Insertar Vendedor
INSERT INTO usuarios (usuario_id, email, password_hash, rol) VALUES 
('VEND-1024', 'vendedor1@empresa.com', 'hash_simulado_123', 'VENDEDOR');

-- Insertar Cliente
INSERT INTO clientes (cliente_id, documento_identidad, nombre, correo, telefono) VALUES 
('CLI-55412', '987654321', 'Juan Pérez', 'juan.perez@email.com', '555-0192');

-- Insertar Producto
INSERT INTO productos (producto_id, sku, nombre, precio, meses_garantia, stock) VALUES 
('PROD-771', 'SRV-DELL-T340', 'Servidor Dell PowerEdge T340', 1250.00, 36, 10);

-- Insertar Venta
INSERT INTO ventas (venta_id, cliente_id, vendedor_id, fecha, total, estado) VALUES 
('SALE-99881', 'CLI-55412', 'VEND-1024', '2026-08-10 14:30:00', 1250.00, 'COMPLETADA');

-- Insertar Detalle de Venta
INSERT INTO venta_detalles (venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES 
('SALE-99881', 'PROD-771', 1, 1250.00, 1250.00);

-- Insertar Pago
INSERT INTO pagos (venta_id, transaccion_pasarela, metodo_pago, monto, estado_pago) VALUES 
('SALE-99881', 'tx_987654321', 'TARJETA_CREDITO', 1250.00, 'APROBADO');