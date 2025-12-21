package com.example;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class StudentServlet extends HttpServlet {

    private static final List<Student> studentList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "new":
                request.getRequestDispatcher("addStudent.jsp")
                       .forward(request, response);
                break;

            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("student", studentList.get(id));
                request.getRequestDispatcher("editStudent.jsp")
                       .forward(request, response);
                break;

            case "list":
            default:
                request.setAttribute("students", studentList);
                request.getRequestDispatcher("listStudents.jsp")
                       .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");

        if (name != null && email != null) {
            studentList.add(new Student(name, email));
        }

        response.sendRedirect("student?action=list");
    }
}
