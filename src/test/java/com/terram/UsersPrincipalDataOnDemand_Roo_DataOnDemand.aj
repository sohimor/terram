// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.terram;

import com.terram.UsersPrincipal;
import com.terram.UsersPrincipalDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect UsersPrincipalDataOnDemand_Roo_DataOnDemand {
    
    declare @type: UsersPrincipalDataOnDemand: @Component;
    
    private Random UsersPrincipalDataOnDemand.rnd = new SecureRandom();
    
    private List<UsersPrincipal> UsersPrincipalDataOnDemand.data;
    
    public UsersPrincipal UsersPrincipalDataOnDemand.getNewTransientUsersPrincipal(int index) {
        UsersPrincipal obj = new UsersPrincipal();
        return obj;
    }
    
    public UsersPrincipal UsersPrincipalDataOnDemand.getSpecificUsersPrincipal(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        UsersPrincipal obj = data.get(index);
        Long id = obj.getId();
        return UsersPrincipal.findUsersPrincipal(id);
    }
    
    public UsersPrincipal UsersPrincipalDataOnDemand.getRandomUsersPrincipal() {
        init();
        UsersPrincipal obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return UsersPrincipal.findUsersPrincipal(id);
    }
    
    public boolean UsersPrincipalDataOnDemand.modifyUsersPrincipal(UsersPrincipal obj) {
        return false;
    }
    
    public void UsersPrincipalDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = UsersPrincipal.findUsersPrincipalEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'UsersPrincipal' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<UsersPrincipal>();
        for (int i = 0; i < 10; i++) {
            UsersPrincipal obj = getNewTransientUsersPrincipal(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
