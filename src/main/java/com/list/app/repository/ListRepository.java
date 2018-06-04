package com.list.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.list.app.model.ListItems;

public interface ListRepository extends JpaRepository<ListItems, Long>{
	
	//List<ListItems> findListByUserIdAndDate(ListItems listItems);
	//void remove(ListItems list);
}
