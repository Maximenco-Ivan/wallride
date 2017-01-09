<tag-index>
    <div id="wr-page-header">
        <div class="page-header container-fluid">
            <div class="pull-left">
                <h1 th:text="">Tags</h1>
            </div>
            <div class="pull-right">
                <div class="btn-group">
                    <a th:href="" data-toggle="modal" data-target="#tag-create-modal" class="btn btn-primary btn-sm" style="margin-top: -3px;"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New Tag</span></a>
                </div>
            </div>
        </div>
    </div>

    <div id="wr-page-content">
        <div class="container-fluid">
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Tag saved.</span>
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Tags deleted.</span>
            </div>
            <div class="alert alert-success" th:if="">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span th:text="">Tags merged.</span>
            </div>
            <section class="search-condition">
                <div class="search-condition-simple clearfix">
                    <form class="form-inline" method="get" th:action="" th:object="">
                        <input type="submit" name="search" style="visibility:hidden; width:0; height:0;"/>
                        <div class="form-group pull-left">
                            <div class="input-group keyword-search">
                                <input type="text" name="keyword" th:value="" class="form-control" th:attr="" />
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit" name="search"><span class="glyphicon glyphicon-search"></span></button>
                                </span>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <section class="search-result">
                <form method="post">
                    <div class="search-result-header clearfix">
                        <div class="btn-toolbar pull-left">
                            <div class="btn-group wr-bulk-action">
                                <a th:href="" data-toggle="modal" data-target="#bulk-delete-modal" class="btn btn-default disabled"><span class="glyphicon glyphicon-trash"></span></a>
                            </div>
                            <div class="btn-group wr-merge-action">
                                <a th:href="" data-toggle="modal" data-target="#merge-tag-modal" class="btn btn-default disabled" th:text="">Merge</a>
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
                                    <th th:text="">Tag Name</th>
                                    <th class="text-right" th:text="">Count</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr th:each="">
                                    <td class="wr-tr-checkbox" style="width:40px"><input type="checkbox" name="ids" th:value="" /></td>
                                    <td th:text=""></td>
                                    <td class="text-right"><span class="badge wr-tree-option" th:text="">16</span></td>
                                    <td class="text-center"><a th:href="" data-toggle="modal" data-target="#tag-edit-modal"><span class="glyphicon glyphicon-pencil"></span> <span th:text="">Edit</span></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <script th:inline="">
                        // <![CDATA[
                        $(function() {
                            $('#wr-page-content .search-result').on('click', '[data-href]', function(e) {
                                if (!$(e.target).is(':checkbox') && !$(e.target).is('a')){
                                    window.location = $(e.target).closest('tr').data('href');
                                };
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
                                if (checkedCount >= 2) {
                                    $('#wr-page-content .search-result .wr-merge-action .btn').removeClass('disabled');
                                }
                            });
                        });
                        // ]]>
                    </script>
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
                                        <label><input type="checkbox" name="confirmed" value="true" /> <span th:text="">Confirm</span></label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" id="delete-tag" th:attr="" disabled="true" th:text="">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/#bulk-delete-modal -->
                    <script th:inline="">
                        // <![CDATA[
                        $(function() {
                            $('#bulk-delete-modal').on('change', ':input[name="confirmed"]', function() {
                                var confirmed = $(this);
                                $('#bulk-delete-modal .btn-primary').prop('disabled', !confirmed.is(':checked'));
                            });
                            $('#bulk-delete-modal').on('click', '#delete-tag', function(e) {
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
                    <!-- #merge-tag-modal -->
                    <div id="merge-tag-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div id="merge-tag-dialog" class="modal-dialog">
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Merge Tags</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label th:text="">Tag name of the merged</label>
                                        <input type="text" name="name" class="form-control" th:placeholder="" />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" id="merge-tag" th:attr="" th:text="">Merge</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- #merge-tag-modal -->
                    <script th:inline="">
                        // <![CDATA[
                        $(function() {
                            $('#merge-tag-modal').on('click', '#merge-tag', function(e) {
                                e.preventDefault();
                                var $self = $(this);
                                $self.button('loading');
                                var $form = $self.closest('form');
                                $.ajax({
                                    url: $self.data('action'),
                                    type: 'post',
                                    data: $form.serialize(),
                                    success: function() {
                                        location = /*[[@{__$ADMIN_PATH__/tags/index(merged,query=${query})}]]*/ '#';
                                    },
                                    error: function(jqXHR) {
                                        $.each(jqXHR.responseJSON.fieldErrors, function(field, message) {
                                            var $field = $(':input[name="' + field + '"]', $form);
                                            $field.closest('.form-group').addClass('has-error');
                                            $field.closest('.form-group').find('.help-block.has-error').remove();
                                            $field.after($('<span class="help-block has-error" />').text(message));
                                        });
                                        $self.button('reset');
                                    }
                                });
                            });
                            $('#merge-tag-modal').on('hidden.bs.modal', function() {
                                $(this).removeData('bs.modal');
                            });
                        });
                        // ]]>
                    </script>
                </form>
            </section>
        </div>
    </div>
    <!-- #tag-create-modal -->
    <div id="tag-create-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div id="tag-create-dialog" class="modal-dialog">
            <div class="modal-content">
                <form th:fragment="">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" th:text="">Add New Tag</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" name="name" class="form-control" th:attr="" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                        <button class="btn btn-primary" id="save-tag" th:text="">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/#tag-create-modal -->
    <script th:inline="">
        $(function() {
            $('#tag-create-modal').on('click', '#save-tag', function(e) {
                e.preventDefault();
                var $self = $(this);
                $self.button('loading');
                var $form = $self.closest('form');
                var data = {
                    name: $(':input[name="name"]', $form).val()
                };
                $.ajax({
                    url: /*[[@{__$ADMIN_PATH__/tags.json}]]*/ '#',
                    type: 'post',
                    data: data,
                    success: function() {
                        location = /*[[@{__$ADMIN_PATH__/tags/index(created,query=${query})}]]*/ '#';
                    },
                    error: function(jqXHR) {
                        $.each(jqXHR.responseJSON.fieldErrors, function(field, message) {
                            var field = $(':input[name="' + field + '"]', $form);
                            $(field).closest('.form-group').addClass('has-error');
                            $(field).closest('.form-group').find('.help-block.has-error').remove();
                            $(field).after($('<span class="help-block has-error" />').text(message));
                        });
                        $self.button('reset');
                    }
                });
            });
            $('#tag-create-modal').on('hidden.bs.modal', function() {
                $(this).removeData('bs.modal');
            });
        });
    </script>
    <!-- #tag-edit-modal -->
    <div id="tag-edit-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div id="tag-edit-dialog" class="modal-dialog">
            <div class="modal-content">
                <form th:fragment="" th:if="">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" th:text="">Edit Tag</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" name="name" th:value="" class="form-control" th:attr="" placeholder="Tag Name" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                        <button id="update-tag" class="btn btn-primary" th:text="" th:attr="">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--/#tag-edit-modal -->
    <script th:inline="">
        $(function() {
            $('#tag-edit-modal').on('click', '#update-tag', function(e) {
                e.preventDefault();
                var self = $(this);
                self.button('loading');
                var form = self.closest('form');
                var data = {
                    name: $(':input[name="name"]', form).val()
                };
                /*[+
                 var url = [[@{__$ADMIN_PATH__/tags/}]] + self.data('id') + '.json';
                 +]*/
                $.ajax({
                    url: url,
                    type: 'post',
                    data: data,
                    success: function() {
                        location = /*[[@{__$ADMIN_PATH__/tags/index(updated,query=${query})}]]*/ '#';
                    },
                    error: function(jqXHR) {
                        $.each(jqXHR.responseJSON.fieldErrors, function(field, message) {
                            var field = $(':input[name="' + field + '"]', form);
                            $(field).closest('.form-group').addClass('has-error');
                            $(field).closest('.form-group').find('.help-block.has-error').remove();
                            $(field).after($('<span class="help-block has-error" />').text(message));
                        });
                        $(self).button('reset');
                    }
                });
            });
            $('#tag-edit-modal').on('hidden.bs.modal', function() {
                $(this).removeData('bs.modal');
            });
        });
    </script>
</tag-index>