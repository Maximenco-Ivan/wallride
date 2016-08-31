package org.wallride.web.contorller.guest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.powermock.modules.junit4.PowerMockRunner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.ui.Model;
import org.wallride.domain.Tag;
import org.wallride.model.TagSearchRequest;
import org.wallride.service.PostService;
import org.wallride.service.TagService;
import org.wallride.web.controller.guest.TagController;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
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

	@Test
	public void index() {
		Pageable pageable = new PageRequest(0, 10);
		Model model = mock(Model.class);
		List<Tag> results = new ArrayList<>();
		Page<Tag> pages = new PageImpl<>(results, pageable, 10);

		when(tagService.getTags(any(TagSearchRequest.class), any(Pageable.class))).thenReturn(pages);
		String viewName = tagController.index(pageable, model, request);
		verify(tagService, times(1)).getTags(any(TagSearchRequest.class), any(Pageable.class));
		assertEquals("tag/index", viewName);
	}
}
