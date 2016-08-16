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
	</script>
</home>