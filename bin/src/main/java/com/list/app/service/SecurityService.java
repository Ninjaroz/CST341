package com.list.app.service;

public interface SecurityService {
    String findLoggedInUsername();

    void autologin(String username, String password);
}
