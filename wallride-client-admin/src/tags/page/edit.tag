<page-edit>
    <div>
        <form id="wr-post-form" th:include="page/create::form(title=#{EditPage},id=${form.id},page=${page})" th:action="@{__${ADMIN_PATH}__/pages/edit(query=${query})}" th:object="${form}" action="#" method="post">
        </form>
    </div>
    <div th:replace="page/create::category-create-modal"></div>
</page-edit>
