<article-edit xmlns:th="http://www.thymeleaf.org">
    <div>
        <form id="wr-post-form" th:include="article/create::form(title=#{EditArticle},article=${article})" th:action="@{__$ADMIN_PATH__/articles/edit(query=${query})}" th:object="${form}" action="#" method="post">
        </form>
    </div>
    <div th:replace="article/create::category-create-modal"></div>
</article-edit>
