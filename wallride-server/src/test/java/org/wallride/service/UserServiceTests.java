package org.wallride.service;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.wallride.domain.Blog;
import org.wallride.domain.BlogLanguage;
import org.wallride.domain.PersonalName;
import org.wallride.domain.User;
import org.wallride.exception.DuplicateEmailException;
import org.wallride.exception.DuplicateLoginIdException;
import org.wallride.model.PasswordUpdateRequest;
import org.wallride.model.ProfileUpdateRequest;
import org.wallride.model.UserDeleteRequest;
import org.wallride.model.UserUpdateRequest;
import org.wallride.repository.PasswordResetTokenRepository;
import org.wallride.repository.UserRepository;
import org.wallride.support.AuthorizedUser;

import java.util.HashSet;
import java.util.Set;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.anyLong;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Created by SHIMAUCHI on 2016/08/16.
 */
@RunWith (MockitoJUnitRunner.class)
public class UserServiceTests {

	@InjectMocks
	private UserService userService;

	@Mock
	private UserRepository userRepository;

	@Mock
	private PasswordResetTokenRepository passwordResetTokenRepository;

	@Mock
	private BlogService blogService;

	private BindingResult errors;

	private User user;

	@Before
	public void setup() {
		user = new User();
		user.setId(1L);
		user.setLoginId("beforeLoginId");
		user.setName(new PersonalName("beforeFirstName", "beforeLastName"));
		user.setNickname("beforeNickname");
		user.setEmail("before@tagbangers.co.jp");
		user.setDescription("beforeDescription");

		PasswordEncoder passwordEncoder = new StandardPasswordEncoder();
		user.setLoginPassword(passwordEncoder.encode("beforePassword"));

		BlogLanguage blogLanguage = new BlogLanguage();
		Blog blog = new Blog();
		Set<BlogLanguage> blogLanguages = new HashSet<>();

		blogLanguage.setLanguage("ja");
		blogLanguage.setBlog(blog);
		blogLanguage.setTitle("Test Blog");

		blogLanguages.add(blogLanguage);
		blog.setLanguages(blogLanguages);
		when(blogService.getBlogById(anyLong())).thenReturn(blog);
	}

	@Test
	public void updateUser() {
		when(userRepository.findOneById(anyLong())).thenReturn(user);
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(user);

		UserUpdateRequest request = new UserUpdateRequest.Builder()
				.id(user.getId())
				.loginId(user.getLoginId())
				.name(new PersonalName("afterFirstName", "afterLastName"))
				.nickname("afterNickname")
				.email("after@tagbangers.co.jp")
				.description("afterDescription")
				.build();
		userService.updateUser(request, errors, new AuthorizedUser(user));

		verify(userRepository, times(1)).saveAndFlush(user);

		user = userRepository.findOneById(user.getId());
		assertEquals("afterFirstName", user.getName().getFirstName());
		assertEquals("afterLastName", user.getName().getLastName());
		assertEquals("afterNickname", user.getNickname());
		assertEquals("after@tagbangers.co.jp", user.getEmail());
		assertEquals("afterDescription", user.getDescription());
	}

	@Test
	public void updateProfile() {
		when(userRepository.findOneById(anyLong())).thenReturn(user);
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(user);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(user.getId());
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));

		verify(userRepository, times(1)).saveAndFlush(user);

		user = userRepository.findOneById(user.getId());
		assertEquals("afterFirstName", user.getName().getFirstName());
		assertEquals("afterLastName", user.getName().getLastName());
		assertEquals("afterLoginId", user.getLoginId());
		assertEquals("after@tagbangers.co.jp", user.getEmail());
	}

	@Test(expected = IllegalArgumentException.class)
	public void updateProfileNotExistsUser() {
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(null);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(user.getId());
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}

	@Test(expected = DuplicateEmailException.class)
	public void updateProfileDuplicateEmail() {
		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);

		User duplicated = new User();
		duplicated.setEmail("duplicate@tagbangers.co.jp");
		when(userRepository.findOneByEmail(anyString())).thenReturn(duplicated);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(user.getId());
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}

	@Test(expected = DuplicateLoginIdException.class)
	public void updateProfileDuplicateLoginId() {
		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);

		User duplicated = new User();
		duplicated.setLoginId("duplicateLoginId");
		when(userRepository.findOneByLoginId(anyString())).thenReturn(duplicated);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(user.getId());
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}

	@Test
	public void updatePasswordWithPasswordResetToken() {
//		when(userRepository.findOneById(anyLong())).thenReturn(user);
//		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);
//
//		PasswordUpdateRequest request = new PasswordUpdateRequest();
//		request.setUserId(user.getId());
//		request.setPassword("newPassword");
//		request.setLanguage("ja");
//
//		PasswordResetToken token = new PasswordResetToken();
//		token.setUser(user);
//		token.setEmail(user.getEmail());
//
//		userService.updatePassword(request, token);
//
//		verify(userRepository, times(1)).saveAndFlush(user);
	}

	@Test
	public void updatePassword() {
		when(userRepository.findOneById(anyLong())).thenReturn(user);
		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);

		PasswordUpdateRequest request = new PasswordUpdateRequest();
		request.setUserId(user.getId());
		request.setPassword("newPassword");
		request.setLanguage("ja");

		userService.updatePassword(request, new AuthorizedUser(user));

		verify(userRepository, times(1)).saveAndFlush(user);

		user = userRepository.findOneById(user.getId());
		PasswordEncoder passwordEncoder = new StandardPasswordEncoder();
		assertEquals(passwordEncoder.matches("newPassword", user.getLoginPassword()), true);
	}

	@Test(expected = IllegalArgumentException.class)
	public void updatePasswordNotExistsUser() {
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(null);

		PasswordUpdateRequest request = new PasswordUpdateRequest();
		request.setUserId(user.getId());
		request.setPassword("newPassword");
		request.setLanguage("ja");

		userService.updatePassword(request, new AuthorizedUser(user));
	}

	@Test
	public void deleteUser() {
		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);

		UserDeleteRequest request = new UserDeleteRequest.Builder()
				.id(user.getId())
				.build();
		try {
			userService.deleteUser(request, errors);
		}
		catch (BindException e) {}

		verify(userRepository, times(1)).delete(user);
	}
}
