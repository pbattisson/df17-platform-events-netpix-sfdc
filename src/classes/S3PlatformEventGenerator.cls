public with sharing class S3PlatformEventGenerator {
	@InvocableMethod(label='Create S3 Upload Patform Event' description='Creates a platform event that signifies the S3 image has been uploaded')
	public static void createEvents(List<AWS_S3_Object__c> s3Objects) {

		List<Image_Upload__e> uploads = new List<Image_Upload__e>();

		for(AWS_S3_Object__c s3Obj : s3Objects) {		
			Image_Upload__e upload = new Image_Upload__e();
			upload.S3_URL__c = 'https://s3-us-west-1.amazonaws.com/' + s3Obj.Bucket_Name__c + '/' + s3Obj.File_Name__c;
			upload.RecordId__c = s3Obj.Id;	
			uploads.add(upload);
		}
		
		EventBus.publish(uploads);

	}

	public static void demoTime(Id s3ObjectId) {
		createEvents([SELECT Id, Bucket_Name__c, File_Name__c, Content_Type__c FROM AWS_S3_Object__c WHERE Id = :s3ObjectId]);
	}
}