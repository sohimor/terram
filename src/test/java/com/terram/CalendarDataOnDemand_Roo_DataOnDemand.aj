// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.terram;

import com.terram.Calendar;
import com.terram.CalendarDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect CalendarDataOnDemand_Roo_DataOnDemand {
    
    declare @type: CalendarDataOnDemand: @Component;
    
    private Random CalendarDataOnDemand.rnd = new SecureRandom();
    
    private List<Calendar> CalendarDataOnDemand.data;
    
    public Calendar CalendarDataOnDemand.getNewTransientCalendar(int index) {
        Calendar obj = new Calendar();
        return obj;
    }
    
    public Calendar CalendarDataOnDemand.getSpecificCalendar(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Calendar obj = data.get(index);
        Long id = obj.getId();
        return Calendar.findCalendar(id);
    }
    
    public Calendar CalendarDataOnDemand.getRandomCalendar() {
        init();
        Calendar obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Calendar.findCalendar(id);
    }
    
    public boolean CalendarDataOnDemand.modifyCalendar(Calendar obj) {
        return false;
    }
    
    public void CalendarDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Calendar.findCalendarEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Calendar' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Calendar>();
        for (int i = 0; i < 10; i++) {
            Calendar obj = getNewTransientCalendar(i);
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
