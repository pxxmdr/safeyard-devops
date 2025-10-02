/* ====== CONFIGURE AQUI O LOGIN/EMAIL QUE VOCÊ USA PARA GERAR O TOKEN ====== */
DECLARE @login NVARCHAR(150) = N'admin@safeyard.com';

/* ====== Descobrir coluna identificadora do usuário ====== */
DECLARE @idcol SYSNAME = NULL;
IF COL_LENGTH('dbo.users','email')         IS NOT NULL SET @idcol = 'email';
ELSE IF COL_LENGTH('dbo.users','username') IS NOT NULL SET @idcol = 'username';
ELSE IF COL_LENGTH('dbo.users','login')    IS NOT NULL SET @idcol = 'login';
ELSE IF COL_LENGTH('dbo.users','user_name')  IS NOT NULL SET @idcol = 'user_name';
ELSE IF COL_LENGTH('dbo.users','nome_usuario') IS NOT NULL SET @idcol = 'nome_usuario';

IF @idcol IS NULL
    THROW 50001, 'Nao achei coluna de identificacao (email/username/login/user_name/nome_usuario) na tabela dbo.users', 1;

/* ====== Usuario ANTES ====== */
DECLARE @sql NVARCHAR(MAX) = N'SELECT TOP (1) * FROM dbo.users WHERE ' + QUOTENAME(@idcol) + N' = @login';
EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;

/* ====== Marcar como ADMIN nas colunas que existirem ====== */
IF COL_LENGTH('dbo.users','admin') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET admin = 1 WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','is_admin') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET is_admin = 1 WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','isAdmin') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET isAdmin = 1 WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','role') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET role = ''ADMIN'' WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','roles') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET roles = ''ADMIN'' WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','perfil') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET perfil = ''ADMIN'' WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','tipo') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET tipo = ''ADMIN'' WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

IF COL_LENGTH('dbo.users','perfil_nome') IS NOT NULL
BEGIN
  SET @sql = N'UPDATE dbo.users SET perfil_nome = ''ADMIN'' WHERE ' + QUOTENAME(@idcol) + N' = @login';
  EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;
END

/* ====== Usuario DEPOIS ====== */
SET @sql = N'SELECT TOP (1) * FROM dbo.users WHERE ' + QUOTENAME(@idcol) + N' = @login';
EXEC sp_executesql @sql, N'@login NVARCHAR(150)', @login=@login;

