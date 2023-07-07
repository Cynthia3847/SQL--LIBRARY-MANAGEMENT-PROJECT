/*      Analyzing Library Management Projects

This project is to understand the activities of the library, involving the borrowing of books, the types of books and authors in the library.

This will be done by answering these questions :
1- How many copies of the book titled "The Lost Tribe" are owned by the 
   library branch whose name is "Sharpstown"? 
2- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
3- Retrieve the names of all borrowers who do not have any books checked out.
4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is '2018-02-03', 
   retrieve the book title, the borrower's name, and the borrower's address
5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch
6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books
   checked out
7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the 
   library branch whose name is "Central".


The database consists of seven(7) table, db_librarymanagement.
Table definition:

tbl_book: Table containing BookID,Book Tittle and Publishers Name. (3 columns)
tbl_book_authors: containing Author names, Author id and bookid. (3 columns)
tbl_book_copies: contains number of copies of books in the library. (4 columns)
tbl_book_loans:  contains the number of books loaned out by the library, date loaned and due dates. (6 columns)
tbl_borrowers: contains names of borrowers, addresses, phone numbers and card numbers.(4 columns)
tbl_library_branch: contains library branch name, branch addresses and branch id. (3 columns)
tbl_publisher: contains publisher name, addresses and phone numbers. (3 columns)
*/
							
                            
                            
                            
                            -- QUESTIONS --

/* #1- How many copies of the book titled "The Lost Tribe" are owned by the 
library branch whose name is "Sharpstown"? */

SELECT book_copies_BranchID AS BranchID ,library_branch_BranchName AS BranchName,
	   book_copies_No_Of_Copies AS NumberofCopies,
	   book_Title AS BookTitle
  FROM tbl_book_copies
  JOIN tbl_book AS book ON book_copies_BookID =book_BookID
  JOIN tbl_library_branch AS branch ON book_copies_BranchID = library_branch_BranchID
 WHERE book_Title = 'The Lost Tribe'  
   AND library_branch_BranchName = 'Sharpstown';
   
/* ANSWER:
Five (5) copies of the book titled "The Lost Tribe" are owned by the 
library branch whose name is "Sharpstown"*/

   
/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */
   
SELECT book_copies_BranchID AS BranchID, library_branch_BranchName AS BranchName,
	   book_copies_No_Of_Copies AS NumberofCopies,
	   book_Title AS BookTitle
  FROM tbl_book_copies
 INNER JOIN tbl_book AS book ON book_copies_BookID = book_BookID
 INNER JOIN tbl_library_branch AS branch ON book_copies_BranchID = library_branch_BranchID
 WHERE book_Title = "The Lost Tribe"; 
 
 /* ANSWER:
 FIVE (5) copies of the book titled "The Lost Tribe" are owned by each library branch*/
 
 
   
/* #3- Retrieve the names of all borrowers who do not have any books checked out. */

SELECT borrower_BorrowerName 
  FROM tbl_borrower
 WHERE NOT EXISTS
 (SELECT * FROM tbl_book_loans
 WHERE book_loans_CardNo = borrower_CardNo);
 -- OR --
/*SELECT borrower_BorrowerName
  FROM tbl_borrower
  LEFT JOIN tbl_book_loans  ON borrower_CardNo = book_loans_CardNo
 WHERE book_loans_CardNo IS NULL;*/
-- OR-- 
/*SELECT borrower_BorrowerName 
  FROM tbl_borrower 
 WHERE borrower_CardNo NOT IN (SELECT book_loans_CardNo FROM tbl_book_loans);*/
 
 /* ANSWER:
 There are no borrowers who do not have any books checked out*/


/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is '2018-02-03', 
   retrieve the book title, the borrower's name, and the borrower's address.  */
   
