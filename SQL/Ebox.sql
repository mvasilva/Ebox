
CREATE FUNCTION [dbo].[FN_GER_Limpar_Texto] 
(
	@nom_Texto VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @nom_Texto_Limpo VARCHAR(MAX)
	SET @nom_Texto_Limpo = UPPER(@nom_Texto)
		COLLATE sql_latin1_general_cp1250_ci_as

	SET @nom_Texto_Limpo = @nom_Texto_Limpo
		COLLATE sql_latin1_general_cp1251_ci_as



	RETURN @nom_Texto_Limpo

END
GO
/****** Object:  Table [dbo].[TB_BOX_Categoria]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Categoria](
	[cod_Categoria] [int] IDENTITY(1,1) NOT NULL,
	[cod_Categoria_Pai] [int] NULL,
	[dsc_Categoria] [varchar](max) NULL,
	[ind_Publicar] [int] NULL,
	[ind_Ordem] [int] NULL,
	[nom_Categoria] [varchar](500) NULL,
 CONSTRAINT [PK_TB_BOX_Categoria] PRIMARY KEY CLUSTERED 
(
	[cod_Categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[TB_BOX_Documento]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento](
	[cod_Categoria] [int] NULL,
	[cod_Documento] [int] IDENTITY(1,1) NOT NULL,
	[dat_Criacao] [datetime] NULL,
	[dsc_Documento] [varchar](max) NULL,
	[nom_Titulo] [varchar](500) NULL,
	[ind_Publicar] [int] NULL,
	[cod_ArquivoUso] [int] NULL,
	[cod_HistoricoUltimo] [int] NULL,
 CONSTRAINT [PK_TB_BOX_Documento] PRIMARY KEY CLUSTERED 
(
	[cod_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Arquivo]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Arquivo](
	[cod_Arquivo] [int] IDENTITY(1,1) NOT NULL,
	[ind_Versao] [int] NULL,
	[nom_Arquivo] [varchar](500) NULL,
	[nom_Caminho] [varchar](500) NULL,
	[cod_DocumentoTipo] [int] NULL,
	[cod_Documento] [int] NULL,
 CONSTRAINT [PK_TB_BOX_Documento_Arquivo] PRIMARY KEY CLUSTERED 
(
	[cod_Arquivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Historico]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Historico](
	[cod_Documento] [int] NULL,
	[cod_Historico] [int] IDENTITY(1,1) NOT NULL,
	[cod_Usuario] [int] NULL,
	[dat_Registro] [datetime] NULL,
	[dsc_Novidade] [varchar](max) NULL,
 CONSTRAINT [PK_TB_BOX_Documento_Historico] PRIMARY KEY CLUSTERED 
(
	[cod_Historico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Log]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Log](
	[cod_Log] [int] IDENTITY(1,1) NOT NULL,
	[cod_Usuario] [int] NULL,
	[dat_Registro] [datetime] NULL,
	[cod_Documento] [int] NULL,
 CONSTRAINT [PK_TB_BOX_Log] PRIMARY KEY CLUSTERED 
(
	[cod_Log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Perfil]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Perfil](
	[cod_Documento] [int] NOT NULL,
	[cod_Perfil] [int] NOT NULL,
 CONSTRAINT [PK_TB_BOX_Documento_Perfil] PRIMARY KEY CLUSTERED 
(
	[cod_Documento] ASC,
	[cod_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Tag]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Tag](
	[cod_Documento] [int] NOT NULL,
	[cod_Tag] [int] NOT NULL,
 CONSTRAINT [PK_TB_BOX_Documento_Tag] PRIMARY KEY CLUSTERED 
(
	[cod_Documento] ASC,
	[cod_Tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TB_BOX_Documento_Tipo]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Documento_Tipo](
	[cod_Tipo] [int] IDENTITY(1,1) NOT NULL,
	[nom_Tipo] [varchar](500) NULL,
	[nom_Icone] [varchar](500) NULL,
 CONSTRAINT [PK_TB_BOX_Documento_Tipo] PRIMARY KEY CLUSTERED 
(
	[cod_Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[TB_BOX_Tag]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_BOX_Tag](
	[cod_Tag] [int] IDENTITY(1,1) NOT NULL,
	[nom_Tag] [varchar](20) NULL,
 CONSTRAINT [PK_TB_BOX_Tag] PRIMARY KEY CLUSTERED 
(
	[cod_Tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[TB_BOX_Categoria]  WITH CHECK ADD  CONSTRAINT [FK_TB_BOX_Categoria_TB_BOX_Categoria] FOREIGN KEY([cod_Categoria_Pai])
REFERENCES [dbo].[TB_BOX_Categoria] ([cod_Categoria])
GO
ALTER TABLE [dbo].[TB_BOX_Categoria] CHECK CONSTRAINT [FK_TB_BOX_Categoria_TB_BOX_Categoria]
GO
ALTER TABLE [dbo].[TB_BOX_Documento]  WITH CHECK ADD  CONSTRAINT [FK_TB_BOX_Documento_TB_BOX_Categoria] FOREIGN KEY([cod_Categoria])
REFERENCES [dbo].[TB_BOX_Categoria] ([cod_Categoria])
GO
ALTER TABLE [dbo].[TB_BOX_Documento] CHECK CONSTRAINT [FK_TB_BOX_Documento_TB_BOX_Categoria]
GO
ALTER TABLE [dbo].[TB_BOX_Documento_Arquivo]  WITH CHECK ADD  CONSTRAINT [FK_TB_BOX_Documento_Arquivo_TB_BOX_Documento] FOREIGN KEY([cod_Documento])
REFERENCES [dbo].[TB_BOX_Documento] ([cod_Documento])
GO
ALTER TABLE [dbo].[TB_BOX_Documento_Arquivo] CHECK CONSTRAINT [FK_TB_BOX_Documento_Arquivo_TB_BOX_Documento]
GO
ALTER TABLE [dbo].[TB_BOX_Documento_Historico]  WITH CHECK ADD  CONSTRAINT [FK_TB_BOX_Documento_Historico_TB_BOX_Documento] FOREIGN KEY([cod_Documento])
REFERENCES [dbo].[TB_BOX_Documento] ([cod_Documento])
GO
ALTER TABLE [dbo].[TB_BOX_Documento_Historico] CHECK CONSTRAINT [FK_TB_BOX_Documento_Historico_TB_BOX_Documento]
GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Categoria_DEL]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PR_BOX_Categoria_DEL] 
	@cod_Categoria INT
AS
BEGIN
	
	DECLARE
		@qtd_Documento INT = 0,
		@qtd_Categoria_Filha INT = 0,
		@cod_Status INT = 0

	SELECT 
		@qtd_Documento = COUNT(D.cod_Documento)

	FROM 
		TB_BOX_Categoria C
	JOIN
		TB_BOX_Documento D
			ON C.cod_Categoria = D.cod_Categoria
	WHERE
		C.cod_Categoria = @cod_Categoria

	SELECT  
		@qtd_Categoria_Filha = COUNT(C2.cod_Categoria) 
	FROM 
		TB_BOX_Categoria C2 
	WHERE 
		cod_Categoria_Pai = @cod_Categoria


	IF @qtd_Categoria_Filha = 0 BEGIN

		IF @qtd_Documento = 0 BEGIN

			DELETE FROM TB_BOX_Categoria WHERE cod_Categoria = @cod_Categoria

			SET @cod_Status = @cod_Categoria

		END ELSE
		BEGIN
			SET	@cod_Status = -2
		END

	END ELSE
	BEGIN
		SET	@cod_Status = -1
	END

	SELECT @cod_Status

END


GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Categoria_INS_UPD]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Categoria_INS_UPD] 
	@cod_Categoria INT,
	@cod_Categoria_Pai INT,
	@nom_Categoria VARCHAR(500),
	@ind_Ordem INT

AS
BEGIN
	

	
	IF @cod_Categoria = 0 BEGIN
		INSERT INTO TB_BOX_Categoria(			
			cod_Categoria_Pai,
			ind_Publicar,
			nom_Categoria,
			ind_Ordem
			)
		VALUES(
			@cod_Categoria_Pai,
			0,
			@nom_Categoria,
			@ind_Ordem
		)
		SET @cod_Categoria = @@IDENTITY	

	END ELSE
	BEGIN
		UPDATE TB_BOX_Categoria SET
			cod_Categoria_Pai = @cod_Categoria_Pai,
			nom_Categoria = @nom_Categoria,
			ind_Ordem = @ind_Ordem
		WHERE	
			cod_Categoria = @cod_Categoria

	END

	


	SELECT @cod_Categoria cod_Categoria


END


GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Categoria_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Categoria_LST] 
	@ind_Publicar INT = NULL
AS
BEGIN
	
	SELECT 
		C1.nom_Categoria,
		C1.cod_Categoria,
		C1.cod_Categoria_Pai,
		C1.ind_Publicar,
		C1.ind_Ordem,
		C1.dsc_Categoria,
		C2.ind_Publicar
	FROM
		TB_BOX_Categoria C1
	LEFT JOIN
		TB_BOX_Categoria C2
			ON C1.cod_Categoria_Pai = C2.cod_Categoria
	WHERE	
		CASE 
			WHEN C2.ind_Publicar IS NULL THEN C1.ind_Publicar
			WHEN C2.ind_Publicar = 1 AND C1.ind_Publicar = 1  THEN 1
			ELSE 0
		END = @ind_Publicar OR @ind_Publicar IS NULL
	ORDER BY	
		C1.cod_Categoria_Pai,	
		C1.nom_Categoria
END



GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_CategoriaStatus_UPD]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_CategoriaStatus_UPD] 
	@cod_Categoria INT
AS
BEGIN

	UPDATE C SET
		C.ind_Publicar = CASE 
							WHEN C.ind_Publicar = 1 THEN 0
							ELSE 1
						 END
	FROM
		TB_BOX_Categoria C
	WHERE
		cod_Categoria = @cod_Categoria
		
	SELECT 
		ind_Publicar
	FROM
		TB_BOX_Categoria
	WHERE
		cod_Categoria = @cod_Categoria

END


GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_DEL]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Documento_DEL]
	@cod_Documento INT
AS
BEGIN
	
	IF OBJECT_ID('tempdb..#TMP_Arquivo') IS NOT NULL BEGIN DROP TABLE #TMP_Arquivo END
	CREATE TABLE #TMP_Arquivo(
		nom_Arquivo VARCHAR(500),
		nom_Caminho VARCHAR(500)
	);

	DECLARE	
		@cod_Status INT = 0

	BEGIN TRY
		
		DELETE 
			TB_BOX_Documento_Arquivo 
		OUTPUT
			deleted.nom_Arquivo,
			deleted.nom_Caminho
		INTO
			#TMP_Arquivo
		WHERE 
			cod_Documento = @cod_Documento


		DELETE TB_BOX_Documento_Historico WHERE cod_Documento = @cod_Documento
		DELETE TB_BOX_Documento_Perfil WHERE cod_Documento = @cod_Documento
		DELETE TB_BOX_Documento_Tag WHERE cod_Documento = @cod_Documento
		DELETE TB_BOX_Documento WHERE cod_Documento = @cod_Documento

		SET @cod_Status = 1

	END TRY
	BEGIN CATCH
	
	END CATCH

	SELECT @cod_Status cod_Status

	SELECT * FROM #TMP_Arquivo

END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_INS_UPD]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Documento_INS_UPD]
	@cod_Documento INT,
	@cod_Categoria INT,
	@nom_Titulo VARCHAR(500),
	@dsc_Documento VARCHAR(MAX),
	@nom_Tag VARCHAR(MAX),
	@cod_DocumentoTipo INT,
	@cod_Perfil VARCHAR(MAX),
	@nom_Arquivo VARCHAR(500),
	@nom_Caminho VARCHAR(500),
	@ind_Publicar INT,
	@dsc_Novidade VARCHAR(MAX),
	@cod_Usuario INT,
	@ind_FileUpload INT
AS
BEGIN

	IF OBJECT_ID('tempdb..#TMP_Arquivo') IS NOT NULL BEGIN DROP TABLE #TMP_Arquivo END
	IF OBJECT_ID('tempdb..#TMP_Tag') IS NOT NULL BEGIN DROP TABLE #TMP_Tag END
	
	CREATE TABLE #TMP_Arquivo(
		nom_Arquivo VARCHAR(500),
		nom_Caminho VARCHAR(500)
	);

	DECLARE
		@cod_Arquivo INT,
		@cod_Historico INT,
		@cod_Status INT = 0
	
	BEGIN TRY	
	
		IF @cod_Documento = 0 BEGIN

			INSERT
				TB_BOX_Documento(
					cod_Categoria,
					dat_Criacao,
					dsc_Documento,
					nom_Titulo,				
					ind_Publicar
				)
			VALUES(
					@cod_Categoria,
					GETDATE(),
					@dsc_Documento,
					@nom_Titulo,
					@ind_Publicar
			)
		
			SET @cod_Documento = @@IDENTITY

		END
		ELSE BEGIN
			UPDATE
				TB_BOX_Documento
			SET
				cod_Categoria = @cod_Categoria,			
				dsc_Documento = @dsc_Documento,
				nom_Titulo = @nom_Titulo,				
				ind_Publicar = @ind_Publicar
			WHERE	
				cod_Documento = @cod_Documento
		END


		--Arquivo
		IF @ind_FileUpload = 1 BEGIN

			UPDATE
				A
			SET
				A.ind_Versao = A.ind_Versao + 1		
			FROM
				TB_BOX_Documento_Arquivo A
			WHERE
				A.cod_Documento = @cod_Documento

			DELETE
				TB_BOX_Documento_Arquivo
			OUTPUT
				deleted.nom_Arquivo,
				deleted.nom_Caminho
			INTO
				#TMP_Arquivo
			WHERE
				ind_Versao > 6

			INSERT
				TB_BOX_Documento_Arquivo(
					cod_Documento,
					cod_DocumentoTipo,
					nom_Arquivo,
					nom_Caminho,
					ind_Versao
				)
			VALUES(
					@cod_Documento,
					@cod_DocumentoTipo,
					@nom_Arquivo,
					@nom_Caminho,
					1
			)

			SET @cod_Arquivo = @@IDENTITY


			UPDATE
				TB_BOX_Documento
			SET
				cod_ArquivoUso = @cod_Arquivo
			WHERE
				cod_Documento = @cod_Documento

		END

		--TAG
		SELECT
			CONVERT(INT, NULL) cod_Tag,
			VALUE nom_Tag
		INTO
			#TMP_Tag
		FROM
			dbo.FN_SPLIT_STRING(@nom_Tag, ',')

		MERGE 
			TB_BOX_Tag T
		USING 
			#TMP_Tag S
		ON 
			T.nom_Tag = S.nom_Tag    
		WHEN NOT MATCHED THEN
			INSERT (nom_Tag)
			VALUES (s.nom_Tag);

		UPDATE
			TMP
		SET
			TMP.cod_Tag = T.cod_Tag
		FROM
			#TMP_Tag TMP
		JOIN
			TB_BOX_Tag T
				ON TMP.nom_Tag = t.nom_Tag

		DELETE TB_BOX_Documento_Tag WHERE cod_Documento = @cod_Documento

		INSERT
			TB_BOX_Documento_Tag(
				cod_Tag, 
				cod_Documento
			)
		SELECT
			cod_Tag,
			@cod_Documento
		FROM
			#TMP_Tag
	
		--Perfil
		DELETE TB_BOX_Documento_Perfil WHERE cod_Documento = @cod_Documento

		INSERT
			TB_BOX_Documento_Perfil(
				cod_Perfil,
				cod_Documento
			)
		SELECT
			CONVERT(INT, VALUE),
			@cod_Documento
		FROM
			dbo.FN_SPLIT_STRING(@cod_Perfil, ',')


		INSERT
			TB_BOX_Documento_Historico(
				cod_Documento,
				cod_Usuario, 
				dat_Registro, 
				dsc_Novidade 

			)
		VALUES(
				@cod_Documento,
				@cod_Usuario,
				GETDATE(),
				@dsc_Novidade
		)

		SET @cod_Historico = @@IDENTITY

		UPDATE
			TB_BOX_Documento
		SET
			cod_HistoricoUltimo = @cod_Historico
		WHERE
			cod_Documento = @cod_Documento


		SET @cod_Status = 1

	END TRY
	BEGIN CATCH
	
	END CATCH

	SELECT @cod_Status cod_Status

	SELECT * FROM #TMP_Arquivo
	
END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_Log_INS]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Documento_Log_INS]
	@cod_Documento INT,
	@cod_Usuario INT
AS
BEGIN
	INSERT
		TB_BOX_Documento_Log(
			cod_Documento,
			cod_Usuario,
			dat_Registro
		)
	VALUES(
			@cod_Documento,
			@cod_Usuario,
			GETDATE()
	)


END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PR_BOX_Documento_LST] 
	@cod_Categoria INT,
	@cod_Usuario INT,
	@ind_Publicar INT
AS
BEGIN

	DECLARE @ind_PerfilMaster INT = 0
	
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END
	
	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil


	SELECT 
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao 
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo
	JOIN
		TB_BOX_Documento_Perfil DP
			ON DP.cod_Documento = D.cod_Documento	
	WHERE
		(D.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(C.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(DP.cod_Perfil IN(SELECT cod_Perfil FROM #TMP_Perfil) OR @ind_PerfilMaster = 1)
	AND
		C.cod_Categoria = @cod_Categoria
	GROUP BY
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro 
	ORDER BY
		D.nom_Titulo,
		H.dat_Registro DESC
		



END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_LST_ByBuscar]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PR_BOX_Documento_LST_ByBuscar] 
	@nom_Texto VARCHAR(250),
	@cod_Usuario INT,
	@ind_Publicar INT
AS
BEGIN
	
	IF OBJECT_ID('tempdb..#TMP_Tag') IS NOT NULL BEGIN DROP TABLE #TMP_Tag END
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END


	DECLARE
		@nom_Texto_Limpo  VARCHAR(250),
		@ind_PerfilMaster INT = 0

	SET @nom_Texto_Limpo = dbo.FN_GER_Limpar_Texto(@nom_Texto)


	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil

	SELECT
		CONVERT(INT,NULL) cod_Tag,
		VALUE nom_Tag
	INTO
		#TMP_Tag
	FROM
		dbo.FN_SPLIT_STRING(@nom_Texto_Limpo, ' ')
	

	UPDATE
		TMP
	SET
		TMP.cod_Tag = T.cod_Tag
	FROM
		TB_BOX_Tag T
	JOIN
		#TMP_Tag TMP
			ON dbo.FN_GER_Limpar_Texto(T.nom_Tag) = TMP.nom_Tag

	DELETE FROM #TMP_Tag WHERE cod_Tag IS NULL

	INSERT
		TB_BOX_Tag_Log (cod_Tag, cod_Usuario, dat_Registro)
	SELECT
		cod_Tag,
		@cod_Usuario,
		GETDATE()
	FROM
		#TMP_Tag
	

	SELECT 
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao 
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo
	JOIN
		TB_BOX_Documento_Perfil DP
			ON DP.cod_Documento = D.cod_Documento
	JOIN
		TB_BOX_Documento_Tag TAG
			ON TAG.cod_Documento = D.cod_Documento
	JOIN
		#TMP_Tag TMP_Tag
			ON TMP_Tag.cod_Tag = TAG.cod_Tag	
	WHERE
		(D.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(C.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(DP.cod_Perfil IN(SELECT cod_Perfil FROM #TMP_Perfil) OR @ind_PerfilMaster = 1)
	UNION
		SELECT 
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao 
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo
	JOIN
		TB_BOX_Documento_Perfil DP
			ON DP.cod_Documento = D.cod_Documento	
	WHERE
		(D.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(C.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(DP.cod_Perfil IN(SELECT cod_Perfil FROM #TMP_Perfil) OR @ind_PerfilMaster = 1)
	AND
		(
			dbo.FN_GER_Limpar_Texto(D.nom_Titulo) LIKE '%'+@nom_Texto_Limpo+'%'
		OR
			dbo.FN_GER_Limpar_Texto(D.dsc_Documento) LIKE '%'+@nom_Texto_Limpo+'%'
		OR
			dbo.FN_GER_Limpar_Texto(H.dsc_Novidade) LIKE '%'+@nom_Texto_Limpo+'%'
		OR
			dbo.FN_GER_Limpar_Texto(C.nom_Categoria) LIKE '%'+@nom_Texto_Limpo+'%'
		)
	ORDER BY
		D.nom_Titulo,
		H.dat_Registro DESC

		




END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_SEL]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PR_BOX_Documento_SEL] 
	@cod_Documento INT,
	@cod_Usuario INT
AS
BEGIN

	DECLARE 
		@ind_PerfilMaster INT = 0,
		@ind_Permissao INT = 0
	
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END
	
	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil


	SELECT
		@ind_Permissao = 1
	FROM
		#TMP_Perfil P
	JOIN
		TB_BOX_Documento_Perfil DP
			ON P.cod_Perfil = DP.cod_Perfil
			OR (@ind_PerfilMaster = 1)


	SELECT 
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao,
		C.cod_Categoria,
		D.dsc_Documento,
		H.dsc_Novidade,
		A.nom_Arquivo,
		A.nom_Caminho
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo	
	WHERE
		D.cod_Documento = @cod_Documento
	AND
		@ind_Permissao = 1


	SELECT
		T.cod_Tag,
		T.nom_Tag
	FROM
		TB_BOX_Tag T
	JOIN
		TB_BOX_Documento_Tag DT
			ON T.cod_Tag = DT.cod_Tag
			AND DT.cod_Documento = @cod_Documento
	WHERE
		@ind_Permissao = 1

	SELECT
		P.cod_Perfil
	FROM
		PORTAL..TB_GER_Perfil P
	JOIN
		TB_BOX_Documento_Perfil DP
			ON P.cod_Perfil = DP.cod_Perfil
			AND DP.cod_Documento = @cod_Documento
	WHERE
		@ind_Permissao = 1

	SELECT
		A.cod_Arquivo,
		A.ind_Versao,
		A.nom_Arquivo,
		A.nom_Caminho,
		CASE 
			WHEN D.cod_Documento IS NOT NULL THEN 1
			ELSE 0
		END ind_Uso,
		T.cod_Tipo,
		T.nom_Icone,
		T.nom_Tipo
	FROM
		TB_BOX_Documento_Arquivo A
	JOIN
		TB_BOX_Documento_Tipo T
			ON A.cod_DocumentoTipo = T.cod_Tipo
	LEFT JOIN
		TB_BOX_Documento D
			ON D.cod_ArquivoUso = A.cod_Arquivo
	WHERE
		A.cod_Documento = @cod_Documento
	AND
		@ind_Permissao = 1
	ORDER BY
		A.ind_Versao

	SELECT
		H.cod_Historico,
		U.cod_Usuario,
		U.nom_Usuario,
		H.dat_Registro,
		H.dsc_Novidade
	FROM
		TB_BOX_Documento_Historico H
	JOIN
		PORTAL..TB_GER_Usuario U
			ON H.cod_Usuario = U.cod_Usuario
	WHERE
		H.cod_Documento = @cod_Documento
	AND
		@ind_Permissao = 1



END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Documento_Tipo_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Documento_Tipo_LST]
	
AS
BEGIN
	
	SELECT 
		cod_Tipo,
		nom_Tipo
	FROM
		TB_BOX_Documento_Tipo	
	

END


GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoArquivo_SEL]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoArquivo_SEL] 
	@cod_Documento INT,
	@cod_Usuario INT
AS
BEGIN
	DECLARE 
		@ind_PerfilMaster INT = 0,
		@ind_Permissao INT = 0
	
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END
	
	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil

	SELECT
		@ind_Permissao = 1
	FROM
		#TMP_Perfil P
	JOIN
		TB_BOX_Documento_Perfil DP
			ON P.cod_Perfil = DP.cod_Perfil
			OR (@ind_PerfilMaster = 1)



	SELECT
		A.cod_Arquivo,
		A.ind_Versao,
		A.nom_Arquivo,
		A.nom_Caminho,
		T.cod_Tipo,
		T.nom_Icone,
		T.nom_Tipo 
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo T
			ON T.cod_Tipo  = A.cod_DocumentoTipo				
	WHERE
		D.cod_Documento = @cod_Documento
	AND
		@ind_Permissao = 1

END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoArquivo_UPD]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoArquivo_UPD] 
	@cod_Arquivo INT
AS
BEGIN	

	UPDATE
		D
	SET
		D.cod_ArquivoUso = @cod_Arquivo
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_Documento = A.cod_Documento
	WHERE
		A.cod_Arquivo = @cod_Arquivo

END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoAtualizadoRanking_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoAtualizadoRanking_LST] 	
	@cod_Usuario INT,
	@ind_Publicar INT
AS
BEGIN
	DECLARE @ind_PerfilMaster INT = 0
	
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END
	
	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil


	SELECT 
		TOP 10
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao 
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo
	JOIN
		TB_BOX_Documento_Perfil DP
			ON DP.cod_Documento = D.cod_Documento	
	WHERE
		(D.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(C.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(DP.cod_Perfil IN(SELECT cod_Perfil FROM #TMP_Perfil) OR @ind_PerfilMaster = 1)
	
	GROUP BY
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro 
	ORDER BY
		D.nom_Titulo,
		H.dat_Registro DESC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoDownloadRanking_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoDownloadRanking_LST] 	
	@cod_Usuario INT,
	@ind_Publicar INT
AS
BEGIN
	DECLARE @ind_PerfilMaster INT = 0
	
	IF OBJECT_ID('tempdb..#TMP_Perfil') IS NOT NULL BEGIN DROP TABLE #TMP_Perfil END
	IF OBJECT_ID('tempdb..#TMP_Documento') IS NOT NULL BEGIN DROP TABLE #TMP_Documento END
	
	SELECT
		P.cod_Perfil
	INTO
		#TMP_Perfil
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PM
			ON PM.cod_Permissao = PP.cod_Permissao
	JOIN
		TB_GER_Usuario_Perfil UP
			ON UP.cod_Perfil = P.cod_Perfil
			AND UP.cod_Usuario = @cod_Usuario
	WHERE
		PM.cod_Modulo = 16
	GROUP BY
		P.cod_Perfil

	SELECT
		@ind_PerfilMaster =
		CASE 
			WHEN cod_Perfil IN(1,34) THEN 1
		END
	FROM
		#TMP_Perfil


	SELECT 
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro dat_Atualizacao
	INTO
		#TMP_Documento		
	FROM
		TB_BOX_Documento D
	JOIN
		TB_BOX_Categoria C
			ON D.cod_Categoria = C.cod_Categoria
	JOIN
		TB_BOX_Documento_Historico H
			ON D.cod_HistoricoUltimo = H.cod_Historico
	JOIN
		TB_BOX_Documento_Arquivo A
			ON D.cod_ArquivoUso = A.cod_Arquivo
	JOIN
		TB_BOX_Documento_Tipo TP
			ON A.cod_DocumentoTipo = TP.cod_Tipo
	JOIN
		TB_BOX_Documento_Perfil DP
			ON DP.cod_Documento = D.cod_Documento	
	WHERE
		(D.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(C.ind_Publicar = @ind_Publicar OR @ind_Publicar IS NULL)
	AND
		(DP.cod_Perfil IN(SELECT cod_Perfil FROM #TMP_Perfil) OR @ind_PerfilMaster = 1)	
	GROUP BY
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		TP.cod_Tipo,
		TP.nom_Tipo,
		TP.nom_Icone,
		H.dat_Registro 



	SELECT TOP 10
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		D.cod_Tipo,
		D.nom_Tipo,
		D.nom_Icone,
		D.dat_Atualizacao,
		COUNT(DL.cod_Log) val_Download
	FROM
		#TMP_Documento D
	JOIN
		TB_BOX_Documento_Log DL
			ON D.cod_Documento = DL.cod_Documento
			AND DL.cod_Usuario = @cod_Usuario	
	GROUP BY
		D.cod_Documento,
		D.nom_Titulo,
		D.dat_Criacao,
		D.ind_Publicar,
		D.cod_Tipo,
		D.nom_Tipo,
		D.nom_Icone,
		D.dat_Atualizacao


	
END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoStatus_UPD]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoStatus_UPD]
	@cod_Documento INT
AS
BEGIN
	
	UPDATE D SET
		D.ind_Publicar = CASE 
							WHEN D.ind_Publicar = 1 THEN 0
							ELSE 1
						 END
	FROM
		TB_BOX_Documento D
	WHERE
		D.cod_Documento = @cod_Documento
		
	SELECT 
		ind_Publicar
	FROM
		TB_BOX_Documento
	WHERE
		cod_Documento = @cod_Documento
END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_DocumentoTipo_SEL]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_DocumentoTipo_SEL] 
	@nom_Extensao VARCHAR(500)
AS
BEGIN
	DECLARE
		@cod_Tipo INT = 2


	--Video
	IF @nom_Extensao IN('.asf', '.avi', '.dvr-ms', '.m1v', '.mp2', '.mp2v', '.mpe', '.mpeg', '.mpg', '.mpv2', '.wm', '.wmv', '.mp4') BEGIN

		SET @cod_Tipo = 1

	END

	--Word
	IF @nom_Extensao IN('.doc','.docx','.dotx') BEGIN

		SET @cod_Tipo = 3

	END
	
		--Excel
	IF @nom_Extensao IN('.xls','.xlsx','..xlsm','.xlsb') BEGIN

		SET @cod_Tipo = 4

	END
	
	
		--Áudio
	IF @nom_Extensao IN('.aif', '.aifc', '.aiff', '.asf', '.au', '.mp2', '.mp3', '.mpa', '.snd', '.wav', '.wma') BEGIN

		SET @cod_Tipo = 5

	END
	
		--Imagem
	IF @nom_Extensao IN('.bmp', '.dib', '.emf', '.gif', '.jfif', '.jpe', '.jpeg', '.jpg', '.png', '.tif', '.tiff' , '.wmf') BEGIN

		SET @cod_Tipo = 6

	END
	
		--PowerPoint
	IF @nom_Extensao IN('.pptm,' ,'.potm', '.potx', '.ppam', '.ppsx',  '.ppsm', '.sldx', '.sldm',  '.thmx') BEGIN

		SET @cod_Tipo = 7

	END
		
		--Texto
	IF @nom_Extensao IN('.txt' , '.csv') BEGIN

		SET @cod_Tipo = 8

	END
			
		--Compactado
	IF @nom_Extensao IN('.zip' , '.rar') BEGIN

		SET @cod_Tipo = 9

	END
			
		--PDF
	IF @nom_Extensao IN('.pdf') BEGIN

		SET @cod_Tipo = 10

	END
	
	
	
	
	Select 
		cod_Tipo,
		nom_Tipo
	FROM
		TB_BOX_Documento_Tipo
	WHERE
		cod_Tipo = @cod_Tipo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Perfil_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Perfil_LST] 
	
AS
BEGIN	
	SELECT
		P.cod_Perfil,
		P.nom_Perfil 
	FROM
		TB_GER_Perfil P
	JOIN
		TB_GER_Perfil_Permissao PP
			ON P.cod_Perfil = PP.cod_Perfil
	JOIN
		TB_GER_Permissao PE
			ON PE.cod_Permissao = PP.cod_Permissao
	WHERE
		PE.cod_Modulo = 16
	AND
		P.cod_Perfil <> 1
	GROUP BY
		P.cod_Perfil,
		P.nom_Perfil 
END


GO
/****** Object:  StoredProcedure [dbo].[PR_BOX_Tag_LST]    Script Date: 12/12/2015 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PR_BOX_Tag_LST]
	@nom_Tag VARCHAR(20)
AS
BEGIN
	
	SELECT
		cod_Tag,
		nom_Tag
	FROM
		TB_BOX_Tag
	WHERE
		nom_Tag LIKE '%'+@nom_Tag+'%'

END


GO
