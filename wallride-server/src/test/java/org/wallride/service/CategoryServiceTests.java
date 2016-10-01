package org.wallride.service;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.wallride.domain.PersonalName;
import org.wallride.domain.User;
import org.wallride.model.CategoryCreateRequest;
import org.wallride.repository.CategoryRepository;
import org.wallride.support.AuthorizedUser;

/**
 * Created by SHIMAUCHI on 2016/09/23.
 */
@RunWith(MockitoJUnitRunner.class)
public class CategoryServiceTests {

	@InjectMocks
	private CategoryService categoryService;

	@Mock
	private CategoryRepository categoryRepository;

	private User user;

	@Before
	public void setupUser() {
		user = new User();
		user.setId(1L);
		user.setLoginId("categoryTest");
		user.setName(new PersonalName("Test", "Category"));
	}

	@Test
	public void createCategory() {
		CategoryCreateRequest request = new CategoryCreateRequest();
		categoryService.createCategory(request, new AuthorizedUser(user));

		//TODO Verification
	}
}
