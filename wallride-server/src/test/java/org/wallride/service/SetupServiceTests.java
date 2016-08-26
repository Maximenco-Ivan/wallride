package org.wallride.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.wallride.domain.Blog;
import org.wallride.domain.PersonalName;
import org.wallride.domain.User;
import org.wallride.model.SetupRequest;
import org.wallride.repository.BlogRepository;
import org.wallride.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;

/**
 * Created by SHIMAUCHI on 2016/08/25.
 */
@RunWith(MockitoJUnitRunner.class)
public class SetupServiceTests {

	@InjectMocks
	private SetupService setupService;

	@Mock
	private UserRepository userRepository;

	@Mock
	private BlogRepository blogRepository;

	private PasswordEncoder passwordEncoder = new StandardPasswordEncoder();

	private String email = "test@tagbangers.co.jp";
	private String loginId = "tagbangers";
	private String loginPassword = "loginPassword";
	private PersonalName personalName = new PersonalName("testNameFirst", "testNameLast");
	private String websiteTitle = "Tagbangers Blog";

	@Test
	public void setup() {
		List<String> languages = new ArrayList<>();
		languages.add("en");

		SetupRequest request = new SetupRequest.Builder()
				.defaultLanguage("ja")
				.languages(languages)
				.email(email)
				.loginId(loginId)
				.loginPassword(loginPassword)
				.name(personalName)
				.websiteTitle(websiteTitle)
				.build();

		when(userRepository.saveAndFlush(any(User.class))).thenReturn(new User());
		setupService.setup(request);

		ArgumentCaptor<User> userCaptor = ArgumentCaptor.forClass(User.class);
		verify(userRepository).saveAndFlush(userCaptor.capture());

		verify(blogRepository, times(1)).saveAndFlush(any(Blog.class));
		verify(userRepository, times(1)).saveAndFlush(any(User.class));

		User user = userCaptor.getValue();
		assertEquals(user.getEmail(), request.getEmail());
		assertEquals(user.getLoginId(), request.getLoginId());
		assertEquals(passwordEncoder.matches(loginPassword, user.getLoginPassword()), true);
		assertEquals(user.getName().getFirstName(), personalName.getFirstName());
		assertEquals(user.getName().getLastName(), personalName.getLastName());
	}
}
