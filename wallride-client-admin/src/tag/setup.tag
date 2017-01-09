<setup xmlns:th="http://www.thymeleaf.org">
    <div class="container">
        <div class="page-header">
            <h1 th:text="">Setup</h1>
        </div>
        <form action="#" th:action="" th:object="" method="post" class="form-horizontal" role="form">
            <p class="alert alert-danger" th:if="">Oops</p>
            <fieldset>
                <legend th:text="">Website</legend>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Website Title</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend th:text="">Languages</legend>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Default Language</label>
                    <div class="col-sm-5">
                        <select name="defaultLanguage" class="form-control">
                            <option value="" th:text="">Select Default Language</option>
                            <option value="en" th:selected="">English</option>
                            <option value="ja" th:selected="">日本語</option>
                            <option value="de" th:selected="">Deutsch</option>
                            <option value="es" th:selected="">Español</option>
                            <option value="it" th:selected="">Italiano</option>
                            <option value="fr" th:selected="">Français</option>
                            <option value="ru" th:selected="">русский</option>
                            <option value="vi" th:selected="">Tiếng Việt</option>
                        </select>
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Other Languages</label>
                    <div class="col-sm-5">
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="en" th:checked="" /> English</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="ja" th:checked="" /> 日本語</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="de" th:checked="" /> Deutsch</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="es" th:checked="" /> Español</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="it" th:checked="" /> Italiano</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="fr" th:checked="" /> Français</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="ru" th:checked="" /> русский</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="languages" value="vi" th:checked="" /> Tiếng Việt</label></div>
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend th:text="">User</legend>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Login ID</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" placeholder="Login ID" th:attr="" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Password</label>
                    <div class="col-sm-5">
                        <input type="password" th:field="" class="form-control" th:attr="" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">Name</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" th:attr="" class="form-control" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                    <div class="col-sm-5">
                        <input type="text" th:field="" th:attr="" placeholder="Last Name" class="form-control" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
                <div class="form-group" th:classappend="">
                    <label class="col-sm-2 control-label" th:text="">E-mail</label>
                    <div class="col-sm-5">
                        <input type="text" th:field="" class="form-control" th:attr="" placeholder="E-mail" autocomplete="off" />
                        <span class="help-block" th:each="" th:text="" />
                    </div>
                </div>
            </fieldset>
            <br />
            <div class="well">
                <button name="_step.cancel" class="btn btn-default" th:text="">Cancel</button>
                <button name="_step.save" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> <span th:text="">Save</span></button>
            </div>
        </form>
    </div>
</setup>
