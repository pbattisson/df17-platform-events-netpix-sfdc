public with sharing class ListS3ObjectsController {
	
	public List<AWS_S3_Object__c> images {get; set;}

	public ListS3ObjectsController() {
		images = [SELECT Id, Name, File_Name__c, Content_Type__c, Bucket_Name__c FROM AWS_S3_Object__c ORDER BY Name DESC];
	}
}