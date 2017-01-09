<user-describe xmlns:th="http://www.thymeleaf.org">
    <div>
        <div id="wr-page-header">
            <div class="page-header container-fluid">
                <div class="pull-left">
                    <h1 th:text="">Name</h1>
                </div>
                <div class="pull-right">
                    <div class="btn-group">
                        <div th:classappend="" class="previous">
                            <a class="btn btn-default" th:href=""><span class="glyphicon glyphicon-chevron-left"></span></a>
                        </div>
                    </div>
                    <div class="btn-group">
                        <div th:classappend="" class="next">
                            <a class="btn btn-default" th:href=""><span class="glyphicon glyphicon-chevron-right"></span></a>
                        </div>
                    </div>
                    <div class="btn-group">
                        <a th:href="" title="編集" type="button" class="btn btn-info" th:text="">編集</a>
                    </div>
                </div>
            </div>
        </div>
        <div id="wr-page-content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12 describe">
                        <div style="margin-bottom: 15px ; position: relative;">
                            <div class="image-box">
                                <img style="width:150px; border-radius: 50%" th:src="" src="http://placehold.it/170/eeeeee/ffffff"/>
                                <!--/*
                                <div class="btn-group">
                                    <a href="#" type="button" class="btn btn-info" data-toggle="modal" data-target="#change-avatar-modal">Change Avatar</a>
                                </div>
                                */-->
                            </div>
                        </div>
                        <table class="table">
                            <tr>
                                <th th:text="">ログインID</th>
                                <td th:text="">ログインID</td>
                            </tr>
                            <tr>
                                <th>URL</th>
                                <td><a th:href="" target="_blank"><span class="glyphicon glyphicon-share-alt"></span> <span th:text="">http://</span></a></td>
                            </tr>
                            <tr>
                                <th th:text="">Nickname</th>
                                <td th:text=""></td>
                            </tr>
                            <tr>
                                <th th:text="">メールアドレス</th>
                                <td th:text="">メールアドレス</td>
                            </tr>
                            <tr>
                                <th>プロフィール</th>
                                <td>
                                    <pre th:utext=""></pre>
                                </td>
                            </tr>
                            <tr>
                                <th th:text="">投稿記事数</th>
                                <td th:text="">投稿記事数</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="change-avatar-modal" class="modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div id="change-avatar-dialog" class="modal-dialog">
                <form method="post">
                    <div th:fragment="" class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Change Avatar</h4>
                        </div>
                        <div class="modal-body" style="min-height: 118px;">
                            <p>Select a new image</p>
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-4">
                                        <input type="radio" name="from" value="computer" selected="true"/> From your computer. <br/>
                                        <input type="radio" name="from" value="internet"/> From internet.
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <input type="file" name="newAvatar" class="btn-default"/>
                                            <input type="text" name="newAvatar" class="form-control" placeholder="Enter your image's url"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-default" data-dismiss="modal" th:text="">Cancel</button>
                            <button class="btn btn-primary" th:attr="">Change</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script th:inline="">
            $(function () {
                $('#change-avatar-modal .form-group input[type="text"]').hide().attr('disabled', 'true');

                $('#change-avatar-modal').on('change', 'input[type="radio"]', function () {
                    var from = $(this).val();
                    if (from == 'computer') {
                        $('#change-avatar-modal .form-group input[type="text"]').hide().attr('disabled', 'true');
                        $('#change-avatar-modal .form-group input[type="file"]').show().removeAttr('disabled');
                    } else {
                        $('#change-avatar-modal .form-group input[type="text"]').show().removeAttr('disabled');
                        $('#change-avatar-modal .form-group input[type="file"]').hide().attr('disabled', 'true');
                    }
                });
            });
        </script>

    </div>
    <style>
        #wr-page-content .describe div.btn-group {
            cursor: pointer;
            position: absolute;
            top: 89px;
            left: 20px;
            display: none;

        }

        #wr-page-content .describe .image-box {
            display: inline-block;
        }

        #wr-page-content .describe .image-box:hover .btn-group {
            display: block;
        }

        #change-avatar-modal button {
            position: relative;
        }

        #change-avatar-modal button input {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
        }
    </style>
</user-describe>
