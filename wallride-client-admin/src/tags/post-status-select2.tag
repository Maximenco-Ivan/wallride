<post-status-select2>
	<select th:field="" class="select2" th:placeholder="">
		<option value=""></option>
		<option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
		<option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
		<option th:value=""><span th:text="">Published</span> <span th:text="">(0)</span></option>
	</select>
	<script>
		this.on('mount', () => {
			$('select', this.root).select2({
				allowClear: true,
				dropdownAutoWidth: true,
				dropdownCssClass: 'select2-drop-search-form',
			});
		});
	</script>
</post-status-select2>
