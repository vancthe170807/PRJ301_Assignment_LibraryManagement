package controller;

import DAO.BookDAO;
import DAO.CategoryDAO;
import model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import model.Category;
import model.User;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class UpdateBook extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String LOGIN_PAGE = "Login";
    private static final String VIEW_BOOK_PAGE = "ViewBook.jsp";
    private static final String BOOK_IMAGE_FOLDER = "img/book";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BookDAO bDAO = new BookDAO();
            Book book = bDAO.getBookById(id);

            if (book == null) {
                request.setAttribute("errorMessage", "Book not found.");
                request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
                return;
            }

            CategoryDAO cDAO = new CategoryDAO();
            ArrayList<Category> list = cDAO.getListCategory();
            request.setAttribute("category", list);
            request.setAttribute("book", book);
            request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid book ID format.");
            request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error retrieving book details: " + e.getMessage());
            request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if (session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        try {
            int bookId = Integer.parseInt(request.getParameter("bookid"));
            String name = request.getParameter("name");
            String author = request.getParameter("author");
            int category = Integer.parseInt(request.getParameter("category"));
            String publisher = request.getParameter("publisher");

            String avt = handleFileUpload(request, bookId);
            if (avt == null) {
                avt = request.getParameter("avt"); // Use existing avatar if no file uploaded
            }

            String language = request.getParameter("language");
            int total = Integer.parseInt(request.getParameter("total"));
            int current = Integer.parseInt(request.getParameter("current"));
            String position = request.getParameter("position");

            if (total >= current) {
                Book newBook = new Book(bookId, name, author, avt, category, publisher, language, total, current, position);
                BookDAO bookDAO = new BookDAO();
                bookDAO.updateBook(newBook);
                response.sendRedirect("UpdateBook?id=" + bookId);
            } else {
                request.setAttribute("errorMessage", "Total quantity cannot be less than the current quantity.");
                request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format.");
            request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error updating book: " + e.getMessage());
            request.getRequestDispatcher(VIEW_BOOK_PAGE).forward(request, response);
        }
    }

    private String handleFileUpload(HttpServletRequest request, int bookId) throws IOException, ServletException {
        Part filePart = request.getPart("avtFile");
        if (filePart != null && filePart.getSize() > 0) {
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + BOOK_IMAGE_FOLDER;

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String fileName = "book" + bookId + fileExtension;
            String filePath = uploadFilePath + File.separator + fileName;

            filePart.write(filePath);
            return BOOK_IMAGE_FOLDER + "/" + fileName;
        }
        return null;
    }
}
