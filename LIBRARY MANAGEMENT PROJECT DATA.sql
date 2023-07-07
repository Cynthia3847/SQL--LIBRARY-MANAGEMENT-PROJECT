
CREATE DATABASE db_LibraryManagement;
USE db_LibraryManagement;
	CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(100) PRIMARY KEY NOT NULL,
    publisher_PublisherAddress VARCHAR(200) NOT NULL,
    publisher_PublisherPhone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    book_Title VARCHAR(100) NOT NULL,
    book_PublisherName VARCHAR(100) NOT NULL,
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(100) NOT NULL,
    library_branch_BranchAddress VARCHAR(200) NOT NULL
);

CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    borrower_BorrowerName VARCHAR(100) NOT NULL,
    borrower_BorrowerAddress VARCHAR(200) NOT NULL,
    borrower_BorrowerPhone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    book_loans_BookID INT NOT NULL,
    book_loans_BranchID INT NOT NULL,
    book_loans_CardNo INT NOT NULL,
    book_loans_DateOut VARCHAR(50) NOT NULL,
    book_loans_DueDate VARCHAR(50) NOT NULL,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    book_copies_BookID INT NOT NULL,
    book_copies_BranchID INT NOT NULL,
    book_copies_No_Of_Copies INT NOT NULL,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
); 

CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    book_authors_BookID INT NOT NULL,
    book_authors_AuthorName VARCHAR(50) NOT NULL,
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);



	
	INSERT INTO tbl_publisher
		(publisher_PublisherName, publisher_PublisherAddress, publisher_PublisherPhone)
		VALUES
		('DAW Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Viking','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Signet Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Chilton Books','Not Available','Not Available'),
		('George Allen & Unwin','83 Alexander Ln, Crows Nest NSW 2065, Australia','+61-2-8425-0100'),
		('Alfred A. Knopf','The Knopf Doubleday Group Domestic Rights, 1745 Broadway, New York, NY 10019','212-940-7390'),		
		('Bloomsbury','Bloomsbury Publishing Inc., 1385 Broadway, 5th Floor, New York, NY 10018','212-419-5300'),
		('Shinchosa','Oga Bldg. 8, 2-5-4 Sarugaku-cho, Chiyoda-ku, Tokyo 101-0064 Japan','+81-3-5577-6507'),
		('Harper and Row','HarperCollins Publishers, 195 Broadway, New York, NY 10007','212-207-7000'),
		('Pan Books','175 Fifth Avenue, New York, NY 10010','646-307-5745'),
		('Chalto & Windus','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Harcourt Brace Jovanovich','3 Park Ave, New York, NY 10016','212-420-5800'),
		('W.W. Norton',' W. W. Norton & Company, Inc., 500 Fifth Avenue, New York, New York 10110','212-354-5500'),
		('Scholastic','557 Broadway, New York, NY 10012','800-724-6527'),
		('Bantam','375 Hudson Street, New York, NY 10014','212-366-2000'),
		('Picador USA','175 Fifth Avenue, New York, NY 10010','646-307-5745')		
	;

	SELECT * FROM tbl_publisher;

	INSERT INTO tbl_book
		(book_Title, book_PublisherName)
		VALUES 
		('The Name of the Wind', 'DAW Books'),
		('It', 'Viking'),
		('The Green Mile', 'Signet Books'),
		('Dune', 'Chilton Books'),
		('The Hobbit', 'George Allen & Unwin'),
		('Eragon', 'Alfred A. Knopf'),
		('A Wise Mans Fear', 'DAW Books'),
		('Harry Potter and the Philosophers Stone', 'Bloomsbury'),
		('Hard Boiled Wonderland and The End of the World', 'Shinchosa'),
		('The Giving Tree', 'Harper and Row'),
		('The Hitchhikers Guide to the Galaxy', 'Pan Books'),
		('Brave New World', 'Chalto & Windus'),
		('The Princess Bride', 'Harcourt Brace Jovanovich'),
		('Fight Club', 'W.W. Norton'),
		('Holes', 'Scholastic'),
		('Harry Potter and the Chamber of Secrets', 'Bloomsbury'),
		('Harry Potter and the Prisoner of Azkaban', 'Bloomsbury'),
		('The Fellowship of the Ring', 'George Allen & Unwin'),
		('A Game of Thrones', 'Bantam'),
		('The Lost Tribe', 'Picador USA');

	SELECT * FROM tbl_book WHERE book_PublisherName = 'George Allen & Unwin';

	INSERT INTO tbl_library_branch
		(library_branch_BranchName, library_branch_BranchAddress)
		VALUES
		('Sharpstown','32 Corner Road, New York, NY 10012'),
		('Central','491 3rd Street, New York, NY 10014'),
		('Saline','40 State Street, Saline, MI 48176'),
		('Ann Arbor','101 South University, Ann Arbor, MI 48104');

	/*UPDATE tbl_library_branch
	SET library_branch_BranchName = 'Central'
	WHERE library_branch_BranchID = 2;*/
	
	SELECT * FROM tbl_library_branch;

	INSERT INTO tbl_borrower
		(borrower_BorrowerName, borrower_BorrowerAddress, borrower_BorrowerPhone)
		VALUES
		('Joe Smith','1321 4th Street, New York, NY 10014','212-312-1234'),
		('Jane Smith','1321 4th Street, New York, NY 10014','212-931-4124'),
		('Tom Li','981 Main Street, Ann Arbor, MI 48104','734-902-7455'),
		('Angela Thompson','2212 Green Avenue, Ann Arbor, MI 48104','313-591-2122'),
		('Harry Emnace','121 Park Drive, Ann Arbor, MI 48104','412-512-5522'),
		('Tom Haverford','23 75th Street, New York, NY 10014','212-631-3418'),
		('Haley Jackson','231 52nd Avenue New York, NY 10014','212-419-9935'),
		('Michael Horford','653 Glen Avenue, Ann Arbor, MI 48104','734-998-1513');
	
	INSERT INTO tbl_book_loans
	(book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES
	(1, 1, 1, '2018-01-01', '2018-02-02'),
	(2, 1, 1, '2018-01-01', '2018-02-02'),
	(3, 1, 1, '2018-01-01', '2018-02-02'),
	(4, 1, 1, '2018-01-01', '2018-02-02'),
	(5, 1, 2, '2018-01-03', '2018-02-03'),
	(6, 1, 2, '2018-01-03', '2018-02-03'),
	(7, 1, 2, '2018-01-03', '2018-02-03'),
	(8, 1, 2, '2018-01-03', '2018-02-03'),
	(9, 1, 2, '2018-01-03', '2018-02-03'),
	(11, 1, 2, '2018-01-03', '2018-02-03'),
	(12, 2, 5, '2017-12-12', '2018-01-12'),
	(10, 2, 5, '2017-12-12', '2018-01-12'),
	(20, 2, 5, '2018-02-03', '2018-03-03'),
	(18, 2, 5, '2018-01-05', '2018-02-05'),
	(19, 2, 5, '2018-01-05', '2018-02-05'),
	(19, 2, 6, '2018-01-03', '2018-02-03'),
	(11, 2, 6, '2018-01-07', '2018-02-07'),
	(1, 2, 6, '2018-01-07', '2018-02-07'),
	(2, 2, 6, '2018-01-07', '2018-02-07'),
	(3, 2, 7, '2018-01-07', '2018-02-07'),
	(5, 2, 7, '2017-12-12', '2018-01-12'),
	(4, 3, 3, '2018-01-09', '2018-02-09'),
	(7, 3, 3, '2018-01-03', '2018-02-03'),
	(17, 3, 3, '2018-01-03', '2018-02-03'),
	(16, 3, 4, '2018-01-03', '2018-02-03'),
	(15, 3, 4, '2018-01-03', '2018-02-03'),
	(15, 3, 4, '2018-01-03', '2018-02-03'),
	(14, 3, 4, '2018-01-03', '2018-02-03'),
	(13, 3, 8, '2018-01-03', '2018-02-03'),
	(13, 3, 8, '2018-01-03', '2018-02-03'),
	(19, 3, 8, '2017-12-12', '2018-01-12'),
	(20, 4, 8, '2018-01-03', '2018-02-03'),
	(1, 4, 8, '2018-01-12', '2018-02-12'),
	(3, 4, 7, '2018-01-03', '2018-02-03'),
	(18, 4, 7, '2018-01-03', '2018-02-03'),
	(12, 4, 2, '2018-01-04', '2018-02-04'),
	(11, 4, 3, '2018-01-15', '2018-02-15'),
	(9, 4, 3, '2018-01-15', '2018-02-15'),
	(7, 4, 7, '2018-01-01', '2018-02-02'),
	(4, 4, 3, '2018-01-01', '2018-02-02'),
	(1, 4, 3, '2017-02-02', '2018-03-02'),
	(20, 4, 3, '2018-01-03', '2018-02-03'),
	(1, 4, 2, '2018-01-12', '2018-02-12'),
	(3, 4, 7, '2018-01-13', '2018-02-13'),
	(18, 4, 7, '2018-01-13', '2018-02-13'),
	(12, 4, 2, '2018-01-14', '2018-02-14'),
	(11, 4, 3, '2018-01-15', '2018-02-15'),
	(9, 4, 3, '2018-01-15', '2018-02-15'),
	(7, 4, 7, '2018-01-19', '2018-02-19'),
	(4, 4, 3, '2018-01-19', '2018-02-19'),
	(1, 4, 3, '2018-01-22', '2018-02-22');


INSERT INTO tbl_book_copies
	(book_copies_BookID, book_copies_BranchID, book_copies_No_Of_Copies)
VALUES
	('1', '1', '5'),
	('2', '1', '5'),
	('3', '1', '5'),
	('4', '1', '5'),
	('5', '1', '5'),
	('6', '1', '5'),
	('7', '1', '5'),
	('8', '1', '5'),
	('9', '1', '5'),
	('10', '1', '5'),
	('11', '1', '5'),
	('12', '1', '5'),
	('13', '1', '5'),
	('14', '1', '5'),
	('15', '1', '5'),
	('16', '1', '5'),
	('17', '1', '5'),
	('18', '1', '5'),
	('19', '1', '5'),
	('20', '1', '5'),
	('1', '2', '5'),
	('2', '2', '5'),
	('3', '2', '5'),
	('4', '2', '5'),
	('5', '2', '5'),
	('6', '2', '5'),
	('7', '2', '5'),
	('8', '2', '5'),
	('9', '2', '5'),
	('10', '2', '5'),
	('11', '2', '5'),
	('12', '2', '5'),
	('13', '2', '5'),
	('14', '2', '5'),
	('15', '2', '5'),
	('16', '2', '5'),
	('17', '2', '5'),
	('18', '2', '5'),
	('19', '2', '5'),
	('20', '2', '5'),
	('1', '3', '5'),
	('2', '3', '5'),
	('3', '3', '5'),
	('4', '3', '5'),
	('5', '3', '5'),
	('6', '3', '5'),
	('7', '3', '5'),
	('8', '3', '5'),
	('9', '3', '5'),
	('10', '3', '5'),
	('11', '3', '5'),
	('12', '3', '5'),
	('13', '3', '5'),
	('14', '3', '5'),
	('15', '3', '5'),
	('16', '3', '5'),
	('17', '3', '5'),
	('18', '3', '5'),
	('19', '3', '5'),
	('20', '3', '5'),
	('1', '4', '5'),
	('2', '4', '5'),
	('3', '4', '5'),
	('4', '4', '5'),
	('5', '4', '5'),
	('6', '4', '5'),
	('7', '4', '5'),
	('8', '4', '5'),
	('9', '4', '5'),
	('10', '4', '5'),
	('11', '4', '5'),
	('12', '4', '5'),
	('13', '4', '5'),
	('14', '4', '5'),
	('15', '4', '5'),
	('16', '4', '5'),
	('17', '4', '5'),
	('18', '4', '5'),
	('19', '4', '5'),
	('20', '4', '5');
 

INSERT INTO tbl_book_authors
	(book_authors_BookID, book_authors_AuthorName)
VALUES
	('1', 'Patrick Rothfuss'),
	('2', 'Stephen King'),
	('3', 'Stephen King'),
	('4', 'Frank Herbert'),
	('5', 'J.R.R. Tolkien'),
	('6', 'J.R.R. Tolkien'),
	('7', 'J.R.R. Tolkien'),
	('8', 'George Orwell'),
	('9', 'George Orwell'),
	('10', 'George Orwell'),
	('11', 'J.R.R. Tolkien'),
	('12', 'J.R.R. Tolkien'),
	('13', 'Stephen King'),
	('14', 'Stephen King'),
	('15', 'Frank Herbert'),
	('16', 'Frank Herbert'),
	('17', 'Patrick Rothfuss'),
	('18', 'Patrick Rothfuss'),
	('19', 'Stephen King'),
	('20', 'Stephen King');
