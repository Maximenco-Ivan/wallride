package org.wallride.web.contorller.guest;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ErrorCollector;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.wallride.domain.Blog;
import org.wallride.domain.BlogLanguage;
import org.wallride.domain.Tag;
import org.wallride.model.TagSearchRequest;
import org.wallride.service.PostService;
import org.wallride.service.TagService;
import org.wallride.web.controller.guest.TagController;
import org.wallride.web.support.HttpNotFoundException;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;
/**
 * Created by SHIMAUCHI on 2016/08/31.
 */
@RunWith(MockitoJUnitRunner.class)
public class TagControllerTests {

	@InjectMocks
	private TagController tagController;

	@Mock
	private TagService tagService;

	@Mock
	private PostService postService;

	private MockHttpServletRequest request = new MockHttpServletRequest();

	@Rule
	public ErrorCollector collector = new ErrorCollector();

	@Rule
	public ExpectedException expectedException = ExpectedException.none();

	private Pageable pageable;
	private Model model;
	private Blog blog;
	private BlogLanguage language;
	private Tag tag;

	@Before
	public void setup() {
		pageable = new PageRequest(0, 10);
		model = new ExtendedModelMap();
	}

	@Before
	public void setupBlog() {
		blog = new Blog();
		blog.setDefaultLanguage("ja");
		language = new BlogLanguage();
		language.setLanguage("en");
		language.setBlog(blog);
		tag = new Tag();
		tag.setLanguage("ja");
	}

	@Test
	public void index() {
		List<Tag> results = new ArrayList<>();
		Page<Tag> pages = new PageImpl<>(results, pageable, 10);

		when(tagService.getTags(any(TagSearchRequest.class), any(Pageable.class))).thenReturn(pages);
		String viewName = tagController.index(pageable, model, request);
		verify(tagService, times(1)).getTags(any(TagSearchRequest.class), any(Pageable.class));
		collector.checkThat(viewName, is("tag/index"));
		collector.checkThat(model.containsAttribute("tags"), is(true));
		collector.checkThat(model.containsAttribute("pageable"), is(true));
		collector.checkThat(model.containsAttribute("pagination"), is(true));
	}

	@Test
	public void post() {
		when(tagService.getTagByName("test", "en")).thenReturn(null);
		when(tagService.getTagByName("test", "ja")).thenReturn(tag);

		String viewName = tagController.post("test", pageable, language, model, request);

		collector.checkThat(viewName, is("tag/post"));
		collector.checkThat(model.containsAttribute("tag"), is(true));
		collector.checkThat(model.containsAttribute("posts"), is(true));
		collector.checkThat(model.containsAttribute("pageable"), is(true));
		collector.checkThat(model.containsAttribute("pagination"), is(true));
	}

	@Test
	public void postWhenNotFoundTag() {
		when(tagService.getTagByName("test", "en")).thenReturn(null);
		when(tagService.getTagByName("test", "ja")).thenReturn(null);
		expectedException.expect(HttpNotFoundException.class);
		tagController.post("test", pageable, language, model, request);
	}
}
