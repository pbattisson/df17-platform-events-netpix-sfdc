/**
  * Author: Paul Battisson (@pbattisson)
  * Description: This class acts as the controller for the ImageUpload Visualforce page and enables a user to upload a file to S3
  */
public with sharing class ImageUploadController {
	
	private String AWSCredentialName = 'S3 Developer';
	
	public String bucketToUploadObject = 'netrixdf17';
	public String accessTypeSelected = 'private';
	public String OwnerId = '767da6eb3182d0565d3e82f54c222c650486dbe19c55c58746f0823c9a352f05';
    public Blob fileBlob {get;set;}
    public Integer fileSize {get;set;}
    public String fileName {get;set;}
	public String S3Key {get; set;}
	public S3.AmazonS3 as3 { get; private set; } //This object represents an instance of the Amazon S3 toolkit and makes all the Web Service calls to AWS. 
	public String uploadObjectErrorMsg {get; private set;}

	public ImageUploadController() {
		loadS3Credentials();
	}

	private PageReference loadS3Credentials() {
    	try {
			AWSKeys credentials = new AWSKeys(AWSCredentialName);
			as3 = new S3.AmazonS3(credentials.key,credentials.secret);
			S3Key = credentials.key;		
		} catch(AWSKeys.AWSKeysException AWSEx){
		     System.debug('$$$Caught exception in AWS_S3_ExampleController: ' + AWSEx);
		     ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.FATAL, AWSEx.getMessage());
			 ApexPages.addMessage(errorMsg); 
		}
       	return null;	
    }

	/*
	    This method uploads a file from the filesystem and puts it in S3. 
	    It also supports setting the Access Control policy. 
	*/
	public pageReference uploadImage(){
		try {  
			Datetime now = Datetime.now();
			
			String docBody = EncodingUtil.base64Encode(fileBlob);
			
			//TODO - make sure doc.bodyLength is not greater than 100000 to avoid apex limits
			System.debug('body length: ' + fileSize);
			uploadObjectErrorMsg = 'Error';
			Boolean putObjResult = as3.PutObjectInline_ACL(bucketToUploadObject,fileName,null,docBody,fileSize,accessTypeSelected,as3.key,now,as3.signature('PutObjectInline',now),as3.secret, OwnerId);
			if(putObjResult==true){
				System.debug('putobjectinline successful');
				uploadObjectErrorMsg = 'Success';
			}
	  	} catch(System.CalloutException callout){
		  System.debug('CALLOUT EXCEPTION: ' + callout);
		  uploadObjectErrorMsg = 	callout.getMessage();
 	
	    } catch(Exception ex){
		    System.debug('EXCEPTION: ' + ex);
		    uploadObjectErrorMsg = 	ex.getMessage();
		}
	   
	  return null;	
	}

}