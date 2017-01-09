<signup>
    <div class="container">
        <form th:action="" th:object="" method="post" class="form-horizontal form-signup" role="form">
            <input type="hidden" th:field="" />
            <div class="page-header">
                <h1><span th:text="">Signup</span> <small th:text="">WallRide</small></h1>
            </div>
            <p class="alert alert-danger" th:if="" th:text="">Error</p>
            <fieldset>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">E-mail</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Login ID</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Password</label>
                    <div class="col-sm-5">
                        <input type="password" th:field="" class="form-control" th:attr="" placeholder="Password" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Name</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" placeholder="First Name" th:attr="" class="form-control" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                    <div class="col-sm-5">
                        <input type="text" th:field="" placeholder="Last Name" th:attr="" class="form-control" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
            </fieldset>
            <br/>
            <button class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> <span th:text="">Signup</span></button>
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

