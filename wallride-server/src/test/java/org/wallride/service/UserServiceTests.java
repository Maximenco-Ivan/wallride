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
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.thymeleaf.TemplateEngine;
import org.wallride.domain.*;
import org.wallride.exception.DuplicateEmailException;
import org.wallride.exception.DuplicateLoginIdException;
import org.wallride.exception.EmailNotFoundException;
import org.wallride.model.*;
import org.wallride.repository.PasswordResetTokenRepository;
import org.wallride.repository.UserInvitationRepository;
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
	private UserInvitationRepository userInvitationRepository;

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

	private MimeMessage mimeMessage;

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

		Blog blog = new Blog();
		Set<BlogLanguage> blogLanguages = new HashSet<>();

		BlogLanguage blogLanguage1 = new BlogLanguage();
		blogLanguage1.setId(1L);
		blogLanguage1.setLanguage("ja");
		blogLanguage1.setBlog(blog);
		blogLanguage1.setTitle("blog ja");

		BlogLanguage blogLanguage2 = new BlogLanguage();
		blogLanguage1.setId(2L);
		blogLanguage2.setLanguage("en");
		blogLanguage2.setBlog(blog);
		blogLanguage2.setTitle("blog en");

		blogLanguages.add(blogLanguage1);
		blogLanguages.add(blogLanguage2);

		blog.setLanguages(blogLanguages);
		when(blogService.getBlogById(anyLong())).thenReturn(blog);

		Map<String, String> properties = new HashMap<>();
		properties.put("mail.from", "test@tagbangers.co.jp");
		when(mailProperties.getProperties()).thenReturn(properties);

		when(templateEngine.process(anyString(), anyObject())).thenReturn("<html><head></head><body><div>test</div></body></html>");

		mimeMessage = new MimeMessage(Session.getInstance(new Properties()));
		when(mailSender.createMimeMessage()).thenReturn(mimeMessage);
	}

	// TODO handle ServiceException
	// UserService#createPasswordResetToken()
	// UserService#updatePassword()

	@Test
	public void createPasswordResetToken() {
		when(messageSourceAccessor.getMessage("PasswordResetSubject", LocaleContextHolder.getLocale())).thenReturn("test");
		when(userRepository.findOneByEmail(anyString())).thenReturn(user);

		PasswordResetTokenCreateRequest request = new PasswordResetTokenCreateRequest();
		request.setEmail("reset@tagbangers.co.jp");

		PasswordResetToken token = new PasswordResetToken();
		token.setUser(user);
		token.setEmail(user.getEmail());
		when(passwordResetTokenRepository.saveAndFlush(anyObject())).thenReturn(token);

		userService.createPasswordResetToken(request);
		verify(passwordResetTokenRepository, times(1)).saveAndFlush(anyObject());
		verify(mailSender, times(1)).send(mimeMessage);
	}

	@Test(expected = EmailNotFoundException.class)
	public void createPasswordResetTokenNotExistsUser() {
		when(userRepository.findOneByEmail(anyString())).thenReturn(null);

		PasswordResetTokenCreateRequest request = new PasswordResetTokenCreateRequest();
		request.setEmail("reset@tagbangers.co.jp");

		userService.createPasswordResetToken(request);
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
		when(messageSourceAccessor.getMessage("PasswordChangedSubject", LocaleContextHolder.getLocale())).thenReturn("test");
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

	@Test(expected = IllegalArgumentException.class)
	public void updatePasswordWithPasswordResetTokenNotExistsUser() {
		when(userRepository.findOneForUpdateById(anyLong())).thenReturn(null);

		PasswordUpdateRequest request = new PasswordUpdateRequest();
		request.setUserId(user.getId());

		PasswordResetToken token = new PasswordResetToken();
		token.setUser(user);
		token.setEmail(user.getEmail());

		userService.updatePassword(request, token);
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

	@Test
	public void bulkDeleteUser() {
		// TODO
	}

	@Test
	public void inviteUsers() {
		when(messageSourceAccessor.getMessage("InvitationMessageTitle", LocaleContextHolder.getLocale())).thenReturn("test");

		StringBuilder inviteUsers = new StringBuilder();
		inviteUsers.append("invite1@tagbangers.co.jp");
		inviteUsers.append(",");
		inviteUsers.append("invite2@tagbangers.co.jp");
		int inviteUserCount = StringUtils.commaDelimitedListToStringArray(inviteUsers.toString()).length;

		UserInvitation invitation1 = new UserInvitation();
		invitation1.setEmail("invite1@tagbangers.co.jp");
		UserInvitation invitation2 = new UserInvitation();
		invitation2.setEmail("invite2@tagbangers.co.jp");

		UserInvitationCreateRequest request = new UserInvitationCreateRequest.Builder()
				.invitees(inviteUsers.toString())
				.build();

		when(userInvitationRepository.saveAndFlush(any(UserInvitation.class)))
				.thenReturn(invitation1)
				.thenReturn(invitation2);

		userService.inviteUsers(request, errors, new AuthorizedUser(user));

		verify(userInvitationRepository, times(inviteUserCount)).saveAndFlush(anyObject());
		verify(mailSender, times(inviteUserCount)).send(mimeMessage);
	}

	@Test
	public void inviteAgain() {
		when(messageSourceAccessor.getMessage("InvitationMessageTitle", LocaleContextHolder.getLocale())).thenReturn("test");

		UserInvitation invitation = new UserInvitation();
		invitation.setEmail("invite@tagbangers.co.jp");
		UserInvitationResendRequest request = new UserInvitationResendRequest.Builder()
				.token("test")
				.build();

		when(userInvitationRepository.findOneForUpdateByToken(anyString())).thenReturn(invitation);
		when(userInvitationRepository.saveAndFlush(anyObject())).thenReturn(invitation);

		userService.inviteAgain(request, errors, new AuthorizedUser(user));

		verify(userInvitationRepository, times(1)).saveAndFlush(anyObject());
		verify(mailSender, times(1)).send(mimeMessage);
	}

	@Test
	public void deleteUserInvitation() {
		UserInvitation invitation = new UserInvitation();
		invitation.setEmail("invite@tagbangers.co.jp");
		UserInvitationDeleteRequest request = new UserInvitationDeleteRequest.Builder()
				.token("test")
				.build();
		when(userInvitationRepository.findOneForUpdateByToken(anyString())).thenReturn(invitation);

		userService.deleteUserInvitation(request);

		verify(userInvitationRepository, times(1)).delete(invitation);
	}

	@Test
	public void getUserIds() {
		// TODO
	}

	@Test
	public void getUsers() {
		// TODO
	}

	@Test
	public void getUsersWithPageable() {
		// TODO
	}

	@Test
	public void getUsersWithIds() {
		// TODO
	}

	@Test
	public void getUserById() {
		// TODO
	}

	@Test
	public void getUserInvitations() {
		// TODO
	}

	@Test
	public void getPasswordResetToken() {
		// TODO
	}
}
