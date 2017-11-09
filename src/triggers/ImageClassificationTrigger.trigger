trigger ImageClassificationTrigger on Image_Classification__e (after insert) {

	List<Classification__c> classifications = new List<Classification__c>();

	for(Image_Classification__e result : Trigger.new) {
		Classification__c classification = new Classification__c();
		classification.AWS_S3_Object__c = result.Record_Id__c;
		classification.Confidence__c = result.Confidence__c;
		classification.Label__c = result.Classification__c;
		classifications.add(classification);
	}

	insert classifications;

}