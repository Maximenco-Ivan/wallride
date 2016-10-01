<article-index xmlns:th="http://www.thymeleaf.org">
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">Articles</h1>
            </div>
            <div class="pull-right">
                <a href="" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New</span></a>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <section class="search-condition">
            <div class="navbar">
                <div class="container-fluid">
                    <form id="search-form" class="navbar-form navbar-left" method="get" th:action=""${form}">
                        <post-status-select2 />
                        <input type="hidden" class="select2" th:field="" data-url="" th:placeholder=""/>
                        <input type="hidden" class="select2" th:field="" data-url="" th:placeholder=""/>
                        <input type="hidden" class="select2" th:field="" data-url="" th:placeholder=""/>
                        <input type="text" name="keyword" th:value="" class="form-control" th:attr=""/>
                        <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                    </form>
                </div>
            </div>
        </section>

        <div class="container-fluid">
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Article Deleted.</span>
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Articles Published.</span>
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Articles Unpublished.</span>
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Articles Deleted.</span>
            </div>
            <section class="search-result">
                <form method="post">
                    <div class="search-result-header clearfix">
                        <div class="btn-toolbar pull-left">
                            <div class="wr-bulk-action btn-group">
                                <a href="#" data-toggle="modal" data-target="#bulk-delete-modal" class="btn btn-default disabled"><span class="glyphicon glyphicon-trash"></span></a>
                            </div>
                            <div class="wr-bulk-action btn-group">
                                <a href="#" data-toggle="modal" data-target="#bulk-publish-modal" class="btn btn-default disabled" th:text="">Publish</a>
                                <a href="#" data-toggle="modal" data-target="#bulk-unpublish-modal" class="btn btn-default disabled" th:text="">Unpublish</a>
                            </div>
                        </div>
                        <div class="pagination-group pull-right">
                            <div class="pull-left pagination-summary"><span th:text=""></span> - <span th:text=""></span> / <span th:text=""></span></div>
                            <div class="pull-right">
                                <ul class="pagination paginateon-sm">
                                    <li th:classappend=""#" th:text="">Prev</a></li>
                                    <li th:each="" th:classappend=""#" th:text=""></a></li>
                                    <li th:classappend=""#" th:text="">Next</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="wr-tr-checkbox" style="width:40px"><input type="checkbox"/></th>
                                    <th th:text="">Status</th>
                                    <th th:text="">Title</th>
                                    <th th:text="">Categories</th>
                                    <th th:text="">Tags</th>
                                    <th th:text="">Author</th>
                                    <th th:text="">Date</th>
                                    <th class="text-right" th:text="">Views</th>
                                    <th class="text-center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr th:each="" data-href="" class="clickable">
                                    <td class="wr-tr-checkbox" style="width:40px"><input type="checkbox" name="ids" th:value="" th:attr=""/></td>
                                    <td th:class=""">Status</td>
                                    <td th:text=""font-weight: bold;">Title</td>
                                    <td><th:block th:each=""><a href="#" th:text=""></a> <span th:unless="">&nbsp; | &nbsp;</span></th:block></td>
                                    <td><th:block th:each=""><a href="#" th:text=""></a> <span th:unless="">&nbsp; | &nbsp;</span></th:block></td>
                                    <td><a th:if=""#" th:text="">Author</a></td>
                                    <td th:text="">2013/10/24</td>
                                    <td class="text-right" th:text="">0</td>
                                    <td class="text-center"><a href=""><span class="glyphicon glyphicon-pencil"></span> <span th:text="">Edit</span></a></td>
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
                                    <h4 class="modal-title" th:text="">Delete Articles</h4>
                                </div>
                                <div class="modal-body">
                                    <p th:text="">Are you sure you want to delete?</p>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="confirmed" value="true"/> <span th:text="">Confirm</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" data-action="" disabled="true" th:text="">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-delete-modal -->
                    <!-- #bulk-publish-modal -->
                    <div id="bulk-publish-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div id="bulk-publish-dialog" class="modal-dialog">
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Publish Articles</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label th:text="">Date</label>
                                        <input type="text" name="date" class="form-control" placeholder="YYYY/MM/DD HH:mm" />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" data-action="" th:text="">Publish</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-publish-modal -->
                    <!-- #bulk-unpublish-modal -->
                    <div id="bulk-unpublish-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div id="bulk-unpublish-dialog" class="modal-dialog">
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Unpublish Articles</h4>
                                </div>
                                <div class="modal-body">
                                    <p th:text="">Are you sure you want to unpublish?</p>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" data-action="" th:text="">Unpublish</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-unpublish-modal -->
                </form>
            </section>
        </div>
    </div>
    <script th:inline="">
        $(function () {
            $('#search-form select.select2').each(function (index) {
                var $self = $(this);
                $self.select2({
                    allowClear: true,
                    dropdownAutoWidth: true,
                    dropdownCssClass: 'select2-drop-search-form',
                });
            });
            $('#search-form input.select2').each(function (index) {
                var $self = $(this);
                $self.select2({
                    minimumInputLength: 1,
                    allowClear: true,
                    dropdownAutoWidth: true,
                    dropdownCssClass: 'select2-drop-search-form',
                    ajax: {
                        url: $self.attr('data-url'),
                        dataType: 'json',
                        data: function (term, page) {
                            return {
                                keyword: term
                            };
                        },
                        results: function (data, page) {
                            return {results: data};
                        }
                    },
                    initSelection: function (element, callback) {
                        var id = $(element).val();
                        if (id !== "") {
                            $.ajax($self.attr('data-url') + '/' + id + ".json", {
                                dataType: "json"
                            }).done(function (data) {
                                callback(data);
                            });
                        }
                    }
                });
            });
        });
    </script>
    <!--
    <script th:inline="">
        // <![CDATA[
        $(function () {
            $('#wr-page-content .search-result').on('click', '[data-href]', function (e) {
                if (!$(e.target).is(':checkbox') && !$(e.target).is('a')) {
                    window.location = $(e.target).closest('tr').data('href');
                };
            });
            $('#wr-page-content .search-result').on('click', '[data-action]', function (e) {
                var form = $(this).closest('form');
                form.attr('action', $(this).data('action'));
                form.submit();
                e.preventDefault();
            });
            $('#wr-page-content .search-result td.wr-tr-checkbox').shiftcheckbox({
                checkboxSelector: ':checkbox',
                selectAll: '.search-result th.wr-tr-checkbox'
            });
            $('#wr-page-content .search-result td.wr-tr-checkbox').closest('td').click(function (e) {
                e.stopPropagation();
            });
            $('#wr-page-content .search-result td.wr-tr-checkbox :checkbox').change(function (e) {
                var checked = $(this).prop('checked');
                if (checked) {
                    $(this).closest('tr').addClass('warning');
                } else {
                    $(this).closest('tr').removeClass('warning');
                }
                var checkedCount = $('#wr-page-content .search-result td.wr-tr-checkbox :checkbox:checked').length;
                if (checkedCount == 0) {
                    $('#wr-page-content .search-result .btn-toolbar .btn').addClass('disabled');
                }
                if (checkedCount >= 1) {
                    $('#wr-page-content .search-result .wr-bulk-action .btn').removeClass('disabled');
                }
            });
        });
        // ]]>
    </script>
    <script th:inline="">
        // <![CDATA[
        $(function () {
            $('#bulk-delete-modal').on('change', ':input[name="confirmed"]', function () {
                var confirmed = $(this);
                $('#bulk-delete-modal .btn-primary').prop('disabled', !confirmed.is(':checked'));
            });
            $('#bulk-delete-modal').on('hidden.bs.modal', function () {
                $(this).removeData('bs.modal');
            });
        });
        // ]]>
    </script>
    <script th:inline="">
        // <![CDATA[
        $(function () {
            $('#bulk-publish-modal').on('hidden.bs.modal', function () {
                $(this).removeData('bs.modal');
            });
        });
        // ]]>
    </script>
    <script th:inline="">
        // <![CDATA[
        $(function () {
            $('#bulk-unpublish-modal').on('hidden.bs.modal', function () {
                $(this).removeData('bs.modal');
            });
        });
        // ]]>
    </script>
    <script>
        $(function () {
            $(':input[name="date"]').datetimepicker({});
        });
    </script>
    -->
</article-index>