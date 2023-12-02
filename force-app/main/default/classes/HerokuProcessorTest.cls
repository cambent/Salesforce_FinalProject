@isTest
public class HerokuProcessorTest {
    @isTest
    static void testMakeGetCallout() {
        Test.startTest();
        HerokuProcessor processor = new HerokuProcessor();
        HttpResponse response = processor.makeGetCallout();
        Test.stopTest();

        // Add assertions based on the expected behavior
        System.assertNotEquals(null, response);
    }
}