SELECT library_branch_BranchName AS BranchName, book_Title AS BookName,
	   borrower_BorrowerName AS BorrowerName,borrower_BorrowerAddress AS BorrowerAddress,
	   book_loans_DueDate AS DueDate
  FROM tbl_book_loans
  INNER JOIN tbl_book AS Book ON book_loans_BookID = book_BookID
  INNER JOIN tbl_borrower AS Borrower ON book_loans_CardNo = borrower_CardNo
  INNER JOIN tbl_library_branch AS Branch ON book_loans_BranchID = library_branch_BranchID
  WHERE book_loans_DueDate IN ('2018-02-03') AND library_branch_BranchName = 'Sharpstown';

-- OR --  

/*SELECT book_Title, borrower_BorrowerName, borrower_BorrowerAddress
  FROM tbl_book 
  JOIN tbl_book_loans ON book_BookID = book_loans_BookID
  JOIN tbl_borrower ON book_loans_CardNo = borrower_CardNo
  JOIN tbl_library_branch ON book_loans_BranchID = library_branch_BranchID
  WHERE library_branch_BranchName = "Sharpstown" AND book_loans_DueDate = '2018-02-03';*/
  
  /* ANSWER:
  There is only one borrower whose due date is 2018-02-03 and that is 'Jane Smith' whose address is '1321 4th Street, New York, NY 10014'*/
  
  
  
/* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.  */

SELECT  library_branch_BranchName AS BranchName, COUNT(book_loans_BranchID) AS TotalLoans
   FROM tbl_book_loans
  INNER JOIN tbl_library_branch ON book_loans_BranchID = library_branch_BranchID
  GROUP BY library_branch_BranchName;
  
/* ANSWER:
Sharpstown	10
Central 	11
Saline   	10
Ann Arbor	20
*/
  
  
  /* #6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books
  checked out. */

SELECT borrower_BorrowerName AS BorrowerName, borrower_BorrowerAddress AS BorrowerAddress,
	   COUNT(borrower_BorrowerName) AS BooksCheckedOut
  FROM tbl_book_loans 
 INNER JOIN tbl_borrower ON book_loans_CardNo = borrower_CardNo
 GROUP BY borrower_BorrowerName,borrower_BorrowerAddress
HAVING COUNT(borrower_BorrowerName) >= 5;

-- OR --
/*SELECT borrower_BorrowerName, borrower_BorrowerAddress, COUNT(book_loans_LoansID) AS BooksCheckedOut
FROM tbl_borrower
INNER JOIN tbl_book_loans ON borrower_CardNo = book_loans_CardNo
GROUP BY borrower_BorrowerName, borrower_BorrowerAddress
HAVING COUNT(book_loans_LoansID) >= 5;*/

/* ANSWER:
	BorrowerName	BorrowerAddress	                      BooksCheckedOut
	Jane Smith	    1321 4th Street, New York, NY 10014	        9
	Tom Li	        981 Main Street, Ann Arbor, MI 48104	    12
	Harry Emnace    121 Park Drive, Ann Arbor, MI 48104	         5
	Haley Jackson   231 52nd Avenue New York, NY 10014	         8
	Michael Horford	653 Glen Avenue, Ann Arbor, MI 48104	     5
*/



/* #7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the 
    library branch whose name is "Central".*/

SELECT library_branch_BranchName AS BranchName, book_Title AS Title, book_copies_No_Of_Copies AS NumberofCopies
  FROM tbl_book_authors
 INNER JOIN tbl_book ON book_authors_BookID = book_BookID
 INNER JOIN tbl_book_copies ON book_BookID = book_copies_BookID
 INNER JOIN tbl_library_branch ON book_copies_BranchID = library_branch_BranchID
 WHERE library_branch_BranchName = 'Central' AND book_authors_AuthorName = 'Stephen King';
 
 /* ANSWER:
 	BranchName	Title	NumberofCopies
	Central	      It	       5
	Central	      It	       5
	Central	  The Green Mile	5
	Central	  The Green Mile	5
	Central	The Princess Bride	5
	Central	The Princess Bride	5
	Central	 Fight Club	        5
	Central  Fight Club     	5
	Central	A Game of Thrones	5
	Central	A Game of Thrones	5
	Central	The Lost Tribe	    5
	Central	The Lost Tribe	    5
    */
 
 
 
