<page-tree xmlns:th="http://www.thymeleaf.org">
    <div>
        <div id="wr-page-header">
            <div class="page-header container-fluid">
                <div class="pull-left">
                    <h1 th:text="">Pages</h1>
                </div>
                <div class="pull-right">
                    <div class="btn-group">
                        <a th:href="" data-toggle="modal" data-target="#page-create-modal" class="btn btn-sm btn-primary"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New</span></a>
                    </div>
                    <div class="btn-group">
                        <button id="update-page-sort" type="submit" class="btn btn-sm btn-primary" data-loading-text="saving..." disabled="true" th:if="" th:text="">Save Order</button>
                    </div>
                    <script th:inline="">
                        $(function() {
                            $('#update-page-sort').click(function(e) {
                                e.preventDefault();
                                $(this).button('loading');
                                var data = $('#page-tree').nestedSortable('toArray', {startDepthCount: 0});
                                $.ajax({
                                    url: /*[[@{__$ADMIN_PATH__/pages.json}]]*/ '#',
                                    type: 'put',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: 'application/json',
                                    success: function() {
                                        location = /*[[@{__$ADMIN_PATH__/pages/tree?updated(query=${query})}]]*/ '#';
                                    },
                                    error: function() {
                                    }
                                });
                            });
                        });
                    </script>
                    <div class="btn-group">
                        <a th:attr="" class="btn btn-default btn-sm" th:href="" style="padding:7px 12px;"><span class="glyphicon glyphicon-list"></span></a>
                        <a th:attr="" title="ツリー表示" class="btn btn-default btn-sm active" style="height: 34px"><i class="flaticon-category"></i> </a>
                    </div>
                </div>
            </div>
        </div>
        <div id="wr-page-content">
            <div class="container-fluid">
                <div class="alert alert-success" th:if="">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <span th:text="">Page saved.</span>
                </div>
                <div class="alert alert-success" th:if="">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <span th:text="">Page deleted.</span>
                </div>
                <ul th:unless="" th:replace=""></ul>
                <ul id="page-tree" class="nested-sortable" th:fragment="">
                    <li th:each="" th:id="">
                        <div class="category clearfix" th:classappend="">
                            <div class="wr-tree-options pull-left">
                                <span class="wr-tree-option disclose"><span class="glyphicon glyphicon-chevron-right"></span></span>
                                <span class="wr-tree-option title" th:text=""></span>
                                <span class="wr-tree-option" th:if="" th:text="">/cate1</span>
                                <span class="wr-tree-option small" style="margin-left: 10px;" th:classappend="">● <span th:text=""></span></span>
                            </div>
                            <div class="wr-tree-options pull-right">
                                <button class="btn btn-link wr-tree-option" th:href=""><span class="glyphicon glyphicon-pencil"></span> <span th:text="">Edit</span></button>
                                <button class="btn btn-link wr-tree-option" th:href="" data-toggle="modal" data-target="#page-create-modal"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add</span></button>
                                <button class="btn btn-link wr-tree-option" th:href="" data-toggle="modal" data-target="#page-delete-modal"><span class="glyphicon glyphicon-remove"></span></button>
                            </div>
                            <script>
                                $(function() {
                                    $('#page-tree button[href]').not('[data-toggle]').click(function() {
                                        location = $(this).attr('href');
                                    });
                                });
                            </script>
                        </div>
                        <ul th:unless="" th:include=""></ul>
                    </li>
                </ul>
                <!-- #page-create-modal -->
                <div id="page-create-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div id="page-create-dialog" class="modal-dialog">
                        <form>
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Add New Page</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <select name="parentId" class="form-control">
                                            <option value="" th:text="">Select Parent Page</option>
                                            <option th:each="" th:value="" th:text="" th:selected=""></option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="title" class="form-control" th:attr="" />
                                    </div>
                                    <div class="form-group">
                                        <span th:text="">http://wallride.org/page/</span>
                                        <input type="text" name="code" class="form-control input-sm wr-code" th:attr="" />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                                    <button class="btn btn-primary" id="save-page" th:text="">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!--/#page-create-modal -->
                <script th:inline="">
                    $(function() {
                        $('#wr-page-content').on('click', '#save-page', function(e) {
                            e.preventDefault();
                            var self = this;
                            $(self).button('loading');
                            var form = $(this).closest('form');
                            var data = {
                                parentId: $(':input[name="parentId"]', form).val(),
                                code: $(':input[name="code"]', form).val(),
                                title: $(':input[name="title"]', form).val(),
                                status: 'DRAFT'
                            };
                            $.ajax({
                                url: /*[[@{__$ADMIN_PATH__/pages.json}]]*/ '#',
                                type: 'post',
                                data: data,
                                success: function() {
                                    location = /*[[@{__$ADMIN_PATH__/pages/tree?created(query=${query})}]]*/ '#';
                                },
                                error: function(jqXHR) {
                                    $.each(jqXHR.responseJSON.fieldErrors, function(field, message) {
                                        var field = $(':input[name="' + field + '"]', form);
                                        $(field).closest('.form-group').addClass('has-error');
                                    });
                                    $(self).button('reset');
                                }
                            });
                        });
                        $('#wr-page-content').on('hidden.bs.modal', '#page-create-modal', function() {
                            $(this).removeData('bs.modal');
                        });
                    });
                </script>
                <!-- #page-delete-modal -->
                <div id="page-delete-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div id="page-delete-dialog" class="modal-dialog">
                        <form>
                            <div th:fragment="" class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" th:text="">Delete Page</h4>
                                </div>
                                <div class="modal-body">
                                    <p th:text="">Are you sure you want to delete?</p>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                                    <button id="delete-page" class="btn btn-primary" th:attr="" th:text="">Delete</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!--/#page-delete-modal -->
                <script th:inline="">
                    $(function() {
                        $('#page-tree').nestedSortable({
                            forcePlaceholderSize: true,
                            handle: 'div',
                            helper:	'clone',
                            items: 'li',
                            opacity: .6,
                            placeholder: 'placeholder',
                            revert: 250,
                            tabSize: 25,
                            tolerance: 'pointer',
                            toleranceElement: '> div',
                            listType: 'ul',
                            isTree: true,
                            expandOnHover: 700
                            //							startCollapsed: true
                        });
                        $('#wr-page-content').on('sortupdate', '#page-tree', function() {
                            $('#update-page-sort').prop('disabled', false);
                            $('button', $(this)).prop('disabled', true);
                        });
                        $('.disclose').on('click', function() {
                            $(this).closest('li').toggleClass('mjs-nestedSortable-collapsed').toggleClass('mjs-nestedSortable-expanded');
                        })
                        $('#wr-page-content').on('click', '#delete-page', function(e) {
                            e.preventDefault();
                            var self = $(this);
                            self.button('loading');
                            /*[+
                             var url = [[@{__$ADMIN_PATH__/pages/}]] + self.data('id') + '.json';
                             +]*/
                            $.ajax({
                                url: url,
                                type: 'delete',
                                success: function() {
                                    $('#page-tree_' + self.data('id')).fadeOut(300, function() {
                                        location = /*[[@{__$ADMIN_PATH__/pages/tree?deleted(query=${query})}]]*/ '#';
                                    });
                                },
                                error: function() {
                                }
                            });
                        });
                    });
                </script>
            </div>
        </div>
    </div>
</page-tree>