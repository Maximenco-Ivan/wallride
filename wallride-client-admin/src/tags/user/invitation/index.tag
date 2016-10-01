<user-invitation xmlns:th="http://www.thymeleaf.org">
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">Invite New User</h1>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                再送信しました。
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                削除しました。
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <section style="margin:0 0 5em;">
                        <form th:action="" th:object="" method="post" class="form-horizontal" >
                            <fieldset>
                                <div class="form-group" th:classappend="">
                                    <div class="col-sm-12">
                                        <textarea th:field="" class="form-control" th:attr=""></textarea>
                                        <span class="help-block" th:each="" th:text="" />
                                    </div>
                                </div>
                                <div class="form-group" th:classappend="">
                                    <div class="col-sm-12">
                                        <textarea th:field="" class="form-control" th:attr=""></textarea>
                                        <span class="help-block" th:each="" th:text="" />
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-primary" data-loading-text="sending..." th:text="">送信</button>
                                </div>
                            </fieldset>
                        </form>
                    </section>
                    <section>
                        <h2 th:text="">過去の招待状</h2>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th th:text="">招待先</th>
                                    <th th:text="">送信者</th>
                                    <th th:text="">送信日</th>
                                    <th th:text="">承認日</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr th:each="">
                                    <td th:text="" style="font-weight: bold">send@tagbangers.co.jp</td>
                                    <td th:text="">Ogatakex</td>
                                    <td th:text=""></td>
                                    <td th:text="">Waiting</td>
                                    <td>
                                        <ul class="list-inline">
                                            <li style="margin-right:15px"><a th:href=""><span class="glyphicon glyphicon-send"></span> <span th:text="">再送信</span></a></li>
                                            <li><a th:href=""><span class="glyphicon glyphicon-remove"></span> <span th:text="">削除</span></a></li>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </section>
                </div>
            </div>
        </div>
    </div>
</user-invitation>
