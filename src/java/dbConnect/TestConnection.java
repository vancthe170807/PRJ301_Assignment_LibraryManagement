/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dbConnect;

import DAO.BookDAO;
import DAO.BorrowerDAO;
import DAO.UserDAO;
import model.Book;
import model.Borrower;
import model.User;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

public class TestConnection {

    public static void main(String[] args) throws Exception {
        UserDAO userDao = new UserDAO();
        System.out.println(userDao.findUser("admin", "admin").isRole());
   }
}
