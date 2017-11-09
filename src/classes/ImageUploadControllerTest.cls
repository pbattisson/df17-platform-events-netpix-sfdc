/**
	Author: Paul Battisson (@pbattisson)
	Description: Test class for the ImageUploadController
 */
@isTest
public with sharing class ImageUploadControllerTest {

	private static final String TEST_CRED_NAME = 'S3 Developer';
	private static final String TEST_CRED_KEY = 'TESTING1234';
	private static final String TEST_CRED_SECRET = 'SECRET1234567';

	private static void createTestS3Credentials() {
		AWSKey__c testKey = new AWSKey__c();
		testKey.Name = TEST_CRED_NAME;
		testKey.Key__c = TEST_CRED_KEY;
		testKey.Secret__c = TEST_CRED_SECRET;
		insert testKey;
	}
	
	@isTest
	private static void testInstantiateController() {
		createTestS3Credentials();
		Test.setCurrentPage(Page.ImageUpload);
		ImageUploadController ctrl = new ImageUploadController();
		System.assertNotEquals(null, ctrl.as3, ApexPages.getmessages());
		System.assertEquals(TEST_CRED_KEY, ctrl.S3Key);
	}

	@isTest
	private static void testInstantiateControllerNoCredsError() {
		Test.setCurrentPage(Page.ImageUpload);
		ImageUploadController ctrl = new ImageUploadController();
		System.assert(ApexPages.hasMessages());
	}
}