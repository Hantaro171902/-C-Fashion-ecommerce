SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author> Chau Gia Han

CREATE PROCEDURE Product_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(15),
	@ProductId INT = NULL,
	@ProductName VARCHAR(100)  = NULL,
	@Description VARCHAR(MAX) = NULL,
	@Price DECIMAL = NULL,
	@Discount DECIMAL = NULL,
	@Quantity INT = NUL,
	@Size VARCHAR(30) = NULL,
	@Color VARCHAR(50) = NULL,
	@ProductImageUrl VARCHAR(MAX) = NULL,
	@IsActive BIT = FALSE,
	@CategoryId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- GET ALL PRODUCT
	IF(@Action = 'GETALL')
	BEGIN
		SELECT * FROM Product
	END

	-- GET PRODUCT BY ID
	IF(@Action = 'GETBYID')
	BEGIN
		SELECT * FROM Product WHERE ProductId = @ProductId;
	END

	-- INSERT PRODUCT
	IF(@Action = 'INSERT')
	BEGIN
		INSERT INTO Product(ProductName, Description, Price, Discount,
							Quantity, Size, Color,  ProductImageUrl, CategoryId, IsActive, CreatedDate)
		VALUES(@ProductName, @Description, @Price, @Discount, @Quantity,
				@Size, @Color, @ProductImageUrl, @CategoryId, @IsActive, GETDATE())
	END

	-- UPDATE PRODUCT
	IF(@Action = 'UPDATE')
	BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ProductImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF (@UPDATE_IMAGE = 'NO')
			BEGIN
				UPDATE Product
				SET ProductName = @ProductName, IsActive = @IsActive
				WHERE @ProductId = @ProductId
			END
		ELSE
				BEGIN
				UPDATE Product
				SET ProductName = @ProductName,  Description = @Description, Price = @Price,
									Discount = @Discount, Quantity = @Quantity, Size = @Size,
									Color = @Color, ProductImageUrl = @ProductImageUrl, IsActive = @IsActive
				WHERE @ProductId = @ProductId
			END
	END

	-- DELETE PRODUCT
	IF(@Action = 'DELETE')
	BEGIN
		DELETE FROM Product WHERE ProductId = @ProductId
	END

	-- GET ACTIVE PRODUCT
	IF(@Action = 'ACTIVEPRODUCT')
	BEGIN
		SELECT * FROM Product c
		WHERE c.IsActive = 1 ORDER BY c.ProductName
	END

END

DROP PROCEDURE IF EXISTS Product_Crud;