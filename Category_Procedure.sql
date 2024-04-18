SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Category_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(15),
	@CategoryId INT = NULL,
	@CategoryName VARCHAR(100)  = NULL,
	@CategoryImageUrl VARCHAR(MAX) = NULL,
	@IsActive BIT = FALSE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- GET ALL CATEGORY
	IF(@Action = 'GETALL')
	BEGIN
		SELECT * FROM Category
	END

	-- INSERT CATEGORY
	IF(@Action = 'INSERT')
	BEGIN
		INSERT INTO Category(CategoryName, CategoryImageUrl, IsActive, CreatedDate)
		VALUES(@CategoryName, @CategoryImageUrl, @IsActive, GETDATE())
	END

	-- UPDATE CATEGORY
	IF(@Action = 'UPDATE')
	BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @CategoryImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF (@UPDATE_IMAGE = 'NO')
			BEGIN
				UPDATE Category
				SET CategoryName = @CategoryName, IsActive = @IsActive
				WHERE @CategoryId = @CategoryId
			END
		ELSE
				BEGIN
				UPDATE Category
				SET CategoryName = @CategoryName, CategoryImageUrl = @CategoryImageUrl, IsActive = @IsActive
				WHERE @CategoryId = @CategoryId
			END
	END

	-- DELETE CATEGORY
	IF(@Action = 'DELETE')
	BEGIN
		DELETE FROM Category WHERE CategoryId = @CategoryId
	END

	-- GET ACTIVE CATEGORY
	IF(@Action = 'ACTIVECATEGORY')
	BEGIN
		SELECT * FROM Category c
		WHERE c.IsActive = 1 ORDER BY c.CategoryName
	END


END
GO
