package com.list.app.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
	 
	 private static final Logger logger = LoggerFactory.getLogger(SecurityServiceImpl.class);
	 
	 @Override
	 public void save(ListItems list){
		 listRepository.save(list);
	 }
	 
	 @Override
	 public void remove(ListItems list) {
		 em.createQuery("DELETE from list_items where user_id = ?1"
				  + " and date = ?2", ListItems.class)
		 .setParameter(1, list.getUserId())
		 .setParameter(2, list.getDate())
		 .executeUpdate();
	 }
	 
	 @Override
	 public List<ListItems> findListByUserIdAndDate(ListItems list) {
		 return em.createQuery("SELECT l FROM list_items l WHERE l.user_id = ?1"
				 			   + " and l.date = ?2", ListItems.class)
		 .setParameter(1, list.getUserId())
		 .setParameter(2, list.getDate())
		 .getResultList();
	 }
}
