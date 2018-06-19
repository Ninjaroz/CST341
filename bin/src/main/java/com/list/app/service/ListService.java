package com.list.app.service;

import java.util.List;

import com.list.app.model.ListItems;

public interface ListService {
	  void save(ListItems list);
	  List<ListItems> findListByUserIdAndDate(ListItems listItems);
	  void remove(ListItems list);
	  void update(ListItems list);
}
