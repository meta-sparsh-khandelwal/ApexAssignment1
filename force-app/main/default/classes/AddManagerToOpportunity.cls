public class AddManagerToOpportunity {
    public static List<Opportunity> addOpportunityManager(List<Opportunity> opportunityList) {
        List<Opportunity> updateOpportunity = new List<Opportunity>();
        for(Opportunity opp : opportunityList) {
            if(opp.BillToContact__c != null && opp.Manager__c == null) {
                opp.Manager__c = opp.BillToContact__r.Account.Id;
            }
            updateOpportunity.add(opp);
        }
        return updateOpportunity;
    }
}
