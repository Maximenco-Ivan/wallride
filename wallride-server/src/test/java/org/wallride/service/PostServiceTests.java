package org.wallride.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.data.domain.Pageable;
import org.wallride.domain.Article;
import org.wallride.domain.Post;
import org.wallride.exception.ServiceException;
import org.wallride.model.PostSearchRequest;
import org.wallride.repository.PopularPostRepository;
import org.wallride.repository.PostRepository;

import javax.servlet.ServletContext;
import java.time.LocalDateTime;
import java.util.*;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;
import static org.wallride.autoconfigure.WallRideCacheConfiguration.ARTICLE_CACHE;
import static org.wallride.autoconfigure.WallRideCacheConfiguration.PAGE_CACHE;

/**
 * Created by SHIMAUCHI on 2016/08/26.
 */
@RunWith (MockitoJUnitRunner.class)
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
		Cache cache = mock(Cache.class);
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

	@Test
	public void updatePostViews() throws JobParametersInvalidException, JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException {
		Set<JobExecution> jobExecutions = new HashSet<>();
		when(jobExplorer.findRunningJobExecutions(anyString())).thenReturn(jobExecutions);
		postService.updatePostViews();
		verify(jobLauncher, times(1)).run(any(Job.class), any(JobParameters.class));
	}

	@Test
	public void updatePostViewsSkipJob() throws JobParametersInvalidException, JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException {
		JobExecution jobExecution = new JobExecution(1L);
		jobExecution.setStartTime(new Date());
		Set<JobExecution> jobExecutions = new HashSet<>();
		jobExecutions.add(jobExecution);
		when(jobExplorer.findRunningJobExecutions(anyString())).thenReturn(jobExecutions);
		postService.updatePostViews();
		verify(jobLauncher, never()).run(any(Job.class), any(JobParameters.class));
	}

	@Test(expected = ServiceException.class)
	public void updatePostViewsCannotContinueJob() throws JobParametersInvalidException, JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException {
		Set<JobExecution> jobExecutions = new HashSet<>();
		when(jobExplorer.findRunningJobExecutions(anyString())).thenReturn(jobExecutions);
		doThrow(JobParametersInvalidException.class).when(jobLauncher).run(any(Job.class), any(JobParameters.class));
		postService.updatePostViews();
	}

	@Test
	public void getPosts() {
		PostSearchRequest request = new PostSearchRequest("ja");
		postService.getPosts(request);
		verify(postRepository, times(1)).search(any(PostSearchRequest.class), any(Pageable.class));
	}
}
