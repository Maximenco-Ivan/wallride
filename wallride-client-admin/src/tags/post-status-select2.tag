<post-status-select2>
	<select th:field="*{status}" class="select2" th:placeholder="#{Status}">
		<option value=""></option>
		<option th:value="PUBLISHED"><span th:text="#{Post.Status.PUBLISHED}">Published</span> <span th:text="">(0)</span></option>
		<option th:value="SCHEDULED"><span th:text="#{Post.Status.SCHEDULED}">Published</span> <span th:text="">(0)</span></option>
		<option th:value="DRAFT"><span th:text="#{Post.Status.DRAFT}">Published</span> <span th:text="">(0)</span></option>
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
