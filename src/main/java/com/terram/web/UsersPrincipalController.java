package com.terram.web;

import com.terram.UsersPrincipal;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/usersprincipals")
@Controller
@RooWebScaffold(path = "usersprincipals", formBackingObject = UsersPrincipal.class)
public class UsersPrincipalController {
}
