package com.list.app.web;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class ListController {

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String registration(Model model) {

        return "list";
    }
}
