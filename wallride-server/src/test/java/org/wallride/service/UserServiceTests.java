package org.wallride.service;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.validation.BindingResult;
import org.wallride.domain.PersonalName;
import org.wallride.domain.User;
import org.wallride.exception.DuplicateEmailException;
import org.wallride.exception.DuplicateLoginIdException;
import org.wallride.model.PasswordUpdateRequest;
import org.wallride.model.ProfileUpdateRequest;
import org.wallride.model.UserUpdateRequest;
import org.wallride.repository.UserRepository;
import org.wallride.support.AuthorizedUser;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.anyLong;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 * Created by SHIMAUCHI on 2016/08/16.
 */
@RunWith (MockitoJUnitRunner.class)
public class UserServiceTests {

	@InjectMocks
	private UserService userService;

	@Mock
	private UserRepository userRepository;

	private BindingResult errors;

	private User user;

	private long userId = 1L;

	@Before
	public void setup() {
		user = new User();
		user.setId(userId);
		user.setLoginId("beforeLoginId");
		user.setName(new PersonalName("beforeFirstName", "beforeLastName"));
		user.setNickname("beforeNickname");
		user.setEmail("before@tagbangers.co.jp");
		user.setDescription("beforeDescription");
	}

	@Test
	public void updateUser() {
		when(userRepository.findOneById(anyLong())).thenReturn(user);
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(user);

		UserUpdateRequest request = new UserUpdateRequest.Builder()
				.id(userId)
				.loginId(user.getLoginId())
				.name(new PersonalName("afterFirstName", "afterLastName"))
				.nickname("afterNickname")
				.email("after@tagbangers.co.jp")
				.description("afterDescription")
				.build();
		userService.updateUser(request, errors, new AuthorizedUser(user));

		verify(userRepository, times(1)).saveAndFlush(user);

		user = userRepository.findOneById(userId);
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
		request.setUserId(userId);
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));

		verify(userRepository, times(1)).saveAndFlush(user);

		user = userRepository.findOneById(userId);
		assertEquals("afterFirstName", user.getName().getFirstName());
		assertEquals("afterLastName", user.getName().getLastName());
		assertEquals("afterLoginId", user.getLoginId());
		assertEquals("after@tagbangers.co.jp", user.getEmail());
	}

	@Test(expected = IllegalArgumentException.class)
	public void updateProfileNotExistsUser() {
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(null);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(userId);
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}

	@Test(expected = DuplicateEmailException.class)
	public void updateProfileDuplicateEmail() {
		when(userRepository.findOneForUpdateById(userId)).thenReturn(user);

		User duplicated = new User();
		duplicated.setEmail("duplicate@tagbangers.co.jp");
		when(userRepository.findOneByEmail(anyString())).thenReturn(duplicated);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(userId);
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}

	@Test(expected = DuplicateLoginIdException.class)
	public void updateProfileDuplicateLoginId() {
		when(userRepository.findOneForUpdateById(userId)).thenReturn(user);

		User duplicated = new User();
		duplicated.setLoginId("duplicateLoginId");
		when(userRepository.findOneByLoginId(anyString())).thenReturn(duplicated);

		ProfileUpdateRequest request = new ProfileUpdateRequest();
		request.setUserId(userId);
		request.setLoginId("afterLoginId");
		request.setEmail("after@tagbangers.co.jp");
		request.setName(new PersonalName("afterFirstName", "afterLastName"));

		userService.updateProfile(request, new AuthorizedUser(user));
	}
}
