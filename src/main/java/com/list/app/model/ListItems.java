package com.list.app.model;

import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "list_items")
public class ListItems {
		@Id
		@Column(name="list_id")
		@GeneratedValue(strategy=GenerationType.AUTO)
	    private Long id;
		
		@Column(name="list_items")
	    private String listItems;
	    
		@Column(name="date")
	    private Date date;
		
		@Column(name="user_id")
		private Integer userId;

		/**
		 * @return the id
		 */
		public Long getId() {
			return id;
		}

		/**
		 * @param id the id to set
		 */
		public void setId(Long id) {
			this.id = id;
		}

		/**
		 * @return the name
		 */
		public String getListItems() {
			return listItems;
		}

		/**
		 * @param name the name to set
		 */
		public void setListItems(String listItems) {
			this.listItems = listItems;
		}

		/**
		 * @return the users
		 */
		public Date getDate() {
			return date;
		}

		/**
		 * @param users the users to set
		 */
		public void setDate(Date date) {
			this.date = date;
		}

		/**
		 * @return the userId
		 */
		public Integer getUserId() {
			return userId;
		}

		/**
		 * @param userId the userId to set
		 */
		public void setUserId(Integer userId) {
			this.userId = userId;
		}
		
		public String toString() {
			return "listId: " + this.id + ", listItems: " + this.listItems + ", date: " + this.date.toString() + ", userId: " + this.userId;
		}
}
