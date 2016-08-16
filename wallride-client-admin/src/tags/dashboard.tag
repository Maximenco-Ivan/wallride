<dashboard xmlns:th="http://www.thymeleaf.org">
	<div id="wr-page">
		<div id="wr-page-header">
			<div class="page-header container-fluid">
				<h1 th:text="#{Dashboard}">Dashboard</h1>
			</div>
		</div>
		<div id="wr-page-content">
			<div class="container-fluid">
				<div class="row wr-dashboard">
					<div class="col-sm-2">
						<h2 th:text="#{Content}">Content</h2>
						<table class="table">
							<tr>
								<th th:text="${articleCount}">11</th>
								<td th:text="#{Posts}">Posts</td>
							</tr>
							<tr>
								<th th:text="${pageCount}">11</th>
								<td th:text="#{Pages}">Pages</td>
							</tr>
							<tr>
								<th th:text="${categoryCount}">11</th>
								<td th:text="#{Categories}">Categories</td>
							</tr>
						</table>
					</div>
					<div class="col-sm-10">
						<div class="row">
							<div class="col-sm-6">
								<h2 th:text="#{NewPosts}">New Posts</h2>
								<dl th:each="article : ${recentPublishedArticles}">
									<dt><a th:text="${article.title}">Title</a></dt>
									<dd th:text="">yyyy/MM/dd</dd>
								</dl>
							</div>
							<div class="col-sm-6">
								<h2 th:text="#{Drafts}">Drafts</h2>
								<dl th:each="article : ${recentDraftArticles}">
									<dt><a th:text="${article.title}?:'(No Titled)'">Title</a></dt>
									<dd th:text="">yyyy/MM/dd HH:mm Last Modified</dd>
								</dl>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<h2 th:text="#{PopularPosts}">Popular Posts</h2>
								<dl th:each="popularPost : ${popularPosts}">
									<dt><a th:text="${popularPost.post.title}">Title</a></dt>
									<dd th:text="">yyyy/MM/dd</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</dashboard>