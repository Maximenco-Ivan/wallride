<login xmlns:th="http://www.thymeleaf.org">
	<div class="container">
		<form th:action="" action="dashboard.html" th:method="" method="get" class="form-signin" onsubmit="{ submit }">
			<h2 th:text="" class="form-signin-heading">WallRide</h2>
			<input type="text" name="username" class="form-control" th:attr="" autofocus="autofocus" autocomplete="off" />
			<input type="password" name="password" class="form-control" th:attr="" autocomplete="off" />
			<label class="checkbox"> <input type="checkbox" name="remember-me" th:text=""/>Remember me</label>
			<button class="btn btn-lg btn-primary btn-block" type="submit" th:text="">Log in</button>
		</form>
	</div>
	<script>
		this.submit = (e) => {
			console.log(this.username.value);
			console.log(this.password.value);

			riot.route('/');
			e.preventDefault();
		};
	</script>
	<style scoped>
		body {
			padding-top: 40px;
			padding-bottom: 40px;
		}
		.form-signin {
			max-width: 330px;
			padding: 15px;
			margin: 0 auto;
		}
		.form-signin .form-signin-heading,
		.form-signin .checkbox {
			margin-bottom: 20px;
		}
		.form-signin-heading {
			font-size: 26px;
			font-weight: bold;
			color: #ccc;
			font-family: "freight-sans-pro","Myriad Pro","Lucida Grande","Lucida Sans Unicode","Lucida Sans",Geneva,Verdana,sans-serif;
		}
		.form-signin .checkbox {
			font-weight: normal;
		}
		.form-signin .form-control {
			position: relative;
			font-size: 16px;
			height: auto;
			padding: 10px;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
		}
		.form-signin .form-control:focus {
			z-index: 2;
		}
		.form-signin input[type="text"] {
			margin-bottom: -1px;
			border-bottom-left-radius: 0;
			border-bottom-right-radius: 0;
		}
		.form-signin input[type="password"] {
			margin-bottom: 10px;
			border-top-left-radius: 0;
			border-top-right-radius: 0;
		}
	</style>
</login>
