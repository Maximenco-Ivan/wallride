<nav-global xmlns:th="http://www.thymeleaf.org">
	<div id="wr-global-nav">
		<div class="navbar-header">
			<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#wr-blog-nav">
				<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<p class="navbar-brand"><img th:src="" src="/img/wr-logo.png" /></p>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-left">
				<li id="wr-blog-title">
					<a href="../../../wallride-server/src/main/resources/templates" th:text="">WallRide</a>
				</li>
				<li>
					<a href="#" target="_blank" style="font-size:15px;"><span class="glyphicon glyphicon-share-alt"></span> <span th:text="">http://www.wallride.org</span></a>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown wr-account">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<img th:src=""/img/gravatar.jpeg" class="wr-account-picture"/>
						&nbsp;&nbsp;<span th:text=""></span>
					</a>
					<ul class="dropdown-menu">
						<li><a><span class="glyphicon glyphicon-user"></span> <span th:text="">プロフィール</span></a></li>
						<li><a><span class="glyphicon glyphicon-off"></span> <span th:text="">ログアウト</span></a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav-global>