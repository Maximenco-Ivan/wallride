<analytics-edit xmlns:th="http://www.thymeleaf.org">
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <h1 th:text="">Google Analytics</h1>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <form th:action="" th:object="" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <div class="alert alert-danger" th:if="">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <span th:text="">There was a problem with your submission.</span>
                            <ul th:if="">
                                <li th:each="" th:text="">Input is incorrect</li>
                            </ul>
                        </div>
                        <div class="form-group" th:classappend="">
                            <label class="col-sm-2 control-label" th:text="">Tracking ID</label>
                            <div class="col-sm-5">
                                <input type="text" th:field="" class="form-control" th:attr="" />
                                <span class="help-block" th:each="" th:text="" />
                            </div>
                        </div>
                        <div class="form-group" th:classappend="">
                            <label class="col-sm-2 control-label" th:text="">Profile ID</label>
                            <div class="col-sm-5">
                                <input type="text" th:field="" class="form-control" th:attr="" />
                                <span class="help-block" th:each="" th:text="" />
                            </div>
                        </div>
                        <div class="form-group" th:classappend="">
                            <label class="col-sm-2 control-label" th:text="">Custom Dimension Index</label>
                            <div class="col-sm-5">
                                <input type="text" th:field="" class="form-control" th:attr="" />
                                <span class="help-block" th:each="" th:text="" />
                            </div>
                        </div>
                        <div class="form-group" th:classappend="">
                            <label class="col-sm-2 control-label" th:text="">Service Account ID</label>
                            <div class="col-sm-5">
                                <input type="text" th:field="" class="form-control" th:attr="" />
                                <span class="help-block" th:each="" th:text="" />
                            </div>
                        </div>
                        <div class="form-group" th:classappend="">
                            <label class="col-sm-2 control-label" th:text="">Service Account P12 File</label>
                            <div class="col-sm-5">
                                <input type="file" th:field="" class="form-control" th:attr="" />
                                <span class="help-block" th:each="" th:text="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <a th:href="" class="btn btn-default" th:text="">Cancel</a>
                                <button type="submit" class="btn btn-primary" th:text="">Save</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</analytics-edit>
