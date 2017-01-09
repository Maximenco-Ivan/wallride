<customfield-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">CustomFields</h1>
            </div>
            <div class="pull-right">
                <div class="btn-group">
                    <button id="sort-order" class="btn btn-sm btn-default" data-loading-text="saving..." th:unless="" th:text="">Save Order</button>
                </div>
                <div class="btn-group">
                    <button id="update-order" type="submit" class="btn btn-sm btn-primary hide" data-loading-text="saving..." th:unless="" th:text="">Save Order</button>
                </div>
                <script th:inline="">
                    // <![CDATA[
                    $(function() {
                        $('#sort-order').on('click', function (e) {
                            e.preventDefault();
                            var self = this;
                            $(this).hide();
                            $('#update-order').removeClass('hide');
                            $('.sortable').sortable();
                            $('.wr-tr-checkbox > input').prop('type', 'hidden');
                            $('.wr-tr-checkbox').append('<span class="grippy"></span>');
                        });
                        $('#update-order').click(function(e) {
                            e.preventDefault();
                            var self = this;
                            $(self).button('loading');
                            $('.sortable').sortable('disable');
                            var data = $('.sortable').sortable('toArray');
                            $.ajax({
                                url: /*[[@{__$ADMIN_PATH__/customfields.json}]]*/ '#',
                                type: 'put',
                                dataType: 'json',
                                data: JSON.stringify(data),
                                contentType: 'application/json',
                                success: function(data) {
                                    location = /*[[@{__$ADMIN_PATH__/customfields/index?updated}]]*/ '#';
                                },
                                error: function(jqXHR) {
                                    $.each(jqXHR.responseJSON.fieldErrors, function (field, message) {
                                        var field = $(':input[name="' + field + '"]', form);
                                        $(field).closest('.form-group').addClass('has-error');
                                    });
                                    $(self).button('reset');
                                }
                            });
                        });
                    });
                    // ]]>
                </script>
                <div class="btn-group">
                    <a th:href="" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New</span></a>
                </div>
            </div>
        </div>
    </div>
    <div id="wr-page-content">
        <section class="search-condition">
            <div class="navbar">
                <div class="container-fluid">
                    <form id="search-form" class="navbar-form navbar-left" method="get" th:action="" th:object="">
                        <input type="text" name="keyword" th:value="" class="form-control" th:attr=""/>
                        <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                    </form>
                </div>
            </div>
        </section>

        <div class="container-fluid">
            <div id="message-deleted" class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">CustomField Deleted.</span>
            </div>
            <div id="message-deleted multiple" class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">CustomFields Deleted.</span>
            </div>
            <div id="message-saved" class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">CustomFields saved.</span>
            </div>
            <section class="search-result">
                <form method="post">
                    <div class="search-result-header clearfix">
                        <div class="btn-toolbar pull-left">
                            <div class="wr-bulk-action btn-group">
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
                        <table class="table table-hover" id="wr-sortable">
                            <thead>
                                <tr>
                                    <th class="wr-tr-checkbox" style="width:40px"><input type="checkbox"/></th>
                                    <th th:text="">FieldName</th>
                                    <th th:text="">FieldName</th>
                                    <th th:text="">Description</th>
                                    <th th:text="">FieldType</th>
                                    <th th:text="">FieldOption</th>
                                    <!--<th th:text="">Screen</th>-->
                                    <th class="text-center"></th>
                                </tr>
                            </thead>
                            <tbody class="sortable">
                                <tr th:id="" th:each="">
                                    <td class="wr-tr-checkbox" style="width:40px"><input type="checkbox" name="ids" th:value="" /></td>
                                    <td th:text="">Title</td>
                                    <td th:text="">Title</td>
                                    <td th:text="">2013/10/24</td>
                                    <td th:text=""></td>
                                    <td th:text=""></td>
                                    <!--<td><a th:if="" th:text="">Author</a></td>-->
                                    <td class="text-center"><a th:attr=""><span class="glyphicon glyphicon-pencil"></span> <span th:text="">Edit</span></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
//							$( ".sortable" ).sortable({
//								change: function( event, ui ) {
//									$('#update-customfields-sort').prop('disabled', false);
//									$('button', $(this)).prop('disabled', true);
//								}
//							});
                        });
                        // ]]>
                    </script>
                    <!-- #bulk-delete-modal -->
                    <div id="bulk-delete-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div id="bulk-delete-dialog" class="modal-dialog">
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Delete CustomFields</h4>
                                </div>
                                <div class="modal-body">
                                    <p th:text="">Are you sure you want to delete?</p>
                                    <div class="checkbox">
                                        <label><input type="checkbox" name="confirmed" value="true"/> <span th:text="">Confirm</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" id="delete-custom-field" th:attr="" disabled="true" th:text="">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-delete-modal -->
                    <!--/#bulk-delete-modal -->
                    <script th:inline="">
                        // <![CDATA[
                        $(function() {
                            $('#bulk-delete-modal').on('change', ':input[name="confirmed"]', function() {
                                var confirmed = $(this);
                                $('#bulk-delete-modal .btn-primary').prop('disabled', !confirmed.is(':checked'));
                            });
                            $('#bulk-delete-modal').on('click', '#delete-custom-field', function(e) {
                                e.preventDefault();
                                var $form = $(this).closest('form');
                                $form.attr('action', $(this).data('action'));
                                $form.submit();
                            });
                            $('#bulk-delete-modal').on('hidden.bs.modal', function() {
                                $(this).removeData('bs.modal');
                            });
                        });
                        // ]]>
                    </script>
                </form>
            </section>
        </div>
    </div>
</customfield-index>
