package org.wallride.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.modules.junit4.PowerMockRunner;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.wallride.domain.Article;
import org.wallride.domain.Post;
import org.wallride.repository.PopularPostRepository;
import org.wallride.repository.PostRepository;

import javax.servlet.ServletContext;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;
import static org.wallride.autoconfigure.WallRideCacheConfiguration.ARTICLE_CACHE;
import static org.wallride.autoconfigure.WallRideCacheConfiguration.PAGE_CACHE;

/**
 * Created by SHIMAUCHI on 2016/08/26.
 */
@RunWith (PowerMockRunner.class)
public class PostServiceTests {

	@InjectMocks
	private PostService postService;

	@Mock
	private CacheManager cacheManager;
	@Mock
	private ServletContext servletContext;

	@Mock
	private JobLauncher jobLauncher;
	@Mock
	private JobExplorer jobExplorer;
	@Mock
	private Job updatePostViewsJob;

	@Mock
	private BlogService blogService;

	@Mock
	private PostRepository postRepository;
	@Mock
	private PopularPostRepository popularPostRepository;

	@Test
	public void publishScheduledPosts() {
		List<Post> posts = new ArrayList<>();
		Article article = new Article();
		posts.add(article);
		Cache cache = PowerMockito.mock(Cache.class);
		when(postRepository.findAllByStatusAndDateLessThanEqual(any(Post.Status.class), any(LocalDateTime.class))).thenReturn(posts);
		when(cacheManager.getCache(ARTICLE_CACHE)).thenReturn(cache);
		when(cacheManager.getCache(PAGE_CACHE)).thenReturn(cache);

		posts = postService.publishScheduledPosts();

		verify(postRepository, times(posts.size())).saveAndFlush(any(Post.class));
		verify(cacheManager, times(1)).getCache(ARTICLE_CACHE);
		verify(cacheManager, times(1)).getCache(PAGE_CACHE);

		for (Post post : posts) {
			assertEquals(post.getStatus(), Post.Status.PUBLISHED);
		}
	}
}
