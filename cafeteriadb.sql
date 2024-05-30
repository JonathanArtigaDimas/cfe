-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2024 a las 07:56:26
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cafeteriadb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo_individual` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_evento` datetime NOT NULL,
  `palabra_clave` varchar(50) DEFAULT NULL,
  `descuento` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lugar`
--

CREATE TABLE `lugar` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `capacidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `nombre`, `descripcion`, `imagen`, `precio`) VALUES
(8, 'prueba 3', 'asdf', 'img/imgProductos/alfajores.jpeg', 1.20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id`, `usuario_id`, `fecha`, `total`) VALUES
(1, 1, '2024-05-01 14:30:00', 150.75),
(2, 3, '2024-05-02 10:15:30', 90.20),
(3, 5, '2024-05-02 16:45:10', 320.50),
(4, 6, '2024-05-03 09:20:45', 212.00),
(5, 1, '2024-05-04 12:10:30', 185.90),
(6, 3, '2024-05-04 18:00:00', 75.50),
(7, 5, '2024-05-05 20:15:20', 145.80),
(8, 6, '2024-05-06 08:55:55', 110.00),
(9, 7, '2024-05-07 19:30:30', 99.99),
(10, 1, '2024-05-08 13:00:00', 205.75);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE `reserva` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `lugar_id` int(11) NOT NULL,
  `fecha_reserva` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nameUser` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `permisos` int(11) DEFAULT 1,
  `direccion` varchar(255) DEFAULT NULL,
  `numero_tel` varchar(15) DEFAULT NULL,
  `contraseña` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombres`, `apellidos`, `nameUser`, `correo`, `permisos`, `direccion`, `numero_tel`, `contraseña`) VALUES
(1, 'Brandon Yared', 'Mejia Hernandez', 'BrouMH9', 'yaredm9@gmail.com', 1, 'Mi casa', '123', 'scrypt:32768:8:1$wIX4SGENwymC8nrI$b22a34a2ef02fe086f76bbd508871f0cbe6fa7651f9b1c9409a40ed6a548da067a20b0fa35137f09108aada7ab2685c782023748a7702b85d73288d7c5b8ef17'),
(3, 'Juan Alberto', 'Illo', 'IlloJuan', 'ii', 2, 'asdf', '123', 'scrypt:32768:8:1$lshtMGpI94YpcP4P$d26bf695d0fcde6c9f55d3bc1e63f38f71dd55a6e91000347a717295a6905e6b1a6ab492acf6da7ad3d120a5f2f874e302312b0c78bb1201ddd2b746cacd3df7'),
(4, 'Brandon Yared', 'Mejia Hernandez', 'asdf', 'asdf', 1, 'Mi casa', '123', 'scrypt:32768:8:1$DLwkcYdxmFgB5GUs$b64919f76af973cde3591753f51cc7de62df76d9101f28595ae9282025578fb4f2bcee6a316b092e8ee67c02eca64885afe96fafa217ee2ae08c57a0d84ae64d'),
(5, 'Andre Sofia', 'Cortez Mejia', 'Sofi', 'sofia@gmail.com', 1, 'Alla', '3656498', 'scrypt:32768:8:1$TiaOtxSBc4BFbn1W$6aed83e2ce1c7b97c0b036a19e538e23ff1eadcc45b8aee92c2c237310e6ae3e68a19081edcc13fe22fbaf35d89ca1708c156e7eb4a0b30d2c2ff69d33881aac'),
(6, 'Lorena Alexandra', 'Santos Linares', 'Didi', 'ale@gmail.com', 1, 'aldf', '123654', 'scrypt:32768:8:1$p8h87QGEjhRuAtyb$d2ea86a703ebf057c9b9248c15e6472ba998047c1c61a3e6a108e6593340245f2cd290b84261381e68fdc888ca3149dcdb1540603ab65555c72e6dd9d904dd59'),
(7, 'administrador', 'Pro', 'admin', 'admin@gmail.com', 2, 'allayaqui', '321456', 'scrypt:32768:8:1$ovgZxGnEja8hwu3D$e1db7bb44c678cb9ae760385283ef42aa681fe2421607c012cb6a973fc4265c2cc3e64f51b62fd82ca672ea153640a8f2fdc9f92ab7822f89cbccaa03c942b15'),
(8, 'Prueba asdl', 'Prueba 2', 'klajdslkajsdflkja', 'aslkdjfalkdf', 1, 'Mas alla', '951', 'scrypt:32768:8:1$H3O89YibmbEO8n0y$85063577da487a1919787a43612e675d4a586025739d79bf363d25fe1857d366015f0c85a7f764c13598370780204055ef254e75f4028f07c00d5496bff47fa2');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lugar`
--
ALTER TABLE `lugar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `lugar_id` (`lugar_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nameUser` (`nameUser`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lugar`
--
ALTER TABLE `lugar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD CONSTRAINT `detallepedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`),
  ADD CONSTRAINT `detallepedido_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`lugar_id`) REFERENCES `lugar` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
