// @isTest
// private class HerokuProcessorTest {

//     @isTest
//     static void testMakeGetCallout() {
//         // Set up mock HTTP response
//         HttpMock mock = new HerokuMock();
//         Test.setMock(HttpCalloutMock.class, mock);

//         // Call the method to test
//         Test.startTest();
//         HttpResponse response = HerokuProcessor.makeGetCallout();
//         Test.stopTest();

//         // Verify the response
//         System.assertEquals(200, response.getStatusCode());
//     }

//     @isTest
//     static void testMakePostCallout() {
//         // Set up mock HTTP response
//         HttpMock mock = new HerokuMock();
//         Test.setMock(HttpCalloutMock.class, mock);

//         // Call the method to test
//         Test.startTest();
//         HttpResponse response = HerokuProcessor.makePostCallout();
//         Test.stopTest();

//         // Verify the response
//         System.assertEquals(201, response.getStatusCode());
//     }

//     // Mock class for HTTP callouts
//     private class HerokuMock implements HttpCalloutMock {
//         public HTTPResponse respond(HTTPRequest req) {
//             HttpResponse res = new HttpResponse();
//             res.setHeader('Content-Type', 'application/json');
//             res.setBody('{"AccountStatus": "Enabled", "AccountNumber": "123", "AccountName": "Test", "AsOfDate": "2023-12-01"}');
//             res.setStatusCode(200);
//             return res;
//         }
//     }
// }
