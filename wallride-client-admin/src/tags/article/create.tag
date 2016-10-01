<article-create xmlns:th="http://www.thymeleaf.org">
    <div>
        <form id="wr-post-form" th:fragment="" th:action="" th:object="" action="#" method="post">
            <input type="hidden" name="id" th:value=""  />
            <div id="wr-page-header">
                <div class="page-header container-fluid">
                    <div class="pull-left back">
                        <a class="btn btn-sm btn-default" th:href=""><span class="glyphicon glyphicon-arrow-left"></span></a>
                    </div>
                    <div class="pull-left">
                        <h1 th:text="">Add New Article</h1>
                    </div>
                    <div class="tools clearfix">
                        <div class="pull-right">
                            <div class="btn-group">
                                <a id="article-preview" class="btn btn-default" href="#"><span th:text="">Preview</span></a>
                            </div>
                            <script th:inline="">
                                $(function() {
                                    $('#wr-page-header').on('click', '#article-preview', function(e) {
                                        e.preventDefault();
                                        var form = $(this).closest('form').clone();
                                        var action = /*[[@{__$ADMIN_PATH__/articles/preview}]]*/ '#';
                                        form.attr('action', action);
                                        form.attr('target', '_blank');
                                        $(':input[name="body"]', form).val($('#wr-page-content :input[name="body"]').froalaEditor('html.get'));
                                        form.submit();
                                    });
                                });
                            </script>
                            <div class="btn-group">
                                <button id="save-draft-button" name="draft" class="btn btn-default" data-loading-text="Saving..." th:text="">Save Draft</button>
                            </div>
                            <script th:inline="">
                                $(document).ready(function() {
                                    $('#save-draft-button').click(function(e) {
                                        var $this = $(this);
                                        $this.button('loading');
                                        var $form = $this.closest('form');
                                        $(':input[name="body"]', $form).val($('#wr-page-content :input[name="body"]').froalaEditor('html.get'));
                                        var data = $form.serializeArray();
                                        data.push({name: 'draft', value: 1});
                                        $.ajax({
                                            type: "POST",
                                            url: $form.attr('action'),
                                            data: data,
                                            success: function(data) {
                                                $form.children(':input[name="id"]').val(data.id);
                                                $form.attr('action', /*[[@{__$ADMIN_PATH__/articles/edit(query=${query})}]]*/ '#');
                                                var url = /*[[@{__$ADMIN_PATH__/articles/edit?id=}]]*/ '#' + data.id;
                                                history.replaceState(null, null, url);
                                                new PNotify({
                                                    icon: false,
                                                    title: /*[[#{SavedAsDraft}]]*/ 'Saved as draft',
                                                    type: 'success',
                                                    delay: 3000,
                                                    buttons: {
                                                        sticker: false
                                                    }
                                                });
                                            },
                                            complete: function() {
                                                $this.button('reset');
                                            }
                                        });
                                        return false;
                                    });
                                });
                            </script>
                            <div class="btn-group">
                                <button name="publish" class="btn btn-primary" th:text="">Publish</button>
                                <th:block th:if="">
                                    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul id="save-menu" class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#" data-name="publish" th:text="">Publish</a></li>
                                        <li><a href="#" data-name="unpublish" th:text="">Unpublish</a></li>
                                    </ul>
                                    <script>
                                        $(document).ready(function() {
                                            $('#save-menu a').click(function() {
                                                var $this = $(this);
                                                var $target = $this.closest('.btn-group').children('button:first');
                                                $target.text($this.text());
                                                $target.attr('name', $this.data('name'));
                                            });
                                        });
                                    </script>
                                </th:block>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="wr-page-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-9 wr-post-main">
                            <div class="alert alert-success" th:if="">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                Article saved.
                            </div>
                            <div class="alert alert-danger" th:if="">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <span th:text="">Error</span>
                            </div>
                            <div class="alert alert-info" th:if="">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <span th:text="">You have draft.</span><a th:href=""><span th:text="">Copy draft</span></a>
                            </div>
                            <div class="alert alert-info" th:if="">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <span th:text="">There is no {0} version of "{1}".</span>
                            </div>
                            <fieldset>
                                <div class="form-group">
                                    <div id="post-cover-dropzone" class="wr-post-cover-dropzone col-sm-12" style="">
                                        <p class="placeholder help-block" th:text="">Cover Image</p>
                                        <div class="dragover hide"><span class="help-block">Drop files here</span></div>
                                        <div th:classappend="" class="image-wrap">
                                            <img th:if="" th:src="" class="wr-post-cover" />
                                            <div class="remove"><a href="#"><span class="glyphicon glyphicon-remove"></span></a></div>
                                        </div>
                                        <div class="progress hide"><div class="progress-bar progress-bar-success"></div></div>
                                        <input type="hidden" th:field="" />
                                    </div>
                                </div>
                                <script th:inline="">
                                    $(function() {
                                        $('#post-cover-dropzone').fileupload({
                                            url: /*[[@{__$ADMIN_PATH__/media/create.json}]]*/ '#',
                                            paramName: 'file',
                                            dropZone: $('#post-cover-dropzone'),
                                            dragover: function(e) {
                                                var dropZone = $('#post-cover-dropzone');
                                                var timeout = window.dropZoneTimeout;
                                                if (!timeout) {
                                                    $('#post-cover-dropzone .dragover').removeClass('hide');
                                                } else {
                                                    clearTimeout(timeout);
                                                }
                                                var found = false;
                                                var node = e.target;
                                                do {
                                                    if (node === dropZone[0]) {
                                                        found = true;
                                                        break;
                                                    }
                                                    node = node.parentNode;
                                                } while (node != null);
                                                if (found) {
                                                    $('#post-cover-dropzone .dragover').removeClass('hide');
                                                }
                                                else {
                                                    $('#post-cover-dropzone .dragover').addClass('hide');
                                                }
                                                window.dropZoneTimeout = setTimeout(function () {
                                                    window.dropZoneTimeout = null;
                                                    $('#post-cover-dropzone .dragover').addClass('hide');
                                                }, 100);
                                            },
                                            start: function(e) {
                                                $('#post-cover-dropzone .progress').removeClass('hide');
                                            },
                                            progressall: function (e, data) {
                                                var progress = parseInt(data.loaded / data.total * 100, 10);
                                                $('#post-cover-dropzone .progress-bar').css('width', progress + '%');
                                            },
                                            done: function(e, data) {
                                                $('#post-cover-dropzone :input[name="coverId"]').val(data.result.id);
                                                $('#post-cover-dropzone .progress').addClass('hide');
                                                $('#post-cover-dropzone .progress-bar').css('width', '0%');
                                                var img = $('<img class="wr-post-cover" />').attr('src', data.result.link + '?' + $.param({w: 1200, h: 500, m: 1}));
                                                $('#post-cover-dropzone img').remove();
                                                $('#post-cover-dropzone').append(img);
                                                $('#post-cover-dropzone .image-wrap').removeClass('hide');
                                            }
                                        });
                                        $('#post-cover-dropzone .remove').click(function(e) {
                                            $('#post-cover-dropzone :input[name="coverId"]').val('');
                                            $('#post-cover-dropzone .image-wrap').addClass('hide');
                                            $('#post-cover-dropzone img').remove();
                                            e.preventDefault();
                                        });
                                    });
                                </script>
                            </fieldset>
                            <fieldset>
                                <div class="form-group" th:classappend="">
                                    <input type="text" th:field="" class="form-control" th:attr="" placeholder="Enter title here" />
                                    <span class="help-block" th:each="" th:text="" />
                                </div>
                            </fieldset>
                            <fieldset>
                                <div class="form-group" th:classappend="">
                                    <span class="url-path" th:text=""></span> <input type="text" th:field="" name="path" class="form-control input-sm wr-code" th:attr="" placeholder="URL繝代せ" />
                                    <span class="help-block" th:each="" th:text="" />
                                </div>
                            </fieldset>
                            <script th:inline="">
                                /*<![CDATA[*/
                                $(function() {
                                    var websiteLink = /*[[${WEBSITE_LINK} + '/']]*/ '/';
                                    var today = moment().format('YYYY/MM/DD/');
                                    $('#wr-page-content').on('change', 'input[name="date"]', function(e) {
                                        var inputDate = $(this).val();
                                        if (inputDate != "") {
                                            var urlPath = moment(inputDate, 'YYYY/MM/DD hh:mm').format('YYYY/MM/DD/');
                                            $('.url-path').text(websiteLink + urlPath);
                                        } else {
                                            $('.url-path').text(websiteLink + today);
                                        }
                                    });
                                    $('input[name="date"]').trigger("change");
                                });
                                /*]]>*/
                            </script>
                            <fieldset>
                                <div class="form-group" th:classappend="">
                                    <textarea th:field="" class="form-control" th:attr="" placeholder="Enter body here"></textarea>
                                    <span class="help-block" th:each="" th:text="" />
                                    <script th:inline="" th:replace=""></script>
                                </div>
                            </fieldset>
                        </div>
                        <div class="col-sm-3 wr-tool-panel">
                            <fieldset>
                                <legend th:text="">Date</legend>
                                <div class="form-group row" th:classappend="">
                                    <div class="col-sm-12">
                                        <input type="text" name="date" th:value="" class="form-control" placeholder="YYYY/MM/DD HH:mm"/>
                                    </div>
                                    <script>
                                        $(document).ready(function() {
                                            $(':input[name="date"]').datetimepicker({});
                                        });
                                    </script>
                                    <span class="help-block" th:each="" th:text="" />
                                </div>
                            </fieldset>
                            <fieldset id="category-fieldset">
                                <legend th:text="">Categories</legend>
                                <section>
                                    <ul th:unless="" th:include="" id="category-index" class="list-unstyled"></ul>
                                    <ul th:fragment="">
                                        <li th:each="" class="checkbox">
                                            <label><input type="checkbox" name="categoryIds" th:value="" th:text="" th:checked="" /></label>
                                            <ul th:unless="" th:include="" class="list-unstyled"></ul>
                                        </li>
                                    </ul>
                                    <a th:href="" data-toggle="modal" data-target="#category-create-modal"><span class="glyphicon glyphicon-plus"></span> <span th:text="">Add New Category</span></a>
                                </section>
                            </fieldset>
                            <fieldset>
                                <legend th:text="">Tags</legend>
                                <div class="form-group row" th:classappend="">
                                    <div class="col-sm-12">
                                        <input id="tags-field" type="text" th:field="" style="width: 100%" placeholder=""/>
                                    </div>
                                    <span class="help-block" th:each=""  th:text="" />
                                </div>
                            </fieldset>
                            <script th:inline="">
                                /*<![CDATA[*/
                                $(function() {
                                    $('#tags-field').select2({
                                        minimumInputLength: 1,
                                        multiple: true,
                                        createSearchChoice:function(term, data) {
                                            if ($(data).filter(function() {
                                                        return this.text.localeCompare(term)===0;
                                                    }).length===0) {
                                                return {id: term, text:term};
                                            }
                                        },
                                        ajax: {
                                            url:  /*[[@{__$ADMIN_PATH__/tags/select}]]*/ '#',
                                            dataType: 'json',
                                            data: function (term, page) {
                                                return {
                                                    keyword: term
                                                };
                                            },
                                            results: function (data, page) {
                                                var results = [];
                                                $.each(data, function() {
                                                    results.push({id: this.text, text: this.text});
                                                });
                                                return {results: results};
                                            }
                                        },
                                        initSelection: function(element, callback) {
                                            var data = [];
                                            $(element.val().split(',')).each(function() {
                                                var id = this;
                                                if (id !== "") {
                                                    data.push({id: id, text: id});
                                                }
                                            });
                                            element.val('');
                                            callback(data);
                                        }
                                    });
                                });
                                /*]]>*/
                            </script>
                            <script th:inline="">
                                /*<![CDATA[*/
                                $(function() {
                                    $(document).on('click', '#save-category', function(e) {
                                        e.preventDefault();
                                        var self = $(this);
                                        self.button('loading');
                                        var checked = [];
                                        $('input[name="categoryIds"]:checked', '#wr-post-form').each(function(i, element) {
                                            checked.push($(element).val());
                                        });
                                        var form = self.closest('form');
                                        var data = {
                                            parentId: $(':input[name="parentId"]', form).val(),
                                            code: $(':input[name="code"]', form).val(),
                                            name: $(':input[name="name"]', form).val(),
                                            description: $(':input[name="description"]', form).val()
                                        };
                                        $.ajax({
                                            url: /*[[@{__$ADMIN_PATH__/categories.json}]]*/ '#',
                                            type: 'post',
                                            data: data,
                                            success: function(savedCategory) {
                                                checked.push(savedCategory.id.toString());
                                                $.get(/*[[@{__$ADMIN_PATH__/articles/create?part=category-fieldset}]]*/ '#', function(data) {
                                                    data = $(data);
                                                    $(':input[name="categoryIds"]', data).each(function(i, element) {
                                                        if ($.inArray($(element).val(), checked) != -1) {
                                                            $(element).prop('checked', true);
                                                        }
                                                    });
                                                    $('#category-fieldset').html(data);
                                                });
                                                self.closest('.modal').modal('hide');
                                            },
                                            error: function(jqXHR) {
                                                $.each(jqXHR.responseJSON.fieldErrors, function(field, message) {
                                                    var field = $(':input[name="' + field + '"]', form);
                                                    $(field).closest('.form-group').addClass('has-error');
                                                });
                                            },
                                            complete: function() {
                                                $(self).button('reset');
                                            }
                                        });
                                    });
                                });
                                /*]]>*/
                            </script>
                            <fieldset>
                                <legend th:text="">Related Posts</legend>
                                <div class="form-group row" th:classappend="">
                                    <div class="col-sm-12">
                                        <input id="related-posts-fieldset" type="text" th:field="" style="width: 100%" placeholder=""/>
                                    </div>
                                    <span th:if="" class="help-block" th:text="" />
                                </div>
                            </fieldset>
                            <script th:inline="">
                                /*<![CDATA[*/
                                $(function() {
                                    $('#related-posts-fieldset').select2({
                                        minimumInputLength: 1,
                                        multiple: true,
                                        ajax: {
                                            url:  /*[[@{__$ADMIN_PATH__/posts/select}]]*/ '#',
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
                                            var data = [];
                                            $(element.val().split(',')).each(function() {
                                                var id = this;
                                                if (id !== "") {
                                                    var url = /*[[@{__$ADMIN_PATH__/posts/select}]]*/ '#';
                                                    $.ajax(url + "/" + id,  {
                                                        async: false,
                                                        dataType: "json",
                                                        data: { id: id }
                                                    }).done(function(response) { data.push(response); });
                                                }
                                            });
                                            element.val('');
                                            callback(data);
                                        }
                                    });
                                });
                                /*]]>*/
                            </script>
                            <fieldset id="seo-fieldset">
                                <legend th:text="">SEO</legend>
                                <div class="form-group" th:classappend="">
                                    <input type="text" th:field="" class="form-control" th:placeholder="" />
                                    <span th:if="" class="help-block" th:text="" />
                                </div>
                                <div class="form-group" th:classappend="">
                                    <textarea th:field="" class="form-control" th:placeholder="" style="min-height: 100px"></textarea>
                                    <span th:if="" class="help-block" th:text="" />
                                </div>
                                <div class="form-group" th:classappend="">
                                    <textarea th:field="" class="form-control" th:placeholder=""></textarea>
                                    <span th:if="" class="help-block" th:text="" />
                                </div>
                            </fieldset>
                            <fieldset th:each="">
                                <legend th:text=""></legend>
                                <div class="form-group" th:switch="">
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control" th:field="" style="width: 100%" placeholder=""/>
                                        </div>
                                        <span class="help-block" th:each="" th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <textarea type="text" th:field="" class="form-control" style="min-height: 100px"></textarea>
                                        </div>
                                        <span class="help-block" th:each=""  th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <textarea type="text" th:field="" class="form-control" th:classappend="" style="min-height: 150px"></textarea>
                                        </div>
                                        <span class="help-block" th:each="" th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <script th:inline="" th:replace=""></script>
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control" th:field="" style="width: 100%" placeholder=""/>
                                        </div>
                                        <span class="help-block" th:each="" th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control" th:field="" style="width: 100%" placeholder="YYYY/MM/dd"/>
                                        </div>
                                        <span class="help-block" th:each="" th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <script th:inline="">
                                            /*<![CDATA[*/
                                            $(function() {
                                                var selector = /*[[':input[name="' + 'customFieldValues[__${stat.index}__].dateValue' + '"]']]*/ '#';
                                                $(selector).datetimepicker({
                                                    timepicker: false,
                                                    format:'Y/m/d'
                                                });
                                            });
                                            /*]]>*/
                                        </script>
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <input type="text" class="form-control" th:field="" style="width: 100%" placeholder=""/>
                                        </div>
                                        <span class="help-block" th:each="" th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <script th:inline="">
                                            /*<![CDATA[*/
                                            $(function() {
                                                var selector = /*[[':input[name="' + 'customFieldValues[__${stat.index}__].datetimeValue' + '"]']]*/ '#';
                                                $(selector).datetimepicker({});
                                            });
                                            /*]]>*/
                                        </script>
                                    </div>
                                    <div th:case="" class="form-group row" th:classappend="">
                                        <div class="col-sm-12">
                                            <select type="text" th:field="" class="form-control">
                                                <option value=""></option>
                                                <option th:each="" th:value="" th:text="">wrtwetwet</option>
                                            </select>
                                        </div>
                                        <span class="help-block" th:each=""  th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                    <div th:case="" class="form-group row checkbox" th:classappend="">
                                        <div class="col-sm-12">
                                            <label th:each=""><input type="checkbox" th:field="" th:value="" th:text="" /></label>
                                        </div>
                                        <span class="help-block" th:each=""  th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                    <div th:case="" class="form-group row checkbox" th:classappend="">
                                        <div class="col-sm-12">
                                            <label th:each=""><input type="radio" th:field="" th:value="" th:text="" /></label>
                                        </div>
                                        <span class="help-block" th:each=""  th:text="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                        <input type="hidden" th:field="" th:value="" />
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
            <script th:inline="">
                $(function() {
                    var lastValue = $('#wr-post-form :input[name!="id"]').serialize();
                    setInterval(function() {
                        var currentValue = $('#wr-post-form :input[name!="id"]').serialize();
                        if (lastValue != currentValue) {
                            $('#save-draft-button').trigger('click');
                        }
                        lastValue = currentValue;
                    }, 180000);
                });
            </script>
        </form>
    </div>
    <div id="category-create-modal" th:fragment="" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</article-create>
