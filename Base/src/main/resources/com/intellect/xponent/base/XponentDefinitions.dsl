[condition][]LOB name is "{LOB}"=$STPRulesResponseBean:STPRulesResponseBean(); $commlPolicyInfoBean : CommlPolicyInfoBean();$lobInfo: LOBInfoBean(lob.equalsIgnoreCase("{LOB}"),qSize:quotes.size(),lossSize:losses.size()) from $commlPolicyInfoBean.getLobs()
[condition][]check STP "{STP}"=HashMap(this["{STP}"] == null || this["{STP}"]==true) from $STPRulesResponseBean.resultMap
[condition][]size of quotes is greater than {size}=Boolean(booleanValue==true) from qSize >{size}
[condition][]atleast one quote =$quoteInfo: QuoteInfoBean(premAmt:premium.getAmount() ) from $lobInfo.getQuotes()[condition][]schedule =$scheduleInfo : ScheduleInfoBean()from $lobInfo.getSchedules()[condition][]risk information is "{descr}"= $riskInfo: RiskInfoBean(description.equalsIgnoreCase("{descr}")) from $quoteInfo.getRiskinfos()
[condition][]and coverage name is "{coverageName}"=  $coverageInfo: CoverageInfoBean(coverageName.equalsIgnoreCase("{coverageName}")) from $riskInfo.getCoverages()
[condition][]limit amount is greater than {amount} and limit applies on "{coverage}"=$limitInfo: LimitInfoBean(limitAmt:currency.getAmount() > {amount} ,limitAppliesTo.equalsIgnoreCase("{coverage}")) from $coverageInfo.getLimits()
[condition][]code is "{Location}" =$scheduleGroupInfo:ScheduleGroupInfoBean(scheduleCode =="{Location}",scheduleItems:scheduleItems.size()) from $scheduleInfo.getScheduleGroups();
[condition][]and items size is greater than {size}=Boolean(booleanValue==true) from scheduleItems > {size}
[condition][]item's =$scheduleItemInfoBean : ScheduleItemInfoBean() from $scheduleGroupInfo.getScheduleItems();
[condition][]property name is "{name}" =$schedulePropertyInfoBean : SchedulePropertyInfoBean(propertyName=="{name}" , propValue:propertyValue)
[condition][]and values are \("{value1}", "{value2}", "{value3}"\)=eval(propValue=="{value1}"||propValue== "{value2}"||propValue== "{value3}")
[condition][]and fire protection class values are \("{value1}", "{value2}", "{value3}", "{value4}", "{value5}", "{value6}", "{value7}", "{value8}", "{value9}", "{value10}"\)=eval(propValue != "{value1}"||propValue !=  "{value2}"||propValue !=  "{value3}"||propValue !=  "{value4}"||propValue !=  "{value5}"||propValue !=  "{value6}"||propValue !=  "{value7}"||propValue !=  "{value8}"||propValue !=  "{value9}"||propValue !=  "{value10}")
[condition][]or=or

[condition][]loss size is greater than {lossSize}=Boolean(booleanValue==true) from lossSize > {lossSize}
[condition][] premium amount is greater than {amount}=Boolean(booleanValue==true) from premAmt> {amount}
[condition][]previous insurance size is equal to {previousInsurancesSize}=Boolean(booleanValue==true) from $lobInfo.getPreviousInsurances.size() == {previousInsurancesSize}
[condition][]or previous insurance details are not entered for previous year=not( PreviousInsuranceInfoBean( java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)-1 == OperationHelper.getYear(getPolicyEffectiveDate())) from $lobInfo.getPreviousInsurances())
[condition][]question number is "{ques}" =$questionInfo: UWQuestionInfoBean("{ques}".equalsIgnoreCase(questionNumber),responseValue:response)from $lobInfo.getQuestions()
[condition][]and response is "{resp}"=Boolean(booleanValue==true) from "{resp}".equalsIgnoreCase(responseValue)
[condition][]and location building values  are \("{value1}", "{value2}", "{value3}", "{value4}", "{value5}"\)=eval(propValue != "{value1}"||propValue != "{value2}"||propValue != "{value3}"||propValue != "{value4}"||propValue != "{value5}")
[condition][]and net loss values does not {value}=Boolean(booleanValue==true) from propValue != {value}



[consequence][]log: "{message}"=System.out.println("{message}");
[consequence][]set status \("{ruleName}", "{status}", "{seqNum}", "{currency}", {qSize}\) =$STPRulesResponseBean.getRuleStatusBeans().add(setRuleStatusDSL("{ruleName}","{status}","{seqNum}",String.valueOf({qSize}),"{currency}"));
[consequence][]rule response \("{STP}", {false}\)=$STPRulesResponseBean.getResultMap().put("{STP}",new Boolean({false}));update($STPRulesResponseBean);
[consequence][]rule response with quoteId \("{STP}", {false}\)=$STPRulesResponseBean.getResultMap().put("{STP}"+$quoteInfo.getQuoteId(),new Boolean({false}));update($STPRulesResponseBean);
[consequence][]set focus "{focus}"=drools.setFocus("{focus}");
