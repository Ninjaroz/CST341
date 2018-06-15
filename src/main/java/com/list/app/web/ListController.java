package com.list.app.web;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.list.app.model.ListItems;
import com.list.app.service.ListService;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

@Controller
public class ListController {
	
    @Autowired
    private ListService listService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String displayList(Model model, HttpServletRequest request) {   	
    	model.addAttribute("today", new Date());
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
        	model.addAttribute("userName", authentication.getName().toString());
        }
        return "list";
    }
    
    @RequestMapping(value = "/addList", method = RequestMethod.POST,  headers = "Accept=application/json")
    public void addList(@RequestBody ListItems listItems) {   	
    	List<ListItems> listExists = listService.findListByUserIdAndDate(listItems);
    	if (listExists.isEmpty()) {
    		System.out.println("record does not already exist for today....");
    		listService.save(listItems);
    	} else {
    		System.out.println("record exists for today....");
    		listService.update(listItems);
    	}
    }
    
    @RequestMapping(value = "/removeList", method = RequestMethod.POST)
    public void removeList(@RequestBody ListItems list) { 
    	listService.remove(list);
    }
}
