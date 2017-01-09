<page-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">Pages</h1>
            </div>
            <div class="pull-right">
                <div class="btn-group">
                    <a th:href="" class="btn btn-primary btn-sm" style="margin-top: -3px;"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New</span></a>
                </div>
                <div class="btn-group">
                    <a th:attr="" class="btn btn-default btn-sm active" style="padding:7px 12px;"><span class="glyphicon glyphicon-list"></span></a>
                    <a th:attr="" title="ツリー表示" class="btn btn-default btn-sm" th:href="" style="height: 34px"><i class="flaticon-category"></i> </a>
                </div>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <section class="search-condition">
            <div class="navbar">
                <div class="container-fluid">
                    <form id="search-form" class="navbar-form navbar-left" method="get" th:action="" th:object="">
                        <select th:field="" class="select2" th:placeholder="">
                            <option value=""></option>
                            <option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
                            <option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
                            <option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
                        </select>
                        <input type="hidden" class="select2" th:field="" th:attr="" th:placeholder=""/>
                        <input type="hidden" class="select2" th:field="" th:attr="" th:placeholder=""/>
                        <input type="hidden" class="select2" th:field="" th:attr="" th:placeholder="" />
                        <input type="text" name="keyword" th:value="" class="form-control" th:attr="" />
                        <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                    </form>
                    <script th:inline="">
                        $(function() {
                            $('#search-form select.select2').each(function(index) {
                                var $self = $(this);
                                $self.select2({
                                    allowClear: true,
                                    dropdownAutoWidth: true,
                                    dropdownCssClass: 'select2-drop-search-form',
                                });
                            });
                            $('#search-form input.select2').each(function(index) {
                                var $self = $(this);
                                $self.select2({
                                    minimumInputLength: 1,
                                    allowClear: true,
                                    dropdownAutoWidth: true,
                                    dropdownCssClass: 'select2-drop-search-form',
                                    ajax: {
                                        url:  $self.attr('data-url'),
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
                                    initSelection: function(element, callback) {
                                        var id = $(element).val();
                                        if (id !== "") {
                                            $.ajax($self.attr('data-url') + '/' + id + ".json", {
                                                dataType: "json"
                                            }).done(function(data) {
                                                callback(data);
                                            });
                                        }
                                    }
                                });
                            });
                        });
                    </script>
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
                <span th:text="">Pages Deleted.</span>
            </div>
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
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="wr-tr-checkbox" style="width:40px"><input type="checkbox" /></th>
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
                                <tr th:each="" th:attr="" class="clickable">
                                    <td class="wr-tr-checkbox" style="width:40px"><input type="checkbox" name="ids" th:value="" /></td>
                                    <td th:class="" th:text="">Status</td>
                                    <td th:text="" style="font-weight: bold;">Title</td>
                                    <td><th:block th:each=""><a th:href="" th:text=""></a> <span th:unless="">&nbsp; | &nbsp;</span></th:block></td>
                                    <td><th:block th:each=""><a th:href="" th:text=""></a> <span th:unless="">&nbsp; | &nbsp;</span></th:block></td>
                                    <td><a th:href="" th:text="">Author</a></td>
                                    <td th:text="">yyyy/mm/dd (E)</td>
                                    <td class="text-right" th:text="">0</td>
                                    <td class="text-center"><a th:attr=""><span class="glyphicon glyphicon-pencil"></span> <span th:text="">Edit</span></a></td>
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
                                    <h4 class="modal-title">Delete Pages</h4>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure you want to delete?</p>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="confirmed" value="true" /> Confirm</label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                                    <button class="btn btn-primary" th:attr="" disabled="true">Delete</button>
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
</page-index>
