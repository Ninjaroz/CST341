package com.list.app.service;

import com.list.app.model.Role;
import com.list.app.model.User;
import com.list.app.repository.RoleRepository;
import com.list.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Set;

import java.util.HashSet;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
    	String json ="";
    	ObjectMapper mapper = new ObjectMapper();
    	Set<Role> roles = new HashSet<>(roleRepository.findAll());
    	try {
			json = mapper.writeValueAsString(roles);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(json);
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
