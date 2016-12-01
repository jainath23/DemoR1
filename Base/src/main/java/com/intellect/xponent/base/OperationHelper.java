package com.intellect.xponent.base;

import com.seec.insurance.rules.beans.STPRulesResponseBean;
import com.seec.insurance.pc.comml.application.workflowmgmt.beans.RulesStatusBean;
import java.util.Date;
import java.util.Calendar;
/**
 * This class was automatically generated by the data modeler tool.
 */

public class OperationHelper implements java.io.Serializable {

    static final long serialVersionUID = 1L;

    public OperationHelper() {
    }
     public static Boolean addRuleStatus(STPRulesResponseBean resBean, RulesStatusBean rulesBean){
        resBean.getRuleStatusBeans().add(rulesBean);
        return true;
    }
    public static int getYear(Date dt){
        Calendar c = Calendar.getInstance();
		c.setTime(dt);
		return c.get(Calendar.YEAR);
    }
}