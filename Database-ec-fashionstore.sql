CREATE DATABASE EC_FashionStore;

USE EC_FashionStore;

DROP TABLE IF EXISTS Orders, Payment, Contact, Cart, Wishlist, ProductReview, 
						Users, Roles, ProductImages, Product, SubCategory, Category;

-- Create Table category
CREATE TABLE Category
(
	CategoryId INT PRIMARY KEY IDENTITY(1,1),
	CategoryName VARCHAR(100) NOT NULL,
	-- CategoryImageUrl VARCHAR(MAX) NOT NULL,
	IsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL
)

DROP TABLE Category;

-- Create Table SubCategory
/*
CREATE TABLE SubCategory
(
	SubCategoryId INT PRIMARY KEY IDENTITY(1,1),
	SubCategoryName VARCHAR(100) NOT NULL,
	CategoryId INT NOT NULL,
	IsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
)
*/

-- DROP TABLE SubCategory;

-- Create Table Product
CREATE TABLE Product
(
	ProductId INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(100) NOT NULL,
	-- ShortDescription VARCHAR(200) NOT NULL,
	-- LongDescription VARCHAR(MAX) NOT NULL,
	-- AddictionDescription VARCHAR(MAX) NOT NULL,
	Description VARCHAR(MAX) NOT NULL,
	Price DECIMAL(18,2) NOT NULL,
	Discount DECIMAL(18,2) NOT NULL,
	Quantity INT NOT NULL,
	Size VARCHAR(30) NOT NULL,
	Color VARCHAR(50) NOT NULL,
	ProductImageUrl VARCHAR(MAX) NOT NULL,
	CategoryId INT NOT NULL,
	-- SubCategoryId INT NOT NULL,
	-- Sold INT NOT NULL,
	IsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	
	FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
)

DROP TABLE Product;

-- Create Table ProductImages
CREATE TABLE ProductImages
(
	ImageId INT PRIMARY KEY IDENTITY(1,1),
	ImageUrl VARCHAR(MAX) NOT NULL,
	ProductId INT NOT NULL,
	DefaultImage BIT NOT NULL,
	
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
)

DROP TABLE ProductImages;

-- Create Table Roles
CREATE TABLE Roles
(
	RoleId INT PRIMARY KEY IDENTITY(1,1),
	RoleName VARCHAR(50) NOT NULL
)

DROP TABLE Roles;

INSERT INTO Roles VALUES ('Admin');
INSERT INTO Roles VALUES ('Customer');

-- Create Table Users
CREATE TABLE Users
(
	UserId INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NULL,
	UserName VARCHAR(50) NULL UNIQUE,
	Email VARCHAR(100) NULL,
	Mobile VARCHAR(20) NULL,
	-- Address VARCHAR(MAX) NULL,
	-- PostCode VARCHAR(50) NULL,
	Password VARCHAR(50) NULL,
	RoleId INT NOT NULL,
	-- ImageUrl VARCHAR(MAX) NULL,
	CreatedDate DATETIME NOT NULL,
	
	FOREIGN KEY (RoleId) REFERENCES Roles(RoleId) ON DELETE CASCADE
)

DROP TABLE Users;

-- Create Table ProductReview
CREATE TABLE ProductReview
(
	ReviewId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	UserId INT NOT NULL,
	Review VARCHAR(MAX) NOT NULL,
	Rating INT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
	FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
)

DROP TABLE ProductReview;

-- Create Table Wishlist
CREATE TABLE Wishlist
(
	WishlistId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	UserId INT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
	FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
)

DROP TABLE Wishlist;

-- Create Table Cart
CREATE TABLE Cart
(
	CartId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	UserId INT NOT NULL,
	Quantity INT NOT NULL,
	CreatedDate DATETIME NOT NULL,
	
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
	FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
)

DROP TABLE Cart;

-- Create Table Contact
CREATE TABLE Contact
(
	ContactId INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Subject VARCHAR(200) NOT NULL,
	Message VARCHAR(MAX) NOT NULL,
	CreatedDate DATETIME NOT NULL
)

DROP TABLE Contact;

-- Create Table Payment
CREATE TABLE Payment
(
	PaymentId INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NULL,
	CardNo VARCHAR(50) NULL,
	ExpireDate VARCHAR(50) NULL,
	CvvNo INT NULL,
	Address VARCHAR(MAX) NULL,
	PaymentMode VARCHAR(50) NULL,
)
	
DROP TABLE Payment;

-- Create Table Order
CREATE TABLE Orders
(
	OrderDetailsId INT PRIMARY KEY IDENTITY(1,1),
	OrderNo VARCHAR(MAX) NULL,
	UserId INT NOT NULL,
	ProductId INT NOT NULL,
	Quantity INT NULL,
	OrderDate DATETIME NOT NULL,
	Status VARCHAR(50) NULL,
	IsCancel BIT NOT NULL DEFAULT 0,
	
	FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
)

DROP TABLE Orders;

