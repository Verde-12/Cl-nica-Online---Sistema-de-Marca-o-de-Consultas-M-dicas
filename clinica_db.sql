-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2026 at 10:37 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clinica_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `consultas`
--

CREATE TABLE `consultas` (
  `id` int(11) NOT NULL,
  `paciente_id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `data_consulta` date NOT NULL,
  `hora_consulta` time NOT NULL,
  `status` enum('AGENDADA','CONFIRMADA','CANCELADA','CONCLUIDA','NAO_COMPARECEU') COLLATE utf8mb4_unicode_ci DEFAULT 'AGENDADA',
  `motivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci,
  `diagnostico` text COLLATE utf8mb4_unicode_ci,
  `prescricao` text COLLATE utf8mb4_unicode_ci,
  `cancelamento_motivo` text COLLATE utf8mb4_unicode_ci,
  `cancelado_por` enum('PACIENTE','MEDICO','ADMIN') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consultas`
--

INSERT INTO `consultas` (`id`, `paciente_id`, `medico_id`, `data_consulta`, `hora_consulta`, `status`, `motivo`, `observacoes`, `diagnostico`, `prescricao`, `cancelamento_motivo`, `cancelado_por`, `data_criacao`, `data_atualizacao`) VALUES
(1, 5, 2, '2026-05-22', '13:53:00', 'CONFIRMADA', 'Estou doente', NULL, NULL, NULL, NULL, NULL, '2026-05-21 08:53:15', '2026-05-21 08:54:30'),
(2, 5, 1, '2026-05-25', '14:00:00', 'CONCLUIDA', 'Tenho Sida', '', '', '', NULL, NULL, '2026-05-21 08:56:27', '2026-05-21 08:57:36');

-- --------------------------------------------------------

--
-- Table structure for table `email_log`
--

CREATE TABLE `email_log` (
  `id` int(11) NOT NULL,
  `destinatario` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assunto` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('CONFIRMACAO','CANCELAMENTO','LEMBRETE','RECUPERACAO_SENHA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ENVIADO','FALHOU') COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_envio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `especialidades`
--

CREATE TABLE `especialidades` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `ativo` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `especialidades`
--

INSERT INTO `especialidades` (`id`, `nome`, `descricao`, `ativo`, `data_criacao`) VALUES
(1, 'Clínica Geral', 'Medicina geral e cuidados primários', 1, '2026-05-19 17:39:09'),
(2, 'Cardiologia', 'Especialidade do coração e sistema cardiovascular', 1, '2026-05-19 17:39:09'),
(3, 'Pediatria', 'Medicina para crianças e adolescentes', 1, '2026-05-19 17:39:09'),
(4, 'Ginecologia', 'Saúde feminina e reprodutiva', 1, '2026-05-19 17:39:09'),
(5, 'Ortopedia', 'Ossos, músculos e articulações', 1, '2026-05-19 17:39:09'),
(6, 'Dermatologia', NULL, 1, '2026-05-20 06:08:10'),
(7, 'Neurologia', NULL, 1, '2026-05-20 06:08:10'),
(8, 'Oftalmologia', NULL, 1, '2026-05-20 06:08:10'),
(9, 'Psiquiatria', NULL, 1, '2026-05-20 06:08:10'),
(10, 'Odontologia', NULL, 1, '2026-05-20 06:08:10');

-- --------------------------------------------------------

--
-- Table structure for table `horarios_medico`
--

CREATE TABLE `horarios_medico` (
  `id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `dia_semana` enum('SEGUNDA','TERCA','QUARTA','QUINTA','SEXTA','SABADO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `intervalo_minutos` int(11) DEFAULT '30'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medicos`
--

CREATE TABLE `medicos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `especialidade_id` int(11) NOT NULL,
  `ordem` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default-doctor.png',
  `preco_consulta` decimal(10,2) DEFAULT '0.00',
  `disponivel` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicos`
--

INSERT INTO `medicos` (`id`, `usuario_id`, `especialidade_id`, `ordem`, `telefone`, `bio`, `foto`, `preco_consulta`, `disponivel`, `data_criacao`) VALUES
(1, 2, 1, 'OM-12345', '84 123 4567', 'Médico clínico geral com 10 anos de experiência.', 'default-doctor.png', '500.00', 1, '2026-05-19 17:39:09'),
(2, 3, 2, 'OM-67890', '82 987 6543', 'Cardiologista especializada, formada pela UEM.', 'default-doctor.png', '800.00', 1, '2026-05-19 17:39:09');

-- --------------------------------------------------------

--
-- Table structure for table `notificacoes`
--

CREATE TABLE `notificacoes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `consulta_id` int(11) DEFAULT NULL,
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensagem` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('INFO','SUCESSO','AVISO','ERRO') COLLATE utf8mb4_unicode_ci DEFAULT 'INFO',
  `lida` tinyint(1) DEFAULT '0',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notificacoes`
--

INSERT INTO `notificacoes` (`id`, `usuario_id`, `consulta_id`, `titulo`, `mensagem`, `tipo`, `lida`, `data_criacao`) VALUES
(1, 45, 1, 'Consulta Agendada', 'Consulta marcada para 2026-05-22 às 13:53', 'SUCESSO', 1, '2026-05-21 08:53:15'),
(2, 3, 1, 'Nova Consulta', 'Paciente marcou consulta para 2026-05-22 às 13:53', 'INFO', 0, '2026-05-21 08:53:15'),
(4, 45, 2, 'Consulta Agendada', 'Consulta marcada para 2026-05-25 às 14:00', 'SUCESSO', 1, '2026-05-21 08:56:27'),
(5, 2, 2, 'Nova Consulta', 'Paciente marcou consulta para 2026-05-25 às 14:00', 'INFO', 0, '2026-05-21 08:56:27');

-- --------------------------------------------------------

--
-- Table structure for table `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `genero` enum('M','F','OUTRO') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone_emergencia` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endereco` text COLLATE utf8mb4_unicode_ci,
  `numero_bi` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grupo_sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alergias` text COLLATE utf8mb4_unicode_ci,
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pacientes`
--

INSERT INTO `pacientes` (`id`, `usuario_id`, `data_nascimento`, `genero`, `telefone`, `telefone_emergencia`, `endereco`, `numero_bi`, `grupo_sanguineo`, `alergias`, `data_criacao`) VALUES
(1, 4, '1990-05-15', 'M', '84 555 1234', NULL, 'Av. Eduardo Mondlane, 123, Maputo', 'BI-001234567', NULL, NULL, '2026-05-19 17:39:09'),
(4, 44, NULL, NULL, '84 123 4567', NULL, NULL, NULL, NULL, NULL, '2026-05-20 08:45:35'),
(5, 45, NULL, NULL, '846649929', NULL, NULL, NULL, NULL, NULL, '2026-05-20 08:48:50'),
(6, 63, NULL, NULL, '+258 87 049 2662', NULL, NULL, NULL, NULL, NULL, '2026-05-22 08:27:27');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `senha` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('ADMIN','MEDICO','PACIENTE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PACIENTE',
  `token_recuperacao` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_expiracao` datetime DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acesso` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `tipo`, `token_recuperacao`, `token_expiracao`, `ativo`, `data_criacao`, `ultimo_acesso`) VALUES
(2, 'Dr. João Machava', 'joao.machava@clinica.co.mz', '$2a$12$dvyJ.gXPfr5OrNrCdVVh2OySlH0n44a.C0/3uZRNablEYlObD9QX2', 'MEDICO', NULL, NULL, 1, '2026-05-19 17:39:09', NULL),
(3, 'Dra. Ana Mondlane', 'ana.mondlane@clinica.co.mz', '$2a$12$dvyJ.gXPfr5OrNrCdVVh2OySlH0n44a.C0/3uZRNablEYlObD9QX2', 'MEDICO', NULL, NULL, 1, '2026-05-19 17:39:09', NULL),
(4, 'Carlos Tembe', 'carlos.tembe@gmail.com', '$2a$12$Okmo/Pe4LSsLsXAICD08fuEIBisnREZkPyus2WvOf2MkpcOTQO7ri', 'PACIENTE', NULL, NULL, 1, '2026-05-19 17:39:09', NULL),
(9, 'Administrador', 'admin@clinica.co.mz', '$2a$12$aFtwG.w7kvwCEhG.y7oANeNt6i.MtUYM.nz4x37sivyb4nHHIoIZG', 'ADMIN', NULL, NULL, 1, '2026-05-20 06:26:08', '2026-05-20 09:55:56'),
(44, 'Usuário Teste', 'teste@clinica.com', '$2a$12$1eIR2IXkhtaLLmzEqe0L8OspnVJdV40H.rfTTutYrGaO.5VqvcfkG', 'PACIENTE', NULL, NULL, 1, '2026-05-20 08:45:35', NULL),
(45, 'Edmilson Verde', 'edmilsoninocencio70@gmail.com', '$2a$12$C7FIx2dVuJ22V7C32RLoeewxMqpfsCEbnXVeQMuUyVzj2jQhCotZu', 'PACIENTE', NULL, NULL, 1, '2026-05-20 08:48:49', NULL),
(63, 'Vaneza Daitino', 'vanessamuapeiua@gmail.com', 'vaneza123', 'PACIENTE', '603e8fbc690943cab785ac14f2991d90', '2026-05-22 11:29:31', 1, '2026-05-22 08:27:27', '2026-05-22 10:35:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `medico_id` (`medico_id`);

--
-- Indexes for table `email_log`
--
ALTER TABLE `email_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indexes for table `horarios_medico`
--
ALTER TABLE `horarios_medico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medico_id` (`medico_id`);

--
-- Indexes for table `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `especialidade_id` (`especialidade_id`);

--
-- Indexes for table `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `consulta_id` (`consulta_id`);

--
-- Indexes for table `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `email_log`
--
ALTER TABLE `email_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `horarios_medico`
--
ALTER TABLE `horarios_medico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notificacoes`
--
ALTER TABLE `notificacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`),
  ADD CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`);

--
-- Constraints for table `horarios_medico`
--
ALTER TABLE `horarios_medico`
  ADD CONSTRAINT `horarios_medico_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicos_ibfk_2` FOREIGN KEY (`especialidade_id`) REFERENCES `especialidades` (`id`);

--
-- Constraints for table `notificacoes`
--
ALTER TABLE `notificacoes`
  ADD CONSTRAINT `notificacoes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notificacoes_ibfk_2` FOREIGN KEY (`consulta_id`) REFERENCES `consultas` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
