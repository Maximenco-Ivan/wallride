<home xmlns:th="http://www.thymeleaf.org">
	<header th:replace="layout::header">
		<nav-global />
		<nav-blog />
	</header>
	<div id="wr-page"></div>
	<script>
		var route = riot.route.create();
		route('', () => {
			riot.mount('#wr-page', 'dashboard');
		});
		route('articles', () => {
			riot.mount('#wr-page', 'article-index');
		});
		route('pages', () => {
			riot.mount('#wr-page', 'page-index');
		});
		route('categories', () => {
			riot.mount('#wr-page', 'category-index');
		});
        route('tags', () => {
            riot.mount('#wr-page', 'tag-index');
        });
        route('customfields', () => {
            riot.mount('#wr-page', 'customfield-index');
        });
        route('comments', () => {
            riot.mount('#wr-page', 'comment-index');
        });
        route('users', () => {
            riot.mount('#wr-page', 'user-index');
        });
        route('analytics', () => {
            riot.mount('#wr-page', 'analytics-index');
        });
        route('system', () => {
            riot.mount('#wr-page', 'system-index');
        });
    </script>
</home>