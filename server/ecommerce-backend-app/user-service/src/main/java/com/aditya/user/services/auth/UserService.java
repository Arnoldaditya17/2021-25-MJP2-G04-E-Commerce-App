package com.aditya.user.services.auth;

import com.aditya.user.dtos.RegisterUserDto;
import com.aditya.user.enums.RoleEnum;
import com.aditya.user.models.Role;
import com.aditya.user.models.User;
import com.aditya.user.repositories.RoleRepository;
import com.aditya.user.repositories.UserRepository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final PasswordEncoder passwordEncoder;

	public UserService(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public List<User> allUsers() {
		List<User> users = new ArrayList<>();

		userRepository.findAll().forEach(users::add);

		return users;
	}

	public User createAdministrator(RegisterUserDto input) {
		Optional<Role> optionalRole = roleRepository.findByName(RoleEnum.ADMIN);

		if (optionalRole.isEmpty()) {
			return null;
		}

		var user = new User();
		user.setName(input.getName());
		user.setEmail(input.getEmail());
		user.setPassword(passwordEncoder.encode(input.getPassword()));
		user.setRole(optionalRole.get());

		return userRepository.save(user);
	}

	public User getCurrentSessionUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		return (User) authentication.getPrincipal();
	}
}
