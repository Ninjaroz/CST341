/**
 * 
 * The List Controller manages the list page  
 * It populates a list for a user based on the date and user currently logged in
 * 
 *  @author Gary
 *  @version 1.0
 *  @since 2018-06-18
 */

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
import com.list.app.service.UserServiceImpl;
import com.list.app.model.User;

@Controller
public class ListController {
	
    @Autowired
    private ListService listService;
    
    @Autowired
	private UserServiceImpl userService;
    
    /**
     * This method loads the list page
     * @return Returns list page
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String displayList(Model model, HttpServletRequest request) {   	
    	model.addAttribute("today", new Date());
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
        	model.addAttribute("userName", authentication.getName().toString());
        	//loads list items
        	ListItems nList = new ListItems();
        	nList.setDate(new Date());
        	User user = userService.findByUsername(authentication.getName().toString());
        	nList.setUserId(user.getUserId().intValue());
        	List<ListItems> nListItems = listService.findListByUserIdAndDate(nList);
        	model.addAttribute("listItems", nListItems);
        }
        return "list";
    }
    
    /**
     * This method checks if there is an existing list already and either creates a new list
     * or updates an existing list
     * @param ListItems 
     * @return Nothing.
     */
    @RequestMapping(value = "/addList", method = RequestMethod.POST,  headers = "Accept=application/json")
    public void addList(@RequestBody ListItems listItems) {   	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	User user = userService.findByUsername(authentication.getName().toString());
    	listItems.setUserId(user.getUserId().intValue());
    	
    	List<ListItems> listExists = listService.findListByUserIdAndDate(listItems);
    	if (listExists.isEmpty()) {
    		System.out.println("record does not already exist for today....");
    		listService.save(listItems);
    	} else {
    		System.out.println("record exists for today....");
    		listService.update(listItems);
    	}
    }
 
    /**
     * This method removes a list from the database
     * @param ListItems 
     * @return Nothing.
     */
    @RequestMapping(value = "/removeList", method = RequestMethod.POST)
    public void removeList(@RequestBody ListItems list) { 
    	listService.remove(list);
    }
}
