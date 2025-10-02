-- script_bd.sql
-- DDL do banco SafeYard (Azure SQL)
-- Tabela escolhida para o CRUD obrigatório: CLIENTE

IF OBJECT_ID('dbo.Cliente','U') IS NOT NULL
    DROP TABLE dbo.Cliente;
GO

CREATE TABLE dbo.Cliente (
    id           INT IDENTITY(1,1) PRIMARY KEY,   -- PK auto-incremento
    nome         NVARCHAR(120)   NOT NULL,        -- Nome completo
    cpf          CHAR(11)        NOT NULL UNIQUE, -- CPF sem pontuação
    email        NVARCHAR(150)   NULL,
    telefone     NVARCHAR(20)    NULL,
    dt_cadastro  DATETIME2       NOT NULL
        CONSTRAINT DF_Cliente_dt_cadastro DEFAULT SYSUTCDATETIME()
);
GO

CREATE UNIQUE INDEX IX_Cliente_CPF ON dbo.Cliente(cpf);
GO

SELECT TOP 0 * FROM dbo.Cliente;
GO

