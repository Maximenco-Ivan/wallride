<user-edit xmlns:th="http://www.thymeleaf.org">
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <h1 th:text="">ユーザー編集</h1>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <form class="form-horizontal" method="post" th:object="" th:action="">
                <input type="hidden" th:field=""  />
                <div class="form-group">
                    <label class="col-sm-2 control-label" th:text="">Thumbnail</label>
                    <div class="col-sm-10">
                        <div class="form-control-static">
                            <a href="https://gravatar.com" target="_blank">Register Gravatar</a>
                        </div>
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Name</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Nickname</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" placeholder="Nickname" th:attr="" class="form-control" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" th:text="">E-Mail</label>
                    <div class="col-sm-10">
                        <input type="text" th:field=""  name="path" class="form-control" th:attr="" placeholder="E-Mail" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Profile</label>
                    <div class="col-sm-10">
                        <textarea type="text" th:field="" class="form-control" style="min-height: 150px" th:attr=""></textarea>
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <div class="btn-group">
                            <button name="_step.save" class="btn btn-primary ok" th:text="">Save</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</user-edit>