// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.terram;

import com.terram.Code;
import com.terram.CodeDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect CodeDataOnDemand_Roo_DataOnDemand {
    
    declare @type: CodeDataOnDemand: @Component;
    
    private Random CodeDataOnDemand.rnd = new SecureRandom();
    
    private List<Code> CodeDataOnDemand.data;
    
    public Code CodeDataOnDemand.getNewTransientCode(int index) {
        Code obj = new Code();
        return obj;
    }
    
    public Code CodeDataOnDemand.getSpecificCode(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Code obj = data.get(index);
        Long id = obj.getId();
        return Code.findCode(id);
    }
    
    public Code CodeDataOnDemand.getRandomCode() {
        init();
        Code obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Code.findCode(id);
    }
    
    public boolean CodeDataOnDemand.modifyCode(Code obj) {
        return false;
    }
    
    public void CodeDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Code.findCodeEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Code' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Code>();
        for (int i = 0; i < 10; i++) {
            Code obj = getNewTransientCode(i);
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
