/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyennt.subject;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import tuyennt.utils.DBHelper;

/**
 *
 * @author PC
 */
public class SubjectDAO implements Serializable {

    private final int RECORDS_IN_PAGE = 20;
    private List<SubjectDTO> subjectList;

    public List<SubjectDTO> getSubjectList() {
        return subjectList;
    }

    public void getAllSubjectByStudent() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select subjectID,subjectName,time,statusID "
                        + "from Subject "
                        + "where statusID = 0";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String subjectID = rs.getString("subjectID");
                    String subjectName = rs.getString("subjectName");
                    String time = rs.getString("time");
                    int statusID = rs.getInt("statusID");
                    SubjectDTO dto = new SubjectDTO(subjectID, subjectName, time, statusID);
                    if (this.subjectList == null) {
                        this.subjectList = new ArrayList<>();
                    }
                    this.subjectList.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void getAllSubject() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select subjectID,subjectName,time,statusID "
                        + "from Subject "
                        + "where statusID = 0";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String subjectID = rs.getString("subjectID");
                    String subjectName = rs.getString("subjectName");
                    String time = rs.getString("time");
                    int statusID = rs.getInt("statusID");
                    SubjectDTO dto = new SubjectDTO(subjectID, subjectName, time, statusID);
                    if (this.subjectList == null) {
                        this.subjectList = new ArrayList<>();
                    }
                    this.subjectList.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public SubjectDTO getSubjectDTO(String sID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SubjectDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select subjectID,subjectName,time,statusID "
                        + "from Subject "
                        + "where subjectID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, sID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String subjectID = rs.getString("subjectID");
                    String subjectName = rs.getString("subjectName");
                    String time = rs.getString("time");
                    int statusID = rs.getInt("statusID");
                    dto = new SubjectDTO(subjectID, subjectName, time, statusID);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }

    public boolean createNewSubject(String subjectName, String time, int statusID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "insert into Subject(subjectID,subjectName,time,statusID) "
                        + "values(NEWID(),?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, subjectName);
                ps.setString(2, time);
                ps.setInt(3, statusID);
                int row = ps.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public void searchSubject(String searchValue, int status,int pageNo) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select subjectID,subjectName,time,statusID "
                        + "from Subject "
                        + "where subjectName like ? and statusID = ? "
                        + "ORDER BY subjectName ASC " 
                        + "offset ? rows " 
                        + "fetch next ? row only";
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + searchValue + "%");
                ps.setInt(2, status);
                int dismissRecord = (pageNo - 1) * RECORDS_IN_PAGE;
                ps.setInt(3, dismissRecord);
                ps.setInt(4, RECORDS_IN_PAGE);
                rs = ps.executeQuery();
                while (rs.next()) {
                    String subjectID = rs.getString("subjectID");
                    String subjectName = rs.getString("subjectName");
                    String time = rs.getString("time");
                    int statusID = rs.getInt("statusID");
                    if (this.subjectList == null) {
                        this.subjectList = new ArrayList<>();
                    }
                    SubjectDTO dto = new SubjectDTO(subjectID, subjectName, time, statusID);
                    this.subjectList.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public int getNumberOfPage(String searchValue, int status) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int size = 0;
        int numofpages = 0;
        try {
            con = DBHelper.makeConnection();
            String sql = "select count(subjectID) as 'size' "
                    + "from Subject "
                    + "where subjectName like ? and statusID = ? ";
            if (con != null) {
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + searchValue + "%");
                ps.setInt(2, status);
                rs = ps.executeQuery();
                if (rs.next()) {
                    size = rs.getInt("size");
                }
            }
            numofpages = (int) Math.ceil(1.0 * size / RECORDS_IN_PAGE);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }

        }
        return numofpages;
    }
}
