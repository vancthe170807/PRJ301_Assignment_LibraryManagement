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

<body class="sb-nav-fixed" style="overflow-x: hidden;">
    <%@include file="./Navbar.jsp" %>

    <div id="layoutSidenav">
        <!-- Sidebar -->
        <%@include file="./SidebarAdmin.jsp" %>

        <div id="layoutSidenav_content">
            <main>
                <section>
                    <div class="container py-5">
                        <div class="row">
                            <!-- User Profile Section -->
                            <div class="col-lg-4">
                                <div class="card mb-4">
                                    <div class="card-body text-center">
                                        <img src="${user.avt}" alt="avatar" class="rounded-circle img-fluid" style="width: 250px; height: 250px; object-fit: cover;">
                                        <h5 class="my-3">${user.username}</h5>
                                    </div>
                                </div>
                            </div>

                            <!-- User Details Section -->
                            <div class="col-lg-8">
                                <form action="UpdateUser" method="post" class="card mb-4">
                                    <input type="hidden" name="username" value="${user.username}" />
                                    <div class="card-body">

                                        <!-- Name Field -->
                                        <div class="row mb-3">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Name</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" name="name" value="${user.name}" readonly class="form-control" />
                                            </div>
                                        </div>

                                        <!-- Gender Field -->
                                        <div class="row mb-3">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Gender</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <c:choose>
                                                    <c:when test="${user.sex}">
                                                        <input class="form-check-input" type="radio" name="sex" value="true" id="male" checked disabled>
                                                        <label class="form-check-label" for="male">Male</label>
                                                        <input class="form-check-input" type="radio" name="sex" value="false" id="female" disabled>
                                                        <label class="form-check-label" for="female">Female</label>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input class="form-check-input" type="radio" name="sex" value="true" id="male" disabled>
                                                        <label class="form-check-label" for="male">Male</label>
                                                        <input class="form-check-input" type="radio" name="sex" value="false" id="female" checked disabled>
                                                        <label class="form-check-label" for="female">Female</label>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <!-- Date of Birth Field -->
                                        <div class="row mb-3">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Date of Birth</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="date" name="datebirth" value="${user.datebirth}" readonly class="form-control" />
                                            </div>
                                        </div>

                                        <!-- Email Field -->
                                        <div class="row mb-3">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Email</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="email" name="gmail" value="${user.gmail}" readonly class="form-control" />
                                            </div>
                                        </div>

                                        <!-- Phone Field -->
                                        <div class="row mb-3">
                                            <div class="col-sm-3">
                                                <p class="mb-0">Phone</p>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" name="phone" value="${user.phone}" readonly class="form-control" />
                                            </div>
                                        </div>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

            <!-- Footer -->
            <%@include file="./Footer.jsp" %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script>
        window.addEventListener('DOMContentLoaded', event => {
            const sidebarToggle = document.body.querySelector('#sidebarToggle');
            if (sidebarToggle) {
                sidebarToggle.addEventListener('click', event => {
                    event.preventDefault();
                    document.body.classList.toggle('sb-sidenav-toggled');
                    localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
                });
            }
        });
    </script>

</body>

</html>
