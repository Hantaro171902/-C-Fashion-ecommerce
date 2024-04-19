SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author> Chau Gia Han

CREATE PROCEDURE Users_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(15),
	@UserId INT = NULL,
	@Name VARCHAR(50)  = NULL,
	@UserName VARCHAR(50) = NULL,
	@Email VARCHAR(100) = NULL,
	@Mobile VARCHAR(20) = NULL,
	@Password VARCHAR(50) = NULL,
	@RoleId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- GET ALL USERS
	IF(@Action = 'GETALL')
	BEGIN
		SELECT * FROM Users
	END

	-- GET USERS BY ID
	IF(@Action = 'GETBYID')
	BEGIN
		SELECT * FROM Users WHERE UserId = @UserId;
	END

	-- INSERT USERS
	IF(@Action = 'INSERT')
	BEGIN
		INSERT INTO Users(Name, UserName, Email, Mobile, Password, RoleId, CreatedDate)
		VALUES(@Name, @UserName, @Email, @Mobile, @Password, @RoleId, GETDATE())
	END

	-- UPDATE USERS
	IF(@Action = 'UPDATE')
	BEGIN
	
		UPDATE Users
		SET Name = @Name, UserName = @UserName,  Email = @Email, Mobile = @Mobile, Password = @Password		
		WHERE @UserId = @UserId
			
	END

	-- DELETE USERS
	IF(@Action = 'DELETE')
	BEGIN
		DELETE FROM Users WHERE UserId = @UserId
	END

	-- GET ACTIVE USERS
	/*
	IF(@Action = 'ACTIVEUSERS')
	BEGIN
		SELECT * FROM Users c
		WHERE c.IsActive = 1 ORDER BY c.UserName
	END
	*/

END

DROP PROCEDURE IF EXISTS Users_Crud;