package com.list.app.model;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "user_role", schema = "listapp")
public class Role {
	@Id
	@Column(name="role_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
	
	@Column(name="name")
    private String name;
    
	@Column(name="users")
    private String users;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }
}
