<home xmlns:th="http://www.thymeleaf.org">
	<header id="header" class="navbar">
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
		route('articles/new', () => {
			riot.mount('#wr-page', 'article-create');
		});
		route('articles/*', () => {
			riot.mount('#wr-page', 'article-describe');
		});
		route('articles/*/edit', () => {
			riot.mount('#wr-page', 'article-edit');
		});
		route('pages', () => {
			riot.mount('#wr-page', 'page-index');
		});
        route('pages/tree', () => {
            riot.mount('#wr-page', 'page-tree');
        });
        route('pages/new', () => {
            riot.mount('#wr-page', 'page-create');
        });
        route('pages/*', () => {
            riot.mount('#wr-page', 'page-describe');
        });
        route('pages/*/edit', () => {
            riot.mount('#wr-page', 'page-edit');
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
        route('customfields/new', () => {
            riot.mount('#wr-page', 'customfield-create');
        });
        route('customfields*/edit', () => {
            riot.mount('#wr-page', 'customfield-edit');
        });
        route('comments', () => {
            riot.mount('#wr-page', 'comment-index');
        });
        route('users', () => {
            riot.mount('#wr-page', 'user-index');
        });
        route('users/invite', () => {
            riot.mount('#wr-page', 'user-invitation');
        });
        route('users/*', () => {
            riot.mount('#wr-page', 'user-describe');
        });
        route('users/*/edit', () => {
            riot.mount('#wr-page', 'user-edit');
        });
        route('analytics', () => {
            riot.mount('#wr-page', 'analytics-index');
        });
        route('analytics/edit', () => {
            riot.mount('#wr-page', 'analytics-edit');
        });
        route('system', () => {
            riot.mount('#wr-page', 'system-index');
        });
        route('setup', () => {
            riot.mount('#wr-page', 'setup');
        });
        route('signup', () => {
            riot.mount('#wr-page', 'signup');
        });
    </script>
</home>