trigger NewUserEventTrigger on New_User__e (after insert) {
	
	List<Billing_Schedule__c> schedules = new List<Billing_Schedule__c>();
	Set<Id> userIds = new Set<Id>();
	Map<Id, Id> userIdToAccIdMap = new Map<Id, Id>();

	for(New_User__e newUserEvent : Trigger.new) {
		userIds.add(newUserEvent.User_Id__c);
	}

	for(User u : [SELECT AccountId, Id FROM User WHERE Id in :userIds]) {
		userIdToAccIdMap.put(u.Id, u.AccountId);
	}

	Date created = Date.today();

	for(New_User__e newUserEvent : Trigger.new) {
		Billing_Schedule__c schedule = new Billing_Schedule__c();
		schedule.Person_Account__c = userIdToAccIdMap.get(newUserEvent.User_Id__c);
		schedule.Bill_Date__c = created.addMonths(4).toStartOfMonth();
		schedules.add(schedule);
	}

	insert schedules;
}