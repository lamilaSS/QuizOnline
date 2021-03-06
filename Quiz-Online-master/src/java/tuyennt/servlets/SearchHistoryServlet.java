/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyennt.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tuyennt.history.HistoryDAO;
import tuyennt.history.HistoryDTO;
import org.apache.log4j.BasicConfigurator;

/**
 *
 * @author PC
 */
@WebServlet(name = "SearchHistoryServlet", urlPatterns = {"/SearchHistoryServlet"})
public class SearchHistoryServlet extends HttpServlet {

    private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(SearchHistoryServlet.class.getName());

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "searchHistoryPage";
        BasicConfigurator.configure();
        int pageNo = 1;
        try {
            /* TODO output your page here. You may use following sample code. */
            String searchValue = request.getParameter("searchValue");
            String categoryID = request.getParameter("cboCategory");
            String pageNoStr = request.getParameter("pageNo");
            String paging = request.getParameter("page");
            if (pageNoStr != null) {
                pageNo = Integer.parseInt(pageNoStr);
            }
            if (paging != null) {
                if (paging.equals("Previous")) {
                    pageNo -= 1;
                } else if (paging.equals("Next")) {
                    pageNo = pageNo + 1;
                }
            }
            if (pageNo < 1) {
                pageNo = 1;
            }
            if (!searchValue.trim().isEmpty() || !categoryID.trim().isEmpty()) {
                HistoryDAO dao = new HistoryDAO();
                HttpSession session = request.getSession(false);
                if (session != null) {
                    String email = (String) session.getAttribute("EMAIL");
                    dao.searchHistory(searchValue, categoryID, email, pageNo);
                    List<HistoryDTO> result = dao.getListHistory();
                    request.setAttribute("HISTORY_RESULT", result);
                    request.setAttribute("PAGEMAX", dao.getNumberOfPage(email));
                    request.setAttribute("PAGENO", pageNo);
                }

            }
        } catch (SQLException ex) {
            log.error("SearchHistoryServlet_SQL:" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("SearchHistoryServlet_Naming:" + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
