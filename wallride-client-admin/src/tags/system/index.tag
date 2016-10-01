<system-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <h1 th:text="">System</h1>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="table-responsive">
                        <table class="table">
                            <colgroup>
                                <col class="col-sm-3" />
                                <col class="col-sm-9" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>Spring Profile</th>
                                    <td th:text="">default</td>
                                </tr>
                                <tr>
                                    <th>Java Version</th>
                                    <td th:text="">1.7.0</td>
                                </tr>
                                <tr>
                                    <th>Java Vendor</th>
                                    <td th:text="">Oracle Corporation</td>
                                </tr>
                                <tr>
                                    <th>User Timezone</th>
                                    <td th:text="">User Timezone</td>
                                </tr>
                                <tr>
                                    <th>User Locale</th>
                                    <td><span th:text="">en</span>_<span th:text="">US</span></td>
                                </tr>
                                <tr>
                                    <th>Re-index</th>
                                    <td>
                                        <form th:action="" class="form-horizontal" method="post">
                                            <div class="alert alert-success" th:if="">
                                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                <span th:text="">Re-Index started</span>
                                            </div>
                                            <button class="btn btn-sm btn-primary ok" th:text="">Re-Index</button>
                                        </form>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Template Cache</th>
                                    <td>
                                        <form th:action="" class="form-horizontal" method="post">
                                            <div class="alert alert-success" th:if="">
                                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                <span th:text="">Clearing caches...</span>
                                            </div>
                                            <button class="btn btn-sm btn-primary ok" th:text="">Clear Cache</button>
                                        </form>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</system-index>