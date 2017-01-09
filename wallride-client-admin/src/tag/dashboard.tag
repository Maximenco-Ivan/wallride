<dashboard xmlns:th="http://www.thymeleaf.org">
	<div id="wr-page-header">
		<div class="page-header container-fluid">
			<h1 th:text="">Dashboard</h1>
		</div>
	</div>
	<div id="wr-page-content">
		<div class="container-fluid">
			<div class="row wr-dashboard">
				<div class="col-sm-2">
					<h2 th:text="">Content</h2>
					<table class="table">
						<tr>
							<th th:text="">11</th>
							<td th:text="">Posts</td>
						</tr>
						<tr>
							<th th:text="">11</th>
							<td th:text="">Pages</td>
						</tr>
						<tr>
							<th th:text="">11</th>
							<td th:text="">Categories</td>
						</tr>
					</table>
				</div>
				<div class="col-sm-10">
					<div class="row">
						<div class="col-sm-6">
							<h2 th:text="">New Posts</h2>
							<dl th:each="">
								<dt><a th:text="">Title</a></dt>
								<dd th:text="">yyyy/MM/dd</dd>
							</dl>
						</div>
						<div class="col-sm-6">
							<h2 th:text="">Drafts</h2>
							<dl th:each="">
								<dt><a th:text="">Title</a></dt>
								<dd th:text="">yyyy/MM/dd HH:mm Last Modified</dd>
							</dl>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<h2 th:text="">Popular Posts</h2>
							<dl th:each="">
								<dt><a th:text="">Title</a></dt>
								<dd th:text="">yyyy/MM/dd</dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</dashboard>