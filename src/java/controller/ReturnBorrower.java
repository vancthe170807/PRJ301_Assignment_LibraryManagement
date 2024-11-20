package controller;

import DAO.BookDAO;
import DAO.BorrowerDAO;
import model.Book;
import model.Borrower;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ReturnBorrower extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Check for valid admin session
        if (session.getAttribute("username") == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
            resp.sendRedirect("Login");
            return;
        }

        String id = req.getParameter("id");
        if (id == null || id.length() == 0) {
            resp.sendRedirect("HomePageAdmin");
            return;
        }

        // Validate and parse bookid
        String bookidStr = req.getParameter("bookid");
        int bookid = 0;
        try {
            bookid = Integer.parseInt(bookidStr);
        } catch (NumberFormatException e) {
            // Redirect or show error if bookid is invalid
            resp.sendRedirect("HomePageAdmin");
            return;
        }

        BookDAO bdao = new BookDAO();
        Book book = bdao.getBookById(bookid);

        // Check if the book exists
        if (book == null) {
            // Redirect or show error if book doesn't exist
            resp.sendRedirect("HomePageAdmin");
            return;
        }

        // Update quantity of the book when returned
        book.setCurrent(book.getCurrent() + 1);
        bdao.updateBook(book);

        // Get the borrower record
        BorrowerDAO bDAO = new BorrowerDAO();
        Borrower b = bDAO.getBorrowerById(id);

        // Check if borrower exists
        if (b == null) {
            // Redirect or show error if borrower doesn't exist
            resp.sendRedirect("HomePageAdmin");
            return;
        }

        // Update borrower status to 'Returned' and update the return date
        b.setStatus("Returned");

        // Format the current date and set it as the return date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        b.setBorrow_to(sdf.format(new Date()));

        bDAO.updateBorrower(b);

        // Redirect to the list of borrowed items
        resp.sendRedirect("ListBorrowAdmin?action=borrowed");
    }

}
