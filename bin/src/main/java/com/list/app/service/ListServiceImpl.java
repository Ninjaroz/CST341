/**
 * 
 * The ListServiceImpl class queries the database to update the list_items table 
 * 
 *  @author Gary
 *  @version 1.0
 *  @since 2018-06-18
 */


package com.list.app.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import com.list.app.repository.ListRepository;
import com.list.app.model.ListItems;

@Service
public class ListServiceImpl implements ListService {
	
	 @PersistenceContext
	  	private EntityManager em;	 
	  
	 @Autowired
	    private ListRepository listRepository;
	 
	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	 
	 private static final Logger logger = LoggerFactory.getLogger(SecurityServiceImpl.class);
	 
	 @Override
	 public void save(ListItems list){
		 listRepository.save(list);
	 }
	 	 
	 @Override
	 @Transactional 
	 public void update(ListItems list) {
		 logger.debug(("Find list by userid and date. list user id: " + list.getUserId() + ", date: " + sdf.format((list.getDate()))));
		 em.createQuery("UPDATE ListItems SET listItems = ?1" +
		 				" where userId = ?2 and date = '"+ sdf.format((list.getDate()))+ "'")
		 .setParameter(1, list.getListItems())
		 .setParameter(2, list.getUserId())
		 .executeUpdate();
	 }
	 
	 @Override
	 @Transactional 
	 public void remove(ListItems list) {
		 logger.debug(("Delete listItems where userId: " + list.getUserId() + ", and date: " + sdf.format((list.getDate()))));
		 em.createQuery("DELETE from ListItems where userId = ?1"
				  + " and date = '"+ sdf.format((list.getDate()))+ "'")
		 .setParameter(1, list.getUserId())
		 .executeUpdate();
	 }
	 
	 @Override
	 public List<ListItems> findListByUserIdAndDate(ListItems list) {
		 logger.debug(("Find list by userid and date. list user id: " + list.getUserId() + ", date: " + sdf.format((list.getDate()))));
		 return em.createQuery("SELECT l FROM ListItems l WHERE l.userId = ?1"
				 			   + " and l.date = '"+sdf.format((list.getDate()))+"'", ListItems.class)
		 .setParameter(1,list.getUserId().intValue())
		 .getResultList();
	 }
	 
	 
}
