public with sharing class ViewS3ObjectController {
	public AWS_S3_Object__c image {get; set;}

	public ViewS3ObjectController() {
		image = [SELECT Id, Name, File_Name__c, Content_Type__c, Bucket_Name__c, (SELECT Id, Confidence__c, Label__c FROM Classifications__r ORDER BY Confidence__c DESC) FROM AWS_S3_Object__c WHERE Id = :System.currentPageReference().getParameters().get('id')];	
	}
}