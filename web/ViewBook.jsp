<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Admin Page</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="./style/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed" style="overflow-x: hidden">

        <%@include file="./Navbar.jsp"  %>

        <div id="layoutSidenav">
            <%@include file="./SidebarAdmin.jsp" %>

            <div id="layoutSidenav_content">
                <main>
                    <section>
                        <div class="container py-5">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="card mb-4 text-center">
                                        <img src="${book.img}" alt="avatar" style="width: 90%; height: auto; object-fit: cover;">
                                        <h5 class="my-3">${book.bookid}</h5>
                                    </div>
                                </div>
                                <div class="col-lg-8 ">
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger" role="alert">
                                            ${errorMessage}
                                        </div>
                                    </c:if>

                                    <form action="UpdateBook" method="post" enctype="multipart/form-data" class="card mb-4">
                                        <input type="hidden" name="bookid" value="${book.bookid}"/>
                                        <div class="card-body">
                                            <!-- Book Name Field -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Book Name</label>
                                                <div class="col-sm-9">
                                                    <input style="width:70%" type="text" name="name" value="${book.name}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Author Field -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Author</label>
                                                <div class="col-sm-9">
                                                    <input name="author" type="text" value="${book.author}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Category Dropdown -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Category</label>
                                                <div class="col-sm-9">
                                                    <select name="category" required>
                                                        <c:forEach items="${category}" var="i">
                                                            <option value="${i.category_id}" ${i.category_id == book.category ? "selected" : ""}>
                                                                ${i.category_name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Publisher Field -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Publisher</label>
                                                <div class="col-sm-9">
                                                    <input name="publisher" type="text" value="${book.publisher}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Language Field -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Language</label>
                                                <div class="col-sm-9">
                                                    <input name="language" type="text" value="${book.language}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Total and Current Quantity Fields -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Total Quantity</label>
                                                <div class="col-sm-9">
                                                    <input name="total" type="number" value="${book.total}" required />
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Current Quantity</label>
                                                <div class="col-sm-9">
                                                    <input name="current" type="number" value="${book.current}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Position Field -->
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Position</label>
                                                <div class="col-sm-9">
                                                    <input name="position" type="text" value="${book.position}" required />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Hidden Input for Avatar URL and File Upload -->
                                            <input name="avt" type="hidden" value="${book.img}" />
                                            <div class="row">
                                                <label class="col-sm-3 mb-0">Update Cover Image</label>
                                                <div class="col-sm-9">
                                                    <input type="file" name="avtFile" />
                                                </div>
                                            </div>
                                            <hr>

                                            <!-- Submit Button -->
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Book</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </section>
                </main>

                <%@include file="./Footer.jsp"%>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="./js/scripts.js"></script>
    </body>
</html>
