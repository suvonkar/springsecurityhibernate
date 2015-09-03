package com.security.users.dao;

import com.security.users.model.User;

public interface UserDao {

	User findByUserName(String username);

}