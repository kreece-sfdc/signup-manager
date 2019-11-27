@isTest
public class SignupHelperTests 
{
    @testSetup
    static void setup()
    {
        Signup_Counter__c counter = new Signup_Counter__c
            (
                Index__c = 1,
                Domain__c = 'test-domain-retsuk-{0}',
                Username__c = 'user-retsuk-{0}@test.org'
            );
        insert counter;
    }
    
	@isTest
    static void getSignupCounter()
    {
        Signup_Counter__c counter = SignupHelper.getSignupCounter();
        system.assertEquals(1, counter.Index__c);
    }
    
    @isTest
    static void incrementSignupCounter()
    {
        SignupHelper.incrementSignupCounter();
        Signup_Counter__c counter = SignupHelper.getSignupCounter();
        system.assertEquals(2, counter.Index__c);
    }
    
    @isTest
    static void createSignupRequestByEdition()
    {
        Id srId = SignupHelper.createSignupRequestByEdition('Test', 'GB', 'Partner Enterprise', 'kreece@salesforce.com', 'Kevin', 'Reece', 'English');
        system.assertNotEquals(null, srId);
    }
    
    @isTest
    static void createSignupRequestByTemplateId()
    {
        Id srId = SignupHelper.createSignupRequestByTemplateId('Test', 'GB', 'kreece@salesforce.com', 'Kevin', 'Reece', 'English', '0TTf4000007WoVC');
        system.assertNotEquals(null, srId);
    }
    
    @isTest
    static void getSignupRequestStatus()
    {
        Id srId = SignupHelper.createSignupRequestByEdition('Test', 'GB', 'Partner Enterprise', 'kreece@salesforce.com', 'Kevin', 'Reece', 'English');
        string status = SignupHelper.getSignupRequestStatus(srId);
        system.assertNotEquals(null, status);
    }
    
    @isTest
    static void getSignupRequestStatusNull()
    {
        string status = SignupHelper.getSignupRequestStatus(UserInfo.getOrganizationId());
        system.assertEquals(null, status);
    }
}