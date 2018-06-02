package com.list.app.service;

import com.list.app.model.User;

public interface UserService {
    void save(User user);
    User findByUsername(String username);
}
