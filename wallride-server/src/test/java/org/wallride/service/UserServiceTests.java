package org.wallride.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.validation.BindingResult;
import org.wallride.domain.PersonalName;
import org.wallride.domain.User;
import org.wallride.model.UserUpdateRequest;
import org.wallride.repository.UserRepository;
import org.wallride.support.AuthorizedUser;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.anyLong;
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

	@Test
	public void updateUser() {
		long userId = 1L;
		User user = new User();
		user.setId(userId);
		user.setLoginId("test_login_id");
		user.setName(new PersonalName("beforeFirstName", "beforeLastName"));
		user.setNickname("beforeNickname");
		user.setEmail("before@tagbangers.co.jp");
		user.setDescription("beforeDescription");

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
}
