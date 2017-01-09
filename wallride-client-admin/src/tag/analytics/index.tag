<analytics-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid clearfix">
            <div class="pull-left">
                <h1 th:text="">Google Analytics</h1>
            </div>
            <div class="pull-right">
                <div class="btn-group">
                    <a href="#" class="btn btn-default" th:text="">Edit</a>
                    <a href="#" data-toggle="modal" data-target="#delete-modal" class="btn btn-default" th:text="">Delete</a>
                </div>
                <div class="btn-group">
                    <a href="#" data-toggle="modal" data-target="#sync-modal" class="btn btn-primary" th:text="">Sync</a>
                </div>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="alert alert-warning" role="alert" th:if="">
                        Google Analytics is not set
                    </div>
                    <table class="table" th:if="">
                        <colgroup>
                            <col class="col-sm-3" />
                            <col class="col-sm-9" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th th:text="">Tracking ID</th>
                                <td th:text=""></td>
                            </tr>
                            <tr>
                                <th th:text="">Profile ID</th>
                                <td th:text=""></td>
                            </tr>
                            <tr>
                                <th th:text="">Custom Dimension Index</th>
                                <td th:text=""></td>
                            </tr>
                            <tr>
                                <th th:text="">Service Account ID</th>
                                <td th:text=""></td>
                            </tr>
                            <tr>
                                <th th:text="">Service Account P12 File</th>
                                <td th:text=""></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- delete-modal -->
        <div id="delete-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="#" method="post">
                        <input type="hidden" name="_method" value="delete" />
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Delete</h4>
                            </div>
                            <div class="modal-body">
                                <p th:text="">Are you sure you want to delete?</p>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                <button class="btn btn-primary" th:text="">Delete</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--/delete-modal -->
        <!-- sync-modal -->
        <div id="sync-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="#" method="post">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Sync</h4>
                        </div>
                        <div class="modal-body">
                            <p th:text="">Are you sure you want to start sync?</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                            <button class="btn btn-primary" th:text="">Sync</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--/sync-modal -->
    </div>
</analytics-index>