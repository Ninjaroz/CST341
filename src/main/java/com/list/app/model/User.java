package com.list.app.model;


import javax.persistence.*;

@Entity
@Table(name = "user", schema = "listapp")
public class User {
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.AUTO)
    private Long userId;
	
	@Column(name="username")
    private String username;
	
	@Column(name="password")
    private String password;
	
	@Column(name="password",insertable = false, updatable = false)
    private String passwordConfirm;
	
	@Column(name="roles")
    private String roles;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long id) {
        this.userId = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Transient
    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }
    
    public String toString() {
        return "UserId: " + this.userId + ", Username: " + this.username + 
        		", Password: " + this.password + ", Roles: " + 
        		this.roles + ")";
    }
}
