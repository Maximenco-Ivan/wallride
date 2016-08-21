<app>
	<div id="app">
		<home />
	</div>
	<script>
		var route = riot.route.create();
		route('login', () => {
			riot.mount('#app', 'login');
		});
		route('', () => {
			riot.mount('#app', 'home');
		});
//		route('/*', () => {
//			riot.mount('#app', 'home');
//		});
	</script>
</app>