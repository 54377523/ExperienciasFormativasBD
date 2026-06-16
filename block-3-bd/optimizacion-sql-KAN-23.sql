
-- =====================================================
-- KAN-23 - OPTIMIZACIÓN DE CONSULTAS SQL
-- Base de datos: mentorias
-- Tablas: usuarios, perfiles
-- Objetivo: optimizar búsqueda de mentores
-- =====================================================


-- =====================================================
-- 1. CONSULTA BASE (INEFICIENTE)
-- =====================================================
-- Problema: SELECT * trae datos innecesarios y reduce rendimiento

SELECT *
FROM usuarios u
JOIN perfiles p ON p.usuario_id = u.id
WHERE u.rol = 1;


-- =====================================================
-- 2. CONSULTA OPTIMIZADA (LISTADO GENERAL)
-- =====================================================
-- Mejora:
-- - solo columnas necesarias
-- - filtro de usuarios activos
-- - JOIN controlado

SELECT 
    u.id,
    u.nombre,
    u.email,
    u.estado,
    p.carrera,
    p.ciclo,
    p.disponibilidad
FROM usuarios u
INNER JOIN perfiles p ON p.usuario_id = u.id
WHERE u.rol = 1
AND u.estado = 'activo';


-- =====================================================
-- 3. CONSULTA OPTIMIZADA (FILTRO POR CARRERA)
-- =====================================================
-- Caso: búsqueda de usuarios por carrera

SELECT 
    u.id,
    u.nombre,
    p.carrera,
    p.ciclo,
    p.disponibilidad
FROM usuarios u
INNER JOIN perfiles p ON p.usuario_id = u.id
WHERE u.rol = 1
AND u.estado = 'activo'
AND p.carrera = 'Software';


-- =====================================================
-- 4. CONSULTA OPTIMIZADA (FILTRO AVANZADO)
-- =====================================================
-- Caso: búsqueda más específica

SELECT 
    u.id,
    u.nombre,
    p.carrera,
    p.ciclo,
    p.habilidades,
    p.disponibilidad
FROM usuarios u
INNER JOIN perfiles p ON p.usuario_id = u.id
WHERE u.rol = 1
AND u.estado = 'activo'
AND p.ciclo >= 5;


-- =====================================================
-- 5. CONSULTA LIGERA (LISTADO RÁPIDO)
-- =====================================================
-- Uso: mostrar resultados rápidos en interfaz

SELECT 
    u.id,
    u.nombre,
    p.carrera
FROM usuarios u
INNER JOIN perfiles p ON p.usuario_id = u.id
WHERE u.rol = 1
AND u.estado = 'activo'
LIMIT 20;


-- =====================================================
-- 6. ÍNDICES RECOMENDADOS (OPTIMIZACIÓN DE RENDIMIENTO)
-- =====================================================

-- Mejora JOIN principal
CREATE INDEX idx_perfiles_usuario_id 
ON perfiles(usuario_id);

-- Filtrado por rol
CREATE INDEX idx_usuarios_rol 
ON usuarios(rol);

-- Filtrado por estado
CREATE INDEX idx_usuarios_estado 
ON usuarios(estado);

-- Búsqueda por carrera
CREATE INDEX idx_perfiles_carrera 
ON perfiles(carrera);

-- Filtros combinados frecuentes
CREATE INDEX idx_usuarios_rol_estado 
ON usuarios(rol, estado);


-- =====================================================
-- FIN KAN-23
-- =====================================================
