<signup>
    <div class="container">
        <form th:action="@{/_admin/signup}" th:object="${form}" method="post" class="form-horizontal form-signup" role="form">
            <input type="hidden" th:field="*{token}" />
            <div class="page-header">
                <h1><span th:text="#{Signup}">Signup</span> <small th:text="${WEBSITE_TITLE}">WallRide</small></h1>
            </div>
            <p class="alert alert-danger" th:if="${#fields.hasErrors('all')}" th:text="#{Error}">Error</p>
            <fieldset>
                <div class="form-group" th:classappend="${#fields.hasErrors('email')}? has-error">
                    <label class="col-sm-2 control-label" th:text="#{Email}">E-mail</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="*{email}" class="form-control" th:attr="placeholder=#{Email}" autocomplete="off" />
                        <span class="help-block" th:each="err : ${#fields.errors('email')}" th:text="${err}" />
                    </div>
                </div>
                <div class="form-group" th:classappend="${#fields.hasErrors('loginId')}? has-error">
                    <label class="col-sm-2 control-label" th:text="#{LoginId}">Login ID</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="*{loginId}" class="form-control" th:attr="placeholder=#{LoginId}" autocomplete="off" />
                        <span class="help-block" th:each="err : ${#fields.errors('loginId')}" th:text="${err}" />
                    </div>
                </div>
                <div class="form-group" th:classappend="${#fields.hasErrors('loginPassword')}? has-error">
                    <label class="col-sm-2 control-label" th:text="#{Password}">Password</label>
                    <div class="col-sm-5">
                        <input type="password" th:field="*{loginPassword}" class="form-control" th:attr="placeholder=#{Password}" placeholder="Password" autocomplete="off" />
                        <span class="help-block" th:each="err : ${#fields.errors('loginPassword')}" th:text="${err}" />
                    </div>
                </div>
                <div class="form-group" th:classappend="${#fields.hasErrors('name.*')}? has-error">
                    <label class="col-sm-2 control-label" th:text="#{Name}">Name</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="*{name.firstName}" placeholder="First Name" th:attr="placeholder=#{FirstName}" class="form-control" />
                        <span class="help-block" th:each="err : ${#fields.errors('name.firstName')}" th:text="${err}" />
                    </div>
                    <div class="col-sm-5">
                        <input type="text" th:field="*{name.lastName}" placeholder="Last Name" th:attr="placeholder=#{LastName}" class="form-control" />
                        <span class="help-block" th:each="err : ${#fields.errors('name.lastName')}" th:text="${err}" />
                    </div>
                </div>
            </fieldset>
            <br/>
            <button class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> <span th:text="#{Signup}">Signup</span></button>
        </form>
    </div>
    <style>
        body {
            padding-top: 40px;
            padding-bottom: 40px;
        }
        .form-signup {
            max-width: 660px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
</signup>
