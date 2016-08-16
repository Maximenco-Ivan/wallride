package org.wallride.service;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.thymeleaf.TemplateEngine;
import org.wallride.domain.*;
import org.wallride.exception.DuplicateEmailException;
import org.wallride.exception.DuplicateLoginIdException;
import org.wallride.model.PasswordUpdateRequest;
import org.wallride.model.ProfileUpdateRequest;
import org.wallride.model.UserDeleteRequest;
import org.wallride.model.UserUpdateRequest;
import org.wallride.repository.PasswordResetTokenRepository;
import org.wallride.repository.UserRepository;
import org.wallride.support.AuthorizedUser;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import java.util.*;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.anyLong;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Created by SHIMAUCHI on 2016/08/16.
 */
@RunWith (PowerMockRunner.class)
@PrepareForTest ({TemplateEngine.class})
public class UserServiceTests {

	@InjectMocks
	private UserService userService;

	@Mock
	private UserRepository userRepository;

	@Mock
	private PasswordResetTokenRepository passwordResetTokenRepository;

	@Mock
	private BlogService blogService;

	@Mock
	private JavaMailSender mailSender;

	@Mock
	private MessageSourceAccessor messageSourceAccessor;

	@Mock
	private MailProperties mailProperties;

	@Mock
	private TemplateEngine templateEngine;

	private BindingResult errors;

	private User user;

	@BeforeClass
	public static void beforeClass() {
		MockHttpServletRequest request = new MockHttpServletRequest();
		MockHttpSession session = new MockHttpSession();
		request.setSession(session);
		RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
	}

	@Before
	public void before() {
		user = new User();
		user.setId(1L);
		user.setLoginId("beforeLoginId");
		user.setName(new PersonalName("beforeFirstName", "beforeLastName"));
		user.setNickname("beforeNickname");
		user.setEmail("before@tagbangers.co.jp");
		user.setDescription("beforeDescription");

		PasswordEncoder passwordEncoder = new StandardPasswordEncoder();
		user.setLoginPassword(passwordEncoder.encode("beforePassword"));
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
		BlogLanguage blogLanguage = new BlogLanguage();
		Blog blog = new Blog();
		Set<BlogLanguage> blogLanguages = new HashSet<>();

		blogLanguage.setLanguage("ja");
		blogLanguage.setBlog(blog);
		blogLanguage.setTitle("Test Blog");

		blogLanguages.add(blogLanguage);
		blog.setLanguages(blogLanguages);
		when(blogService.getBlogById(anyLong())).thenReturn(blog);

		MimeMessage mimeMessage = new MimeMessage(Session.getInstance(new Properties()));
		when(mailSender.createMimeMessage()).thenReturn(mimeMessage);
		when(messageSourceAccessor.getMessage("PasswordChangedSubject", LocaleContextHolder.getLocale())).thenReturn("test");

		Map<String, String> properties = new HashMap<>();
		properties.put("mail.from", "test@tagbangers.co.jp");
		when(mailProperties.getProperties()).thenReturn(properties);

		when(templateEngine.process(anyString(), anyObject())).thenReturn("<html><head></head><body><div>test</div></body></html>");

		when(userRepository.findOneById(anyLong())).thenReturn(user);
		when(userRepository.findOneForUpdateById(user.getId())).thenReturn(user);

		PasswordUpdateRequest request = new PasswordUpdateRequest();
		request.setUserId(user.getId());
		request.setPassword("newPassword");
		request.setLanguage("ja");

		PasswordResetToken token = new PasswordResetToken();
		token.setUser(user);
		token.setEmail(user.getEmail());

		userService.updatePassword(request, token);

		user = userRepository.findOneById(user.getId());
		PasswordEncoder passwordEncoder = new StandardPasswordEncoder();
		assertEquals(passwordEncoder.matches("newPassword", user.getLoginPassword()), true);

		verify(passwordResetTokenRepository, times(1)).delete(token);
		verify(userRepository, times(1)).saveAndFlush(user);
		verify(mailSender, times(1)).send(mimeMessage);
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
