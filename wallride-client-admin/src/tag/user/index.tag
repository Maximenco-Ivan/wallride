<user-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">Users</h1>
            </div>
            <div class="pull-right">
                <a th:href="" class="btn btn-primary btn-sm" style="margin-top: -3px;"><span class="glyphicon glyphicon-plus"></span> <span th:text="">ユーザーを招待</span></a>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <div class="container-fluid">
            <section class="search-condition">
                <div class="search-condition-simple clearfix">
                    <form class="form-inline" method="get" th:action="" th:object="">
                        <input type="submit" style="visibility:hidden; width:0; height:0;"/>
                        <div class="form-group pull-left">
                            <div class="input-group keyword-search">
                                <input type="text" name="keyword" th:value="" class="form-control" th:attr="" />
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <section class="search-result">
                <form method="post">
                    <input type="hidden" name="token" th:value="" />
                    <div class="search-result-header clearfix">
                        <div class="btn-toolbar wr-bulk-action pull-left">
                            <div class="btn-group">
                                <a th:href="" data-toggle="modal" data-target="#bulk-delete-modal" class="btn btn-default disabled"><span class="glyphicon glyphicon-trash"></span></a>
                            </div>
                        </div>
                        <div class="pagination-group pull-right">
                            <div class="pull-left pagination-summary"><span th:text=""></span> - <span th:text=""></span> / <span th:text=""></span></div>
                            <div class="pull-right">
                                <ul class="pagination paginateon-sm">
                                    <li th:classappend=""><a th:href="" th:text="">Prev</a></li>
                                    <li th:each="" th:classappend=""><a th:href="" th:text=""></a></li>
                                    <li th:classappend=""><a th:href="" th:text="">Next</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover list">
                            <thead>
                                <tr>
                                    <th class="wr-tr-checkbox"><input type="checkbox" /></th>
                                    <th th:text="">名前</th>
                                    <th th:text="">ログインID</th>
                                    <th th:text="">メールアドレス</th>
                                    <th th:text="" class="text-right">投稿記事数</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr th:each="" th:attr="" class="clickable">
                                    <td class="wr-tr-checkbox" style="width:40px"><input type="checkbox" name="ids" th:value="" /></td>
                                    <td th:text=""></td>
                                    <td th:text=""></td>
                                    <td th:text=""></td>
                                    <td th:text="" class="text-right"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- #bulk-delete-modal -->
                    <div id="bulk-delete-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div id="bulk-delete-dialog" class="modal-dialog">
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">Delete Articles</h4>
                                </div>
                                <div class="modal-body">
                                    <p th:text="">Are you sure you want to delete?</p>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="confirmed" value="true" /> <span th:text="">Confirm</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" th:attr="" disabled="true" th:text="">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-delete-modal -->
                    <script th:inline="">
                        // <![CDATA[
                        $(function() {
                            $('#bulk-delete-modal').on('hidden.bs.modal', function() {
                                $(this).removeData('bs.modal');
                            });
                            $('#bulk-delete-modal').on('change', ':input[name="confirmed"]', function() {
                                var confirmed = $(this);
                                $('#bulk-delete-modal .btn-primary').prop('disabled', !confirmed.is(':checked'));
                            });
                            $('#wr-page-content .search-result').on('click', '[data-href]', function(e) {
                                if (!$(e.target).is(':checkbox') && !$(e.target).is('a')){
                                    window.location = $(e.target).closest('tr').data('href');
                                };
                            });
                            $('#wr-page-content .search-result').on('click', '[data-action]', function(e) {
                                var form = $(this).closest('form');
                                form.attr('action', $(this).data('action'));
                                form.submit();
                                e.preventDefault();
                            });
                            $('#wr-page-content .search-result td.wr-tr-checkbox').shiftcheckbox({
                                checkboxSelector: ':checkbox',
                                selectAll: '.search-result th.wr-tr-checkbox'
                            });
                            $('#wr-page-content .search-result td.wr-tr-checkbox').closest('td').click(function(e) {
                                e.stopPropagation();
                            });
                            $('#wr-page-content .search-result td.wr-tr-checkbox :checkbox').change(function(e) {
                                var checked = $(this).prop('checked');
                                if (checked) {
                                    $(this).closest('tr').addClass('warning');
                                }
                                else {
                                    $(this).closest('tr').removeClass('warning');
                                }
                                var checkedSomeone = false;
                                $('#wr-page-content .search-result td.wr-tr-checkbox :checkbox').each(function(i, e) {
                                    if ($(e).prop('checked')) {
                                        checkedSomeone = true;
                                        return;
                                    }
                                });
                                if (checkedSomeone) {
                                    $('#wr-page-content .search-result .wr-bulk-action .btn').removeClass('disabled');
                                }
                                else {
                                    $('#wr-page-content .search-result .wr-bulk-action .btn').addClass('disabled');
                                }
                            });
                        });
                        // ]]>
                    </script>
                </form>
            </section>
        </div>
    </div>
</user-index>