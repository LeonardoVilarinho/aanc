-- MySQL Script generated by MySQL Workbench
-- 06/27/16 13:24:05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dbaanc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbaanc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbaanc` DEFAULT CHARACTER SET utf8mb4 ;
USE `dbaanc` ;

-- -----------------------------------------------------
-- Table `dbaanc`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`funcionarios` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(11) NULL DEFAULT NULL,
  `nascimento` DATE NULL DEFAULT NULL,
  `area` ENUM('1', '2', '3') NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(16) NOT NULL,
  `logradouro` VARCHAR(100) NULL DEFAULT NULL,
  `numero` INT(11) NULL DEFAULT NULL,
  `bairro` VARCHAR(30) NULL DEFAULT NULL,
  `cidade` VARCHAR(30) NULL DEFAULT NULL,
  `cep` INT(11) NULL DEFAULT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  `ativo` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dbaanc`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`alunos` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(11) NULL DEFAULT NULL,
  `nascimento` DATE NULL DEFAULT NULL,
  `curso` INT NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(16) NOT NULL,
  `logradouro` VARCHAR(100) NULL DEFAULT NULL,
  `numero` INT(11) NULL DEFAULT NULL,
  `bairro` VARCHAR(30) NULL DEFAULT NULL,
  `cidade` VARCHAR(30) NULL DEFAULT NULL,
  `cep` INT(11) NULL DEFAULT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  `ativo` TINYINT(1) NOT NULL DEFAULT 0,
  `cmpendereco` TINYINT(1) NOT NULL DEFAULT 0,
  `reservista` TINYINT(1) NOT NULL DEFAULT 0,
  `hitorico` TINYINT(1) NOT NULL DEFAULT 0,
  `identidade` TINYINT(1) NOT NULL DEFAULT 0,
  `conclusaoem` TINYINT(1) NOT NULL DEFAULT 0,
  `eleitor` TINYINT(1) NOT NULL DEFAULT 0,
  `certidao` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `aluno_curso_idx` (`curso` ASC),
  CONSTRAINT `aluno_curso`
    FOREIGN KEY (`curso`)
    REFERENCES `dbaanc`.`cursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dbaanc`.`advertencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`advertencias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  `data` DATE NOT NULL,
  `funcionario` INT NOT NULL,
  `motivo` VARCHAR(255) NOT NULL,
  `detalhes` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `adv_funcionario_idx` (`funcionario` ASC),
  INDEX `adv_aluno_idx` (`aluno` ASC),
  CONSTRAINT `adv_funcionario`
    FOREIGN KEY (`funcionario`)
    REFERENCES `dbaanc`.`funcionarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `adv_aluno`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`viagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`viagens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `alunos` INT NOT NULL,
  `disponivel` INT NOT NULL,
  `ida` DATE NOT NULL,
  `volta` DATE NOT NULL,
  `instrutor` INT NOT NULL,
  `verba` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `viagens_funcionario_idx` (`instrutor` ASC),
  CONSTRAINT `viagens_funcionario`
    FOREIGN KEY (`instrutor`)
    REFERENCES `dbaanc`.`funcionarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`chamada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`chamada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  `viagem` INT NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `chamada_aluno_idx` (`aluno` ASC),
  INDEX `chamda_viagem_idx` (`viagem` ASC),
  CONSTRAINT `chamada_aluno`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `chamda_viagem`
    FOREIGN KEY (`viagem`)
    REFERENCES `dbaanc`.`viagens` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`notificacaos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`notificacaos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  `tipo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `requisicao_aluno_idx` (`aluno` ASC),
  CONSTRAINT `requisicao_aluno`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`permissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`permissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `permissao_alunos_idx` (`aluno` ASC),
  CONSTRAINT `permissao_alunos`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`liberados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`liberados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  `horario` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `liberados_aluno_idx` (`aluno` ASC),
  CONSTRAINT `liberados_aluno`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbaanc`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbaanc`.`historico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `aluno` INT NOT NULL,
  `horario` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `apoio` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `historico_aluno_idx` (`aluno` ASC),
  CONSTRAINT `historico_aluno`
    FOREIGN KEY (`aluno`)
    REFERENCES `dbaanc`.`alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
