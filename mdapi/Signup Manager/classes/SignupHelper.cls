public class SignupHelper 
{
	public static Signup_Counter__c getSignupCounter()
    {
        return Signup_Counter__c.getOrgDefaults();
    }
    
    public static void incrementSignupCounter()
    {
        Signup_Counter__c counter = getSignupCounter();
        setSignupCounter(counter.Index__c+1);
    }
    
    private static void setSignupCounter(decimal index)
    {
        Signup_Counter__c counter = Signup_Counter__c.getOrgDefaults();
        counter.Index__c = index;
        update counter;
    }
    
    public static Id createSignupRequestByEdition(string company, string countryCode, string edition, string email, string firstName, string lastName, string language)
    {
        Signup_Counter__c counter = getSignupCounter();
        
        SignupRequest sr = new SignupRequest
            (
                Company = company,
                Country = countryCode,
                Edition = edition,
                SignupEmail = email,
                FirstName = firstName,
                LastName = lastName,
                PreferredLanguage = language,
                Subdomain = string.format(counter.Domain__c, new List<object> { counter.Index__c }),
                Username = string.format(counter.Username__c, new List<object> { counter.Index__c })
            );
        
        insert sr;
        
        return sr.Id;
    }
    
    public static Id createSignupRequestByTemplateId(string company, string countryCode, string email, string firstName, string lastName, string language, string templateId)
    {
        Signup_Counter__c counter = getSignupCounter();
        
        SignupRequest sr = new SignupRequest
            (
                Company = company,
                Country = countryCode,
                SignupEmail = email,
                FirstName = firstName,
                LastName = lastName,
                PreferredLanguage = language,
                Subdomain = string.format(counter.Domain__c, new List<object> { counter.Index__c }),
                TemplateId = templateId,
                Username = string.format(counter.Username__c, new List<object> { counter.Index__c })
            );
        
        insert sr;
        
        incrementSignupCounter();
        
        return sr.Id;
    }
    
    public static string getSignupRequestStatus(Id signupRequestId)
    {
        List<SignupRequest> srs = [SELECT Id, Status FROM SignupRequest WHERE Id =: signupRequestId];
        
        if(!srs.isEmpty())
        {
            return srs.get(0).Status;
        }
        
        return null;
    }
}